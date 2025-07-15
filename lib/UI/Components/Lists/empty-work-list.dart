import 'package:flutter/material.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Public/images.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/General/img.dart';

class EmptyWorkList extends StatelessWidget {
  const EmptyWorkList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        Img(
          infoIcon,
          width: 130,
          height: 130,
          color: AppController.primaryColor,
        ),
        SizedBox(height: 40),
        Text(
          'موردی یافت نشد !',
          style: AppController.fontStyle(fontTypes.heading2, itemColor1),
        ),
        SizedBox(height: 10),
        Text(
          'در حال حاضر کاری در این لیست وجود ندارد',
          style: AppController.fontStyle(fontTypes.heading5, itemColor4),
        ),
      ],
    );
  }
}
