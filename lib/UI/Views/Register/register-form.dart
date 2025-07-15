import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Logic/Controllers/register-controller.dart';
import 'package:vodda_providers/Logic/Controllers/user-controller.dart';
import 'package:vodda_providers/Public/images.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/Buttons/btn-with-icon.dart';
import 'package:vodda_providers/UI/Components/Buttons/btn.dart';
import 'package:vodda_providers/UI/Components/General/img.dart';
import 'package:vodda_providers/UI/Components/Headers/back-header.dart';
import 'package:vodda_providers/UI/Components/Inputs/input.dart';
import 'package:vodda_providers/UI/Components/Popups/bottom-modal.dart';
import 'package:vodda_providers/UI/Components/Popups/loading.dart';
import 'package:vodda_providers/UI/Components/Selectors/select-box.dart';

class RegisterForm extends StatelessWidget {
  bool isRegisterd;
  RegisterForm({Key? key, this.isRegisterd = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Stack(
        children: [
          Container(
            child: Column(
              children: [
                isRegisterd ? BackHeader(title: 'ویرایش پروفایل') : Container(),
                Expanded(
                  child: SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: Container(
                      margin: EdgeInsets.only(
                        left: paddingSize,
                        right: paddingSize,
                      ),
                      child: Column(
                        children: [
                          UserController.user.value.errorMessage != '' &&
                                  UserController.user.value.errorMessage != null
                              ? Column(
                                  children: [
                                    SizedBox(height: 10),
                                    Text(
                                      UserController.user.value.errorMessage
                                          .toString(),
                                      style: AppController.fontStyle(
                                        fontTypes.heading4,
                                        errorColor,
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                          SizedBox(height: 10),
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
                                              color: AppController.primaryColor,
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
                                              color: AppController.primaryColor,
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
                            child: UserController.user.value.avatar == null
                                ? Stack(
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            150,
                                          ),
                                          color: AppController.primaryColor
                                              .withOpacity(0.2),
                                        ),
                                        child: Img(
                                          userIcon,
                                          color: AppController.primaryColor,
                                          width: 40,
                                          height: 55,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: AppController.primaryColor,
                                            borderRadius: BorderRadius.circular(
                                              50,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.add,
                                            color: whiteColor,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Img(
                                    UserController.user.value.avatar!,
                                    isNetwork: true,
                                    width: 100,
                                    height: 100,
                                    radius: 150,
                                  ),
                          ),
                          SizedBox(height: 40),
                          Container(
                            width: maxItemWidth,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Input(
                                  lable: 'نام',
                                  isHalf: true,
                                  icon1: Icon(
                                    Icons.edit_outlined,
                                    size: 20,
                                    color: itemColor4,
                                  ),
                                  initValue: UserController.user.value.fname,
                                  onChange: (text) {
                                    UserController.user.value.fname = text;
                                  },
                                ),
                                Input(
                                  lable: 'نام خانوادگی',
                                  isHalf: true,
                                  icon1: Icon(
                                    Icons.edit_outlined,
                                    size: 20,
                                    color: itemColor4,
                                  ),
                                  initValue: UserController.user.value.lname,
                                  onChange: (text) {
                                    UserController.user.value.lname = text;
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          Input(
                            lable: 'نام پدر',
                            icon1: Icon(
                              Icons.edit_outlined,
                              size: 20,
                              color: itemColor4,
                            ),
                            initValue: UserController.user.value.fatherName,
                            onChange: (text) {
                              UserController.user.value.fatherName = text;
                            },
                          ),
                          SizedBox(height: 15),
                          Input(
                            lable: ' کد ملی (بدون خط تیره)',
                            isNumber: true,
                            align: TextAlign.center,
                            initValue: UserController.user.value.nationalCode,
                            icon1: Icon(
                              Icons.wysiwyg,
                              size: 20,
                              color: itemColor4,
                            ),
                            onChange: (text) {
                              UserController.user.value.nationalCode = text;
                            },
                          ),
                          SizedBox(height: 15),
                          Input(
                            lable: ' شماره شناسنامه',
                            isNumber: true,
                            align: TextAlign.center,
                            initValue: UserController.user.value.numberCard,
                            icon1: Icon(
                              Icons.wysiwyg,
                              size: 20,
                              color: itemColor4,
                            ),
                            onChange: (text) {
                              UserController.user.value.numberCard = text;
                            },
                          ),
                          SizedBox(height: 15),
                          Input(
                            lable: ' تلفن ثابت',
                            isNumber: true,
                            align: TextAlign.center,
                            initValue: UserController.user.value.tell,
                            icon1: Icon(
                              Icons.wysiwyg,
                              size: 20,
                              color: itemColor4,
                            ),
                            onChange: (text) {
                              UserController.user.value.tell = text;
                            },
                          ),
                          SizedBox(height: 15),
                          SelectBox(
                            text: 'تحصیلات',
                            onSelect: (value) {
                              UserController.user.value.degree = value;
                            },
                            options: {
                              for (var degree
                                  in AppController.setting['degree'])
                                degree['title']: degree['title'],
                            },
                            icon: Img(locationIcon),
                            value: UserController.user.value.degree,
                          ),
                          SizedBox(height: 15),
                          Input(
                            lable: 'کد معرف',
                            icon1: Icon(
                              Icons.edit_outlined,
                              size: 20,
                              color: itemColor4,
                            ),
                            initValue: UserController.user.value.inviteCode,
                            onChange: (text) {
                              UserController.user.value.inviteCode = text;
                            },
                          ),
                          // SelectBox(text: 'انتخاب استان',onSelect: (value){
                          //   RegisterController.cities.value=[];
                          //   UserController.user.value.provinceId=value;
                          //   RegisterController.cities.value=RegisterController.provinces[value]!.cities;
                          // },options: {
                          //   for(var provinceID in RegisterController.provinces.keys)
                          //     RegisterController.provinces[provinceID]!.name:provinceID
                          // },icon: Img(locationIcon),value: UserController.user.value.provinceId),
                          // SizedBox(height: 15,),
                          // Obx(
                          //         () {
                          //       return SelectBox(text: 'انتخاب شهر',onSelect: (value){
                          //         UserController.user.value.cityId=value;
                          //       },options:RegisterController.cities.value.length>0  &&  UserController.user.value.provinceId!=null?{
                          //         for(var city in RegisterController.cities.value)
                          //           city.name:city.id
                          //       }:<dynamic,dynamic>{},icon: Img(cityIcon),value: UserController.user.value.cityId,);
                          //     }
                          // ),
                          // SizedBox(height: 15,),
                          // Input(lable: 'خیابان / کوچه / پلاک ...',initValue:UserController.user.value.place,icon1:Icon(Icons.my_location,size: 20,color: itemColor4),onChange: (text){
                          //   UserController.user.value.place=text;
                          // },),
                          SizedBox(height: 25),
                          Container(
                            width: maxItemWidth,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SelectBox(
                                  text: 'جنسیت',
                                  isHalf: true,
                                  icon: Img(
                                    sexIcon,
                                    color: itemColor4,
                                    width: 15,
                                    height: 15,
                                  ),
                                  options: {'آقا': 1, 'خانم': 0},
                                  onSelect: (val) {
                                    UserController.user.value.sex = val;
                                  },
                                  value: UserController.user.value.sex,
                                ),
                                SelectBox(
                                  text: 'وضعیت تاهل',
                                  isHalf: true,
                                  icon: Img(
                                    userIcon,
                                    color: itemColor4,
                                    width: 15,
                                    height: 15,
                                  ),
                                  options: {'متاهل': 1, 'مجرد': 0},
                                  onSelect: (val) {
                                    UserController.user.value.married = val;
                                  },
                                  value: UserController.user.value.married,
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 20),
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
                              height: 250,
                              alignment: Alignment.topCenter,
                              padding: EdgeInsets.only(top: 5),
                            ),
                            lines: 10,
                            onChange: (text) {
                              UserController.user.value.cv = text;
                            },
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
                isRegisterd
                    ? Padding(
                        padding: EdgeInsets.only(
                          left: paddingSize,
                          right: paddingSize,
                          bottom: paddingSize,
                        ),
                        child: Btn(
                          btnType.primary,
                          text: 'ثبت',
                          onClick: () {
                            RegisterController.updateUser();
                          },
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          Loading(),
        ],
      ),
    );
  }
}
