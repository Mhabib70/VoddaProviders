import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Logic/Controllers/main-controller.dart';
import 'package:vodda_providers/Public/images.dart';
import 'package:vodda_providers/UI/Components/Buttons/btn.dart';
import 'package:vodda_providers/UI/Components/General/img.dart';
import 'package:vodda_providers/UI/Components/Lists/empty-list.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EmptyList(
        Img(
          clockIcon2,
          width: 100,
          height: 100,
          color: AppController.primaryColor,
        ),
        'ساعات کاری روز شنبه',
        'برای این روز هنوز هیچ ساعتی مشخص نکرده اید .',
        btn: Btn(
          btnType.mini,
          width: 140,
          height: 40,
          text: 'افزودن بازه زمانی',
          fontType: fontTypes.heading4,
        ),
      ),
    );
  }
}
