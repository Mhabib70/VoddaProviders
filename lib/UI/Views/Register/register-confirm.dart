import 'package:flutter/material.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Public/images.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/General/img.dart';

class RegisterConfirm extends StatelessWidget {
  const RegisterConfirm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: paddingSize, right: paddingSize),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Img(
              successIcon,
              height: 150,
              width: 150,
              color: AppController.primaryColor,
            ),
            SizedBox(height: 30),
            Text(
              'ثبت نام شما انجام شد !',
              style: AppController.fontStyle(fontTypes.heading1, itemColor1),
            ),
            SizedBox(height: 10),
            Text(
              'اطلاعات ارسالی شما لازم است توسط مدیریت تایید شوند تا بتوانید به پنل متخصصین دسترسی داشته باشید .',
              style: AppController.fontStyle(fontTypes.heading5, itemColor2),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
