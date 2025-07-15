import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Logic/Controllers/main-controller.dart';
import 'package:vodda_providers/Logic/Controllers/register-controller.dart';
import 'package:vodda_providers/Logic/Controllers/user-controller.dart';
import 'package:vodda_providers/Public/images.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/Buttons/btn-with-icon.dart';
import 'package:vodda_providers/UI/Components/General/img.dart';
import 'package:vodda_providers/UI/Components/Items/menu-item.dart';
import 'package:vodda_providers/UI/Components/Popups/bottom-modal.dart';
import 'package:vodda_providers/UI/Components/Popups/loading.dart';
import 'package:vodda_providers/UI/Views/Register/register-form.dart';
import 'package:vodda_providers/UI/Views/User/MyServices/services-list.dart';
import 'package:vodda_providers/UI/Views/User/accounts-list.dart';
import 'package:vodda_providers/UI/Views/User/comments-list.dart';
import 'package:vodda_providers/UI/Views/User/login.dart';
import 'package:vodda_providers/UI/Views/User/provider-resume.dart';
import 'package:vodda_providers/UI/Views/User/splash.dart';
import 'package:vodda_providers/UI/Views/User/text-page.dart';
import 'package:vodda_providers/UI/Views/User/MyTimes/week-list.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Loading(
      getLoadedComponent: () => SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(right: paddingSize, left: paddingSize),
          child: Obx(() {
            return Column(
              children: [
                SizedBox(height: 15),
                Container(
                  width: maxItemWidth,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                showBottomModal(
                                  context,
                                  340,
                                  Column(
                                    children: [
                                      SizedBox(height: 50),
                                      Container(
                                        width: maxItemWidth,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            BtnIcon(
                                              icon: Img(
                                                folderIcon,
                                                width: 30,
                                                height: 30,
                                                color:
                                                    AppController.primaryColor,
                                              ),
                                              text: 'انتخاب از گالری',
                                              onclick: () {
                                                Navigator.pop(context);
                                                UserController.chooseProfile(
                                                  ImageSource.gallery,
                                                );
                                              },
                                            ),
                                            BtnIcon(
                                              icon: Img(
                                                cameraIcon,
                                                width: 30,
                                                height: 30,
                                                color:
                                                    AppController.primaryColor,
                                              ),
                                              text: 'بازکردن دوربین',
                                              onclick: () {
                                                Navigator.pop(context);
                                                UserController.chooseProfile(
                                                  ImageSource.camera,
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Container(
                                width: 75,
                                height: 75,
                                decoration: BoxDecoration(
                                  color: AppController.primaryColor.withOpacity(
                                    0.15,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: UserController.user.value.avatar != null
                                    ? Img(
                                        UserController.user.value.avatar!,
                                        color: AppController.primaryColor,
                                        width: 75,
                                        height: 75,
                                        radius: 5,
                                        isNetwork: true,
                                      )
                                    : Stack(
                                        children: [
                                          Img(
                                            userIcon,
                                            color: AppController.primaryColor,
                                            width: 30,
                                            height: 45,
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: Container(
                                              width: 25,
                                              height: 25,
                                              decoration: BoxDecoration(
                                                color:
                                                    AppController.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: Icon(
                                                Icons.add,
                                                color: whiteColor,
                                                size: 18,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${UserController.user.value.fname} ${UserController.user.value.lname} ',
                                    style: AppController.fontStyle(
                                      fontTypes.heading2,
                                      itemColor2,
                                    ),
                                  ),

                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        'نوع : ${UserController.user.value.typeTitle}',
                                        style: AppController.fontStyle(
                                          fontTypes.heading5,
                                          itemColor4,
                                        ),
                                      ),
                                      SizedBox(width: 30),
                                      Img(
                                        diamondIcon,
                                        color: AppController.primaryColor,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        '${UserController.user.value.score}',
                                        style: AppController.fontStyle(
                                          fontTypes.heading4,
                                          AppController.primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'کد متخصص: ${UserController.user.value.code}',
                                    style: AppController.fontStyle(
                                      fontTypes.heading5,
                                      itemColor4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Stack(
                          children: [
                            Container(
                              child: Center(
                                child: Text(
                                  "${UserController.user.value.rate}",
                                  style: AppController.fontStyle(
                                    fontTypes.heading2,
                                    itemColor1,
                                  ),
                                ),
                              ),
                              width: 75,
                              height: 75,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  width: 2,
                                  color: AppController.primaryColor,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 7,
                              child: Container(
                                width: 65,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: AppController.primaryColor,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: Center(
                                  child: Text(
                                    'امتیاز شما',
                                    style: AppController.fontStyle(
                                      fontTypes.text1,
                                      whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  color: Color(0xffFFFFFF),
                  height: 110,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${UserController.user.value.orderCount}',
                            style: AppController.fontStyle(
                              fontTypes.heading2,
                              AppController.primaryColor,
                            ),
                          ),
                          Text(
                            'سفارش انجام شده',
                            style: AppController.fontStyle(
                              fontTypes.text1,
                              itemColor4,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${UserController.user.value.orderInProgressCount}',
                            style: AppController.fontStyle(
                              fontTypes.heading2,
                              AppController.primaryColor,
                            ),
                          ),
                          Text(
                            'سفارش در حال انجام',
                            style: AppController.fontStyle(
                              fontTypes.text1,
                              itemColor4,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                // ListMenuItem(editProfileIcon,'ویرایش اطلاعات',onClick: (){
                //   Navigator.push(context, MaterialPageRoute(builder: (builder)=>RegisterForm(isRegisterd: true,)));
                // },),
                // UserController.user.value.permision_questions==1?
                ListMenuItem(
                  servicesIcon,
                  'لیست خدمات من',
                  onClick: () {
                    MainController.getMyServices();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (builder) => ServicesList()),
                    );
                  },
                ),
                // :Container()
                ListMenuItem(
                  messageIcon,
                  'رزومه',
                  onClick: () {
                    UserController.getCvFiles();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (builder) => ProviderResume()),
                    );
                  },
                ),
                ListMenuItem(
                  clockIcon2,
                  'تنظیمات ساعات کاری',
                  onClick: () {
                    MainController.getFreeTimes();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (builder) => WeekList()),
                    );
                  },
                ),
                ListMenuItem(
                  cardIcon,
                  'لیست حساب ها',
                  onClick: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (builder) => AccountsList()),
                    );
                  },
                ),
                ListMenuItem(
                  commentIcon,
                  'نظرات مشتریان',
                  onClick: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (builder) => CommentsList()),
                    );
                  },
                ),
                for (var link in AppController.sidebarLinks)
                  ListMenuItem(
                    link.icon!,
                    '${link.title}',
                    onClick: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (builder) => TextPage(link)),
                      );
                    },
                    isNetwork: true,
                  ),

                ListMenuItem(
                  callIcon,
                  'تماس با پشتیبانی',
                  onClick: () {
                    launchUrlString(
                      "tel:${AppController.setting['help_number']}",
                    );
                  },
                ),
                // ListMenuItem(ticketIcon,'ارسال تیکت پشتیبانی',onClick: (){
                //   launchUrlString(AppController.setting['ticket']);
                // },),
                ListMenuItem(
                  logoutIcon,
                  'خروج از حساب کاربری',
                  onClick: () {
                    UserController.logout();
                  },
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
