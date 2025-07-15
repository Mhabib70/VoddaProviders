import 'dart:typed_data';

import 'package:chunked_uploader/chunked_uploader.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
// import 'package:isolated_worker/isolated_worker.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Logic/Controllers/user-controller.dart';
import 'package:vodda_providers/Logic/Helpers/token-methods.dart';
import 'package:vodda_providers/Public/api-urls.dart';
import 'package:vodda_providers/Public/images.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/Buttons/picker-btn.dart';
import 'package:vodda_providers/UI/Components/General/img.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:vodda_providers/UI/Components/Popups/snackbar.dart';

// import 'package:image/image.dart' as IMG;

class VideoPicker extends StatefulWidget {
  String url;
  Function onUpload;
  VideoPicker({Key? key, required this.url, required this.onUpload})
    : super(key: key);

  @override
  _VideoPickerState createState() => _VideoPickerState();
}

class _VideoPickerState extends State<VideoPicker> {
  double progress = 0.0;
  XFile? file;

  chooseFile(ImageSource imageSource) async {
    if ((!kIsWeb && await Permission.storage.request().isGranted) || kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      file = await _picker.pickVideo(source: imageSource);
      setState(() {});
    }
  }

  upload() async {
    AppController.isLoading.value = true;

    String? mytoken = await Token.getToken();
    ChunkedUploader chunkedUploader = ChunkedUploader(
      Dio(
        BaseOptions(
          baseUrl: widget.url,
          headers: {
            'Content-Type': 'multipart/form-data',
            'Connection': 'Keep-Alive',
            "authorization": mytoken,
          },
        ),
      ),
    );
    try {
      // @smae1993 commented
      // Response? response = await chunkedUploader.upload(
      //   fileKey: "file",
      //   method: "POST",
      //   fileName: file!.path,
      //   fileDataStream: ,
      //   // filePath: file!.path,
      //   maxChunkSize: 500000000,
      //   path: widget.url,
      //   data: {'additional_data': 'hiii'},
      //   onUploadProgress: (v) {
      //     print('progress>>>${v}');
      //     progress = v;
      //     setState(() {});
      //   },
      // );

      // var data = response?.data;
      // if (data != null) {
      //   print('data>>>${data}');
      //   if (data['status_code'] == 200) {
      //     widget.onUpload(data['data']);
      //   } else {
      //     showSnackbar(snackTypes.error, data['message']);
      //   }
      // } else {
      //   showSnackbar(snackTypes.error, 'عملیات با خطا مواجه شد.');
      // }
      // setState(() {
      //   file = null;
      //   progress = 0.0;
      // });
    } on DioError catch (e) {
      print('DioError>>>${e}');
    }

    AppController.isLoading.value = false;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DottedBorder(
      // color: itemColor5,
      // strokeWidth: 2,
      // radius: Radius.circular(10),
      // dashPattern: [15, 5],
      child: Container(
        width: size.width,
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            Row(
              children: [
                Img(chooserIcon, width: 55, height: 55),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'انتخاب ویدیو',
                      style: AppController.fontStyle(
                        fontTypes.heading3,
                        itemColor1,
                      ),
                    ),
                    Text(
                      'ویدیو مربوطه را از گالری یا دوربین انتخاب کنید :',
                      style: AppController.fontStyle(
                        fontTypes.text1,
                        itemColor1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            file == null
                ? Row(
                    children: [
                      PickerBtn(
                        folderIcon,
                        'انتخاب از گالری',
                        onClick: () {
                          chooseFile(ImageSource.gallery);
                        },
                      ),
                      SizedBox(width: 10),
                      PickerBtn(
                        cameraIcon,
                        'بازکردن دوربین',
                        onClick: () {
                          chooseFile(ImageSource.camera);
                        },
                      ),
                    ],
                  )
                : progress == 0
                ? Row(
                    children: [
                      PickerBtn(
                        successIcon,
                        'بارگذاری',
                        onClick: () {
                          upload();
                        },
                      ),
                      SizedBox(width: 10),
                      PickerBtn(
                        cancelstateIcon,
                        'لغو',
                        onClick: () {
                          setState(() {
                            file = null;
                          });
                        },
                      ),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LinearPercentIndicator(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      animation: false,
                      lineHeight: 20.0,
                      percent: double.parse(progress.toStringAsExponential(1)),
                      progressColor: Colors.green,
                      center: Text(
                        "${(progress * 100).round()}%",
                        style: const TextStyle(fontSize: 12.0),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
