import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:isolated_worker/isolated_worker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Logic/Controllers/main-controller.dart';
import 'package:vodda_providers/Logic/Controllers/notification-controller.dart';
import 'package:vodda_providers/Logic/Controllers/register-controller.dart';
import 'package:vodda_providers/Logic/Helpers/api-methods.dart';
import 'package:vodda_providers/Logic/Helpers/token-methods.dart';
import 'package:vodda_providers/Logic/Models/Settlement.dart';
import 'package:vodda_providers/Logic/Models/account.dart';
import 'package:vodda_providers/Logic/Models/cv-file.dart';
import 'package:vodda_providers/Logic/Models/notification.dart';
import 'package:vodda_providers/Logic/Models/service.dart';
import 'package:vodda_providers/Logic/Models/user.dart';
import 'package:vodda_providers/Public/api-urls.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/Popups/alert-dialog.dart';
import 'package:vodda_providers/UI/Components/Popups/snackbar.dart';
import 'package:vodda_providers/UI/Views/Main/main-index.dart';
import 'package:vodda_providers/UI/Views/Register/register-index.dart';
import 'package:vodda_providers/UI/Views/User/login.dart';
import 'package:vodda_providers/UI/Views/User/verify.dart';

import 'package:image/image.dart' as IMG;
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:vodda_providers/laravel_echo/laravel_echo.dart';
import 'package:latlong2/latlong.dart';

class UserController extends GetxController {
  static Rx<User> user = User().obs;
  static String mobile = '';
  static String verifyCode = '';
  static RxInt timer = 0.obs;

  static LatLng myPosition = LatLng(35.7324556, 51.4229012);

  static RxMap<int, CvFile> cvFiles = <int, CvFile>{}.obs;

  static setCv(text) async {
    AppController.isLoading.value = true;
    var response = await RestApi.post(setCvUrl, body: {'cv': text});
    RestApi.responseHandler(
      response: response,
      successCallback: () async {
        user.value = User.fromJson(response!.data['data']);
        Get.back();
      },
      printResponse: true,
    );

    AppController.isLoading.value = false;
  }

  static uploadCvImage(image) async {
    var response = await RestApi.post(
      uploadCvImageUrl,
      body: {'file': base64.encode(image)},
    );
    RestApi.responseHandler(
      response: response,
      successCallback: () async {
        CvFile cvFile = CvFile.fromJson(response!.data['data']);
        cvFiles[cvFile.id!] = cvFile;
      },
      printResponse: true,
    );
  }

  static deleteCvFile(int id) async {
    var response = await RestApi.post(deleteCvFileUrl, body: {'id': id});
    RestApi.responseHandler(
      response: response,
      successCallback: () async {
        cvFiles.remove(id);
      },
      printResponse: true,
    );
  }

  static getCvFiles() async {
    AppController.isLoading.value = true;
    var response = await RestApi.get(getCvFilesUrl);
    RestApi.responseHandler(
      response: response,
      successCallback: () async {
        cvFiles.value = <int, CvFile>{};
        for (var json in response!.data['data']) {
          CvFile cvFile = CvFile.fromJson(json);
          cvFiles[cvFile.id!] = cvFile;
        }
      },
      printResponse: true,
    );

    AppController.isLoading.value = false;
  }

  static getUser() async {
    if (await Token.getToken() != null) {
      var response = await RestApi.get(getUserUrl);
      RestApi.responseHandler(
        response: response,
        successCallback: () async {
          user.value = User.fromJson(response!.data['data']);
          await Token.setNotifToken(user.value.notificationToken!);
          await Token.setServicesToken(user.value.services);
          await Token.setProvinceNotif(user.value.provinceNotifToken!);
          if (user.value.state == 3) {
            Get.put(NotificationController());
          }
        },
        printResponse: true,
        popupMessage: false,
      );
    } else
      user.value = User();
  }

  static login() async {
    AppController.isLoading.value = true;
    var response = await RestApi.post(
      loginUrl,
      body: {'mobile': int.parse(mobile)},
    );
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        timer.value = 59;
        const oneSec = const Duration(seconds: 1);
        new Timer.periodic(oneSec, (Timer t) {
          if (timer.value == 0) {
            t.cancel();
          } else {
            timer.value--;
          }
        });
        Navigator.pushReplacement(
          Get.context!,
          MaterialPageRoute(builder: (builder) => Verify()),
        );
      },
    );
    AppController.isLoading.value = false;
  }

  static logout() async {
    AppController.isLoading.value = true;
    var response = await RestApi.post(logoutUrl);
    RestApi.responseHandler(
      response: response,
      successCallback: () async {
        await Token.removeToken();
        RegisterController.getProvinces();
        RegisterController.getCategories();
        RegisterController.getInfoDocument();
        Navigator.pushReplacement(
          Get.context!,
          MaterialPageRoute(builder: (builder) => Login()),
        );
      },
    );

    AppController.isLoading.value = false;
  }

  static verify() async {
    AppController.isLoading.value = true;
    var response = await RestApi.post(
      verifyUrl,
      body: {'mobile': int.parse(mobile), 'verify_code': verifyCode},
    );
    await RestApi.responseHandler(
      response: response,
      successCallback: () async {
        user.value = User.fromJson(response!.data['data']['user']);
        await Token.setToken(response.data['data']['token']);
        if (UserController.user.value.state != 3) {
          if (UserController.user.value.state == 1)
            RegisterController.registerStep.value = 4;
          else if (user.value.provinceId != null) {
            RegisterController.cities.value =
                RegisterController.provinces[user.value.provinceId]!.cities;
          }

          Navigator.pushReplacement(
            Get.context!,
            MaterialPageRoute(builder: (builder) => RegisterIndex()),
          );
        } else {
          await getUser();
          // await MainController.getMyOrders();
          // await MainController.getMyOrdersWithDate();
          // await MainController.getSugestedOrders();
          // await MainController.getSettlement();
          // await MainController.getAccounts();
          // await MainController.getWallet();
          // await MainController.getFinancial();
          await MainController.getUserInfo();
          Navigator.pushReplacement(
            Get.context!,
            MaterialPageRoute(builder: (builder) => MainIndex()),
          );
        }
      },
    );
    AppController.isLoading.value = false;
  }

  static chooseProfile(ImageSource imageSource) async {
    if ((!kIsWeb && await Permission.storage.request().isGranted) || kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(
        source: imageSource,
        maxHeight: 1000,
        maxWidth: 1000,
      );
      if (image != null) {
        final croppedFile = await ImageCropper().cropImage(
          sourcePath: image.path,

          // compressFormat: ImageCompressFormat.jpg,
          // cropStyle: CropStyle.circle,
          compressQuality: 100,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'بریدن',

              toolbarColor: AppController.primaryColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true,
              hideBottomControls: true,
            ),
            WebUiSettings(
              context: Get.context!,
              // presentStyle: CropperPresentStyle.page,
              // boundary: CroppieBoundary(
              //   width:
              //       maxItemWidth >
              //           MediaQuery.of(Get.context!).size.width.toInt()
              //       ? MediaQuery.of(Get.context!).size.width.toInt() -
              //             paddingSize.toInt()
              //       : maxItemWidth.toInt(),
              //   height:
              //       maxItemWidth >
              //           MediaQuery.of(Get.context!).size.width.toInt()
              //       ? MediaQuery.of(Get.context!).size.width.toInt() -
              //             paddingSize.toInt()
              //       : maxItemWidth.toInt(),
              // ),
              // viewPort: CroppieViewPort(
              //   width:
              //       maxItemWidth >
              //           MediaQuery.of(Get.context!).size.width.toInt()
              //       ? MediaQuery.of(Get.context!).size.width.toInt() -
              //             paddingSize.toInt()
              //       : maxItemWidth.toInt(),
              //   height:
              //       maxItemWidth >
              //           MediaQuery.of(Get.context!).size.width.toInt()
              //       ? MediaQuery.of(Get.context!).size.width.toInt() -
              //             paddingSize.toInt()
              //       : maxItemWidth.toInt(),
              //   type: 'circle',
              // ),
              // enableExif: true,
              // enableZoom: true,
              // mouseWheelZoom: true,
              // enableOrientation: true,
              // enableResize: true,
              // enforceBoundary: true,
              // showZoomer: false,
            ),
          ],
        );
        if (croppedFile != null) {
          AppController.isLoading.value = true;

          // Uint8List? selectedImage=await FlutterImageCompress.compressWithFile(
          //   croppedFile.path,
          //   minWidth: 200,
          //   minHeight: 200,
          //   quality: 100,
          // );

          Uint8List selectedImage = await croppedFile.readAsBytes();

          // await IsolatedWorker()
          //     .run(ReduceImageQualityAndSize, selectedImage)
          //     .then((value) {
          //   selectedImage = value;
          // });

          var response = await RestApi.post(
            avatarUrl,
            body: {'file': base64.encode(selectedImage)},
          );
          RestApi.responseHandler(
            response: response,
            successCallback: () {
              user.value = User.fromJson(response!.data['data']);
            },
          );
          AppController.isLoading.value = false;
        }
      } else {
        print("No file selected");
      }
    }
  }

  static Future<Uint8List> ReduceImageQualityAndSize(Uint8List image) async {
    int maxInBytes = 500000;
    Uint8List resizedData = Uint8List.fromList(image);

    IMG.Image? img = await IMG.decodeImage(image);
    int size = await image.lengthInBytes;
    int quality = 100;

    print("size max: " + maxInBytes.toString());
    print("size before: " + size.toString() + " bytes");

    while (size > maxInBytes && quality > 10) {
      // reduce image size about 10% of image, until the size is less than the maximum limit
      quality = (quality - (quality * 0.1)).toInt();
      int width = img!.width - (img.width * 0.1).toInt();
      IMG.Image resized = await IMG.copyResize(img, width: width);
      resizedData = await Uint8List.fromList(
        IMG.encodeJpg(resized, quality: quality),
      );
      size = await resizedData.lengthInBytes;
      img = resized;
    }

    print("size after: " + size.toString() + " bytes");

    return resizedData;
  }

  static Future<bool> getMyLocation() async {
    print('start determine');
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      print(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
      return false;
    }
    print('end determine');
    Position myLocation = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    myPosition = LatLng(myLocation.latitude, myLocation.longitude);

    return true;
  }
}
