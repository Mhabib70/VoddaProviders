import 'package:flutter/material.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Public/images.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:get/get.dart';
import 'package:vodda_providers/UI/Components/Buttons/btn.dart';
import 'package:vodda_providers/UI/Components/General/img.dart';
import 'package:vodda_providers/UI/Components/Popups/loading.dart';
import 'package:vodda_providers/UI/Views/Register/register-index.dart';
import 'package:vodda_providers/UI/Views/User/login.dart';

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    AppController.getInitData();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteColor,
      body: Container(
        alignment: Alignment.center,
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            Expanded(
              child: Uri.base.queryParametersAll.length == 0
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Img(AppController.logo, width: 180, height: 180),
                        SizedBox(height: 50),
                        Text(
                          'متخصصین ${AppController.title}',
                          style: AppController.fontStyle(
                            fontTypes.heading1,
                            itemColor1,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'از تخصصتان کسب درآمد کنید !',
                          style: AppController.fontStyle(
                            fontTypes.heading4,
                            itemColor4,
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ),

            Loading(width: 30, height: 30),
            Container(
              padding: EdgeInsets.only(top: 50, bottom: 50),
              child: Text(
                'درحال بارگذاری ...',
                style: AppController.fontStyle(fontTypes.heading4, itemColor2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
