import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Logic/Controllers/user-controller.dart';
import 'package:vodda_providers/Public/images.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/Buttons/btn.dart';
import 'package:vodda_providers/UI/Components/General/img.dart';
import 'package:vodda_providers/UI/Components/Headers/back-header.dart';
import 'package:vodda_providers/UI/Components/Inputs/input.dart';
import 'package:vodda_providers/UI/Components/Popups/loading.dart';
import 'package:vodda_providers/UI/Views/User/login.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

class Verify extends StatelessWidget {
  const Verify({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(parent: NeverScrollableScrollPhysics()),
        child: Container(
          alignment: Alignment.center,
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              Column(
                children: [
                  BackHeader(title: 'ثبت نام'),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(
                        left: paddingSize,
                        right: paddingSize,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Img(
                            smsIcon,
                            width: 90,
                            height: 90,
                            color: AppController.primaryColor,
                          ),
                          SizedBox(height: 50),
                          Text(
                            'کد تایید به شماره ی ${UserController.mobile} ارسال شد . آن را در کادر زیر وارد کنید :',
                            style: AppController.fontStyle(
                              fontTypes.heading4,
                              itemColor2,
                            ),
                          ),
                          SizedBox(height: 20),
                          // Input(
                          //     hint: '_  _  _     _  _  _',
                          //     isNumber: true,
                          //     onChange: (text) {
                          //       UserController.verifyCode = text;
                          //     },
                          //     align: TextAlign.center,
                          //     initValue: UserController.verifyCode),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Container(
                              width: maxItemWidth,
                              child: PinCodeTextField(
                                autoFocus: true,
                                enableActiveFill: true,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                textStyle: TextStyle(
                                  color: AppController.primaryColor,
                                ),
                                appContext: context,
                                pastedTextStyle: TextStyle(
                                  color: AppController.primaryColor,
                                ),
                                length: 4,
                                animationType: AnimationType.fade,
                                validator: (v) {
                                  if (v!.length < 3) {
                                  } else {}
                                },
                                pinTheme: PinTheme(
                                  inactiveFillColor: Colors.white,
                                  shape: PinCodeFieldShape.underline,
                                  borderRadius: BorderRadius.circular(5),
                                  fieldHeight: 50,
                                  fieldWidth: 40,
                                  activeFillColor: Colors.transparent,
                                  inactiveColor: Colors.black87,
                                  activeColor: Colors.black87,
                                  selectedColor: Colors.black87,
                                  selectedFillColor: Colors.transparent,
                                ),
                                animationDuration: Duration(milliseconds: 300),
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                obscureText: false,
                                cursorColor: AppController.primaryColor,
                                onCompleted: (value) {
                                  UserController.verify();
                                },
                                onChanged: (value) {
                                  UserController.verifyCode = value;
                                },
                                beforeTextPaste: (text) {
                                  return true;
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          // Btn(
                          //   btnType.primary,
                          //   text: 'ورود به برنامه',
                          //   onClick: () {
                          //     if (UserController.verifyCode.isNotEmpty)
                          //       UserController.verify();
                          //   },
                          // )
                        ],
                      ),
                    ),
                  ),
                  Obx(
                    () => Container(
                      padding: EdgeInsets.only(top: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UserController.timer > 0
                              ? Text(
                                  'ارسال مجدد کد تایید بعد از ${UserController.timer.value} ثانیه ',
                                  style: AppController.fontStyle(
                                    fontTypes.heading4,
                                    itemColor2,
                                  ),
                                )
                              : Container(),
                          InkWell(
                            onTap: () {
                              UserController.login();
                            },
                            child: Text(
                              UserController.timer.value > 0
                                  ? ''
                                  : 'ارسال مجدد کد تایید',
                              style: AppController.fontStyle(
                                fontTypes.heading4,
                                AppController.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 40, bottom: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'شماره موبایل وارد شده اشتباه است ؟ آن را ',
                          style: AppController.fontStyle(
                            fontTypes.heading4,
                            itemColor2,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (builder) => Login()),
                            );
                          },
                          child: Text(
                            'تغییر دهید .',
                            style: AppController.fontStyle(
                              fontTypes.heading4,
                              AppController.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Loading(),
            ],
          ),
        ),
      ),
    );
  }
}
