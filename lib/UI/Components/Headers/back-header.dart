import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Public/images.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:flutter/material.dart';
import 'package:vodda_providers/UI/Components/General/img.dart';

class BackHeader extends StatelessWidget {
  double padding;
  String title;
  BackHeader({this.padding = paddingSize, this.title = ''});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        height: 70,
        width: size.width,
        padding: EdgeInsets.only(left: this.padding, right: this.padding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Img(AppController.logo, width: 40, height: 40),
                  SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      title,
                      style: AppController.fontStyle(
                        fontTypes.heading2,
                        itemColor1,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(width: 50, height: 50, child: Img(arrowIcon)),
            ),
          ],
        ),
      ),
    );
  }
}
