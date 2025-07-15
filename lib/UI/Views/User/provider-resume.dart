import 'package:flutter/material.dart';
import 'package:vodda_providers/Logic/Controllers/main-controller.dart';
import 'package:vodda_providers/Logic/Controllers/user-controller.dart';
import 'package:vodda_providers/Logic/Models/cv-file.dart';
import 'package:vodda_providers/Logic/Models/user.dart';
import 'package:vodda_providers/Public/api-urls.dart';
import 'package:vodda_providers/UI/Components/Headers/back-header.dart';
import 'package:vodda_providers/UI/Components/Inputs/textarea.dart';
import 'package:vodda_providers/UI/Components/Popups/alert-dialog.dart';
import 'package:vodda_providers/UI/Components/Popups/loading.dart';
import 'package:vodda_providers/UI/Components/Selectors/video-picker.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Logic/Controllers/app-controller.dart';
import '../../../Public/images.dart';
import '../../../Public/styles.dart';
import '../../Components/Buttons/btn.dart';
import '../../Components/General/column-scroll.dart';
import '../../Components/General/img.dart';
import '../../Components/General/myDivider.dart';
import '../../Components/Inputs/input.dart';
import '../../Components/Lists/empty-list.dart';
import '../../Components/Popups/bottom-modal.dart';
import '../../Components/Selectors/file-picker.dart';

class ProviderResume extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    print('size.with>>>${size.width / 3 + 50}');
    return Scaffold(
      // backgroundColor: backgroundColor,
      body: Container(
        alignment: Alignment.center,
        width: size.width,
        height: size.height,
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              BackHeader(title: 'رزومه'),
              Container(
                height: 50,
                width: maxItemWidth,
                alignment: Alignment.centerRight,
                child: TabBar(
                  labelColor: itemColor1,
                  unselectedLabelColor: itemColor3,
                  indicatorWeight: 3,
                  indicatorColor: AppController.primaryColor,
                  onTap: (index) {
                    // OrderController.getMyOrders(tabIndex: index+1,refresh: false);
                  },
                  tabs: [
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        'رزومه',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),

                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        'تصاویر',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        'ویدئو',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: MyDivider(padding: paddingSize),
                width: maxItemWidth,
              ),

              Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Stack(
                      children: [
                        ColumnScroll(
                          getLoadedWidgets: () => Column(
                            children: [
                              SizedBox(height: 20),
                              Text(
                                UserController.user.value.cv ?? '',
                                textAlign: TextAlign.right,
                                style: AppController.fontStyle(
                                  fontTypes.text2,
                                  itemColor2,
                                ),
                                maxLines: null,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 20,
                          bottom: 20,
                          child: FloatingActionButton(
                            onPressed: () {
                              String newText = '';
                              showBottomModal(
                                context,
                                380,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Input(
                                      lable: 'رزومه',
                                      initValue: UserController.user.value.cv,
                                      icon1: Container(
                                        child: Icon(
                                          Icons.edit_outlined,
                                          size: 20,
                                          color: itemColor4,
                                        ),
                                        width: 50,
                                        height: 200,
                                        alignment: Alignment.topCenter,
                                        padding: EdgeInsets.only(top: 5),
                                      ),
                                      lines: 6,
                                      onChange: (text) {
                                        newText = text;
                                      },
                                    ),

                                    SizedBox(height: 20),
                                    Btn(
                                      btnType.primary,
                                      text: 'ذخیره',
                                      onClick: () {
                                        UserController.setCv(newText);
                                      },
                                    ),
                                  ],
                                ),
                                title: 'متن رزومه را وارد نمایید',
                              );
                            },
                            backgroundColor: AppController.primaryColor,
                            child: Icon(
                              Icons.add,
                              size: 25,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),

                    Stack(
                      children: [
                        ColumnScroll(
                          getLoadedWidgets: () => Column(
                            children: [
                              SizedBox(height: 20),
                              Container(
                                width: size.width,
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(bottom: 15),
                                child: Wrap(
                                  direction: Axis.horizontal,

                                  spacing: 5,
                                  runSpacing: 5,
                                  children: [
                                    for (var image
                                        in UserController.cvFiles.value.values
                                            .where(
                                              (element) => element.isVideo != 1,
                                            ))
                                      Container(
                                        width: 170,
                                        height: 100,

                                        child: Stack(
                                          children: [
                                            Img(
                                              image.file!,
                                              width: 170,
                                              height: 100,
                                              radius: 5,
                                              isNetwork: true,
                                              onClick: () async {
                                                if (!await launchUrl(
                                                  Uri.parse(
                                                    AppController.baseUrl +
                                                        image.file!,
                                                  ),
                                                  mode: LaunchMode
                                                      .externalApplication,
                                                ))
                                                  throw 'Could not launch ${image.file!}';
                                              },
                                            ),
                                            Positioned(
                                              top: 0,
                                              left: 0,
                                              child: InkWell(
                                                onTap: () {
                                                  showAlertDialog(
                                                    context,
                                                    title: 'حذف',
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          'آیا از انتخاب خود مطمین هستید؟',
                                                          style:
                                                              AppController.fontStyle(
                                                                fontTypes
                                                                    .heading5,
                                                                itemColor1,
                                                              ),
                                                        ),
                                                        SizedBox(height: 30),
                                                        Row(
                                                          children: [
                                                            Btn(
                                                              btnType.primary,
                                                              text: 'بله',
                                                              width: 80,
                                                              height: 40,
                                                              onClick: () async {
                                                                await UserController.deleteCvFile(
                                                                  image.id!,
                                                                );
                                                                Navigator.pop(
                                                                  context,
                                                                );
                                                              },
                                                            ),
                                                            Btn(
                                                              btnType.secondary,
                                                              text: 'خیر',
                                                              width: 80,
                                                              height: 40,
                                                              onClick: () {
                                                                Navigator.pop(
                                                                  context,
                                                                );
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  width: 45,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          5,
                                                        ),
                                                    color: itemColor1
                                                        .withOpacity(0.4),
                                                  ),
                                                  child: Img(
                                                    removeIcon,
                                                    width: 20,
                                                    height: 25,
                                                    color: whiteColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 0,
                                              right: 0,
                                              child: Container(
                                                width: 45,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: image.confirmed == 1
                                                      ? successColor
                                                            .withOpacity(0.4)
                                                      : warningColor
                                                            .withOpacity(0.4),
                                                ),
                                                child: Text(
                                                  image.confirmed == 1
                                                      ? 'تایید شده'
                                                      : 'در انتظار تایید',
                                                  style:
                                                      AppController.fontStyle(
                                                        fontTypes.text1,
                                                        whiteColor,
                                                      ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          emptyList: EmptyList(
                            Img(
                              messageIcon,
                              width: 145,
                              height: 115,
                              color: AppController.primaryColor,
                            ),
                            'موردی یافت نشد !',
                            'هیچ موردی برای نمایش وجود ندارد ...',
                          ),
                          checkEmptyList: () =>
                              UserController.cvFiles.value.values
                                  .where((element) => element.isVideo != 1)
                                  .length ==
                              0,
                        ),
                        Positioned(
                          right: 20,
                          bottom: 20,
                          child: FloatingActionButton(
                            onPressed: () {
                              List files = [];
                              showBottomModal(
                                context,
                                400,
                                Column(
                                  children: [
                                    FilePicker(
                                      onChange: (images) {
                                        files = images;
                                      },
                                    ),
                                    Spacer(),
                                    Btn(
                                      btnType.primary,
                                      text: 'ذخیره',
                                      onClick: () async {
                                        AppController.isLoading.value = true;
                                        for (var file in files)
                                          await UserController.uploadCvImage(
                                            file,
                                          );

                                        AppController.isLoading.value = false;
                                        Navigator.pop(context);
                                      },
                                    ),
                                    SizedBox(height: paddingSize),
                                  ],
                                ),
                                title: 'تصاویر نمونه کار خود را وارد کنید',
                              );
                            },
                            backgroundColor: AppController.primaryColor,
                            child: Icon(
                              Icons.add,
                              size: 25,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),

                    Stack(
                      children: [
                        ColumnScroll(
                          getLoadedWidgets: () => Column(
                            children: [
                              SizedBox(height: 20),
                              Container(
                                width: size.width,
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(bottom: 15),
                                child: Wrap(
                                  direction: Axis.horizontal,

                                  spacing: 5,
                                  runSpacing: 5,
                                  children: [
                                    for (var video
                                        in UserController.cvFiles.value.values
                                            .where(
                                              (element) => element.isVideo == 1,
                                            ))
                                      Stack(
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoPlay()));
                                              await launchUrl(
                                                Uri.parse(
                                                  AppController.baseUrl +
                                                      video.file!,
                                                ),
                                                mode: LaunchMode
                                                    .externalApplication,
                                              );
                                            },
                                            child: Container(
                                              width: 170,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                color: itemColor1,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Img(playIcon),
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            left: 0,
                                            child: InkWell(
                                              onTap: () {
                                                showAlertDialog(
                                                  context,
                                                  title: 'حذف',
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        'آیا از انتخاب خود مطمین هستید؟',
                                                        style:
                                                            AppController.fontStyle(
                                                              fontTypes
                                                                  .heading5,
                                                              itemColor1,
                                                            ),
                                                      ),
                                                      SizedBox(height: 30),
                                                      Row(
                                                        children: [
                                                          Btn(
                                                            btnType.primary,
                                                            text: 'بله',
                                                            width: 80,
                                                            height: 40,
                                                            onClick: () async {
                                                              await UserController.deleteCvFile(
                                                                video.id!,
                                                              );
                                                              Navigator.pop(
                                                                context,
                                                              );
                                                            },
                                                          ),
                                                          Btn(
                                                            btnType.secondary,
                                                            text: 'خیر',
                                                            width: 80,
                                                            height: 40,
                                                            onClick: () {
                                                              Navigator.pop(
                                                                context,
                                                              );
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                width: 45,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: itemColor1.withOpacity(
                                                    0.4,
                                                  ),
                                                ),
                                                child: Img(
                                                  removeIcon,
                                                  width: 20,
                                                  height: 25,
                                                  color: whiteColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: Container(
                                              width: 45,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: video.confirmed == 1
                                                    ? successColor.withOpacity(
                                                        0.4,
                                                      )
                                                    : warningColor.withOpacity(
                                                        0.4,
                                                      ),
                                              ),
                                              child: Text(
                                                video.confirmed == 1
                                                    ? 'تایید شده'
                                                    : 'در انتظار تایید',
                                                style: AppController.fontStyle(
                                                  fontTypes.text1,
                                                  whiteColor,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          emptyList: EmptyList(
                            Img(
                              messageIcon,
                              width: 145,
                              height: 115,
                              color: AppController.primaryColor,
                            ),
                            'موردی یافت نشد !',
                            'هیچ موردی برای نمایش وجود ندارد ...',
                          ),
                          checkEmptyList: () =>
                              UserController.cvFiles.value.values
                                  .where((element) => element.isVideo == 1)
                                  .length ==
                              0,
                        ),
                        Positioned(
                          right: 20,
                          bottom: 20,
                          child: FloatingActionButton(
                            onPressed: () {
                              showBottomModal(
                                context,
                                400,
                                Column(
                                  children: [
                                    SizedBox(height: 15),
                                    VideoPicker(
                                      url: uploadCvVideoUrl,
                                      onUpload: (data) async {
                                        CvFile cvFile = CvFile.fromJson(data);
                                        UserController.cvFiles[cvFile.id!] =
                                            cvFile;
                                      },
                                    ),
                                  ],
                                ),
                                title: 'بارگذاری ویدیو',
                              );
                            },
                            backgroundColor: AppController.primaryColor,
                            child: Icon(
                              Icons.add,
                              size: 25,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
