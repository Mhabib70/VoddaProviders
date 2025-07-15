import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:vodda_providers/Logic/Controllers/main-controller.dart';
import 'package:vodda_providers/Logic/Controllers/register-controller.dart';
import 'package:vodda_providers/Logic/Controllers/user-controller.dart';
import 'package:vodda_providers/Logic/Helpers/api-methods.dart';
import 'package:vodda_providers/Logic/Helpers/token-methods.dart';
import 'package:vodda_providers/Logic/Models/city.dart';
import 'package:vodda_providers/Logic/Models/document.dart';
import 'package:vodda_providers/Logic/Models/link-menu.dart';
import 'package:vodda_providers/Logic/Models/province.dart';
import 'package:vodda_providers/Logic/Models/service.dart';
import 'package:vodda_providers/Logic/Models/app-version.dart';
import 'package:vodda_providers/Public/api-urls.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/Buttons/btn.dart';
import 'package:vodda_providers/UI/Components/General/page-route.dart';
import 'package:vodda_providers/UI/Components/Popups/alert-dialog.dart';
import 'package:vodda_providers/UI/Views/Main/main-index.dart';
import 'package:vodda_providers/UI/Views/Register/register-confirm.dart';
import 'package:vodda_providers/UI/Views/Register/register-index.dart';
import 'package:vodda_providers/UI/Views/User/login.dart';

import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher_string.dart';

enum fontTypes {
  heading1,
  heading2,
  heading3,
  heading4,
  heading5,
  text1,
  text2,
}

class AppController extends GetxController {
  static RxBool isLoading = false.obs;
  static const String baseUrl = 'https://vodda.ir';
  static String logo = 'assets/logos/logo.png';
  static Color primaryColor = Color(0xff006B57);
  static String title = 'ودا';
  static Map<String, dynamic> setting = <String, dynamic>{};

  static List<LinkMenu> sidebarLinks = [];

  static AppVersion? newVersion;

  static fontStyle(fontTypes fontType, Color itemColor) {
    switch (fontType) {
      case fontTypes.heading1:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w600,
          fontSize: 32,
        );
      case fontTypes.heading2:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w600,
          fontSize: 23,
        );
      case fontTypes.heading3:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w500,
          fontSize: 19,
        );
      case fontTypes.heading4:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w500,
          fontSize: 17,
        );
      case fontTypes.heading5:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w400,
          fontSize: 15,
        );
      case fontTypes.text1:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w400,
          fontSize: 13,
        );
      case fontTypes.text2:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w300,
          fontSize: 18,
        );
    }
  }

  static priceFormat(num value) {
    NumberFormat myFormat = NumberFormat.decimalPattern();
    return myFormat.format(value);
  }

  static getAppSetting() async {
    var response = await RestApi.get(settingUrl);
    RestApi.responseHandler(
      response: response,
      successCallback: () async {
        // title=response!.data['data']['name'];
        // logo=response.data['data']['logo'];
        // primaryColor=Color(int.parse('0xff${response.data['data']['theme_color'].replaceAll('#', '')}'));
        setting = response!.data['data']['setting'];
        for (var json in response.data['data']['versions']) {
          if (json['name'] == 'provider') {
            PackageInfo packageInfo = await PackageInfo.fromPlatform();
            String currentVersion = packageInfo.version;
            String lastVersion = json['version'];
            print('curretVersion>>> $currentVersion');
            print('lastVersion>>> $lastVersion');
            if (currentVersion != lastVersion) {
              newVersion = AppVersion.fromJson(json);
            }
          }
        }
      },
    );
  }

  static getSidebarLinks() async {
    var response = await RestApi.get(linksUrl);
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        sidebarLinks = [];
        for (var json in response!.data['data']) {
          LinkMenu link = LinkMenu.fromJson(json);
          sidebarLinks.add(link);
        }
      },
    );
  }

  static getInitData() async {
    isLoading.value = true;
    getAppSetting();
    getSidebarLinks();
    await UserController.getUser();
    if (RestApi.isConnected) {
      if (UserController.user.value.state != 3) {
        if (UserController.user.value.lat != null &&
            UserController.user.value.long != null)
          UserController.myPosition = LatLng(
            double.parse(UserController.user.value.lat!),
            double.parse(UserController.user.value.long!),
          );
        else
          UserController.getMyLocation();
        await RegisterController.getProvinces();
        await RegisterController.getCategories();
        await RegisterController.getInfoDocument();
        if (UserController.user.value.id == null)
          Navigator.pushReplacement(
            Get.context!,
            MaterialPageRoute(builder: (builder) => Login()),
          );
        else {
          if (UserController.user.value.state == 1)
            RegisterController.registerStep.value = 5;

          Navigator.pushReplacement(
            Get.context!,
            MaterialPageRoute(builder: (builder) => RegisterIndex()),
          );
        }
      } else {
        // await MainController.getMyOrders();
        // await MainController.getMyOrdersWithDate();
        // await MainController.getSugestedOrders();
        // await MainController.getSettlement();
        // await MainController.getWallet();
        // await MainController.getFinancial();
        // await MainController.getAccounts();
        await MainController.getUserInfo();
        Navigator.pushReplacement(
          Get.context!,
          MaterialPageRoute(builder: (builder) => MainIndex()),
        );
      }
      if (newVersion != null && !kIsWeb) {
        showAlertDialog(
          Get.context!,
          title: ' بروزرسانی ${newVersion!.required ? 'الزامی' : ''}',
          child: Column(
            children: [
              Text(
                '${newVersion!.text}',
                style: AppController.fontStyle(fontTypes.heading5, itemColor1),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Btn(
                    btnType.primary,
                    text: 'دانلود',
                    width: 80,
                    height: 40,
                    onClick: () async {
                      await launchUrlString(
                        newVersion!.link!,
                        mode: LaunchMode.externalApplication,
                      );
                      Navigator.pop(Get.context!);
                    },
                  ),
                  Btn(
                    btnType.secondary,
                    text: 'بستن',
                    width: 80,
                    height: 40,
                    onClick: () {
                      Navigator.pop(Get.context!);
                    },
                  ),
                ],
              ),
            ],
          ),
          onClose: () {
            if (newVersion!.required) SystemNavigator.pop();
          },
        );
      }
    }

    isLoading.value = false;
  }
}
