import 'package:flutter/material.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Logic/Controllers/user-controller.dart';
import 'package:vodda_providers/Public/images.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/Buttons/btn.dart';
import 'package:vodda_providers/UI/Components/General/img.dart';
import 'package:vodda_providers/UI/Components/Headers/back-header.dart';
import 'package:vodda_providers/UI/Components/Headers/main-header.dart';
import 'package:vodda_providers/UI/Components/Inputs/mobile-input.dart';
import 'package:vodda_providers/UI/Components/Popups/loading.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

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
                  MainHeader(),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(
                        left: paddingSize,
                        right: paddingSize,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Img(AppController.logo, width: 90, height: 90),
                          SizedBox(height: 50),
                          Text(
                            'شماره موبایلتان را وارد کنید :',
                            style: AppController.fontStyle(
                              fontTypes.heading4,
                              itemColor2,
                            ),
                          ),
                          SizedBox(height: 20),
                          MobileInput(
                            initValue: UserController.mobile,
                            onChange: (text) {
                              UserController.mobile = text;
                            },
                          ),
                          SizedBox(height: 30),
                          Btn(
                            btnType.primary,
                            text: 'ثبت نام / ورود',
                            onClick: () {
                              if (UserController.mobile.isNotEmpty)
                                UserController.login();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 50, bottom: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ثبت نام  به معنای پذیرش  ',
                          style: AppController.fontStyle(
                            fontTypes.heading4,
                            itemColor2,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            launchUrlString(AppController.setting['rule_link']);
                          },
                          child: Text(
                            'قوانین ',
                            style: AppController.fontStyle(
                              fontTypes.heading4,
                              AppController.primaryColor,
                            ),
                          ),
                        ),
                        Text(
                          'این اپلیکیشن است .',
                          style: AppController.fontStyle(
                            fontTypes.heading4,
                            itemColor2,
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
