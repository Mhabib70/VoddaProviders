import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Public/images.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/General/img.dart';

class MessageItem extends StatelessWidget {
  String title, date, text;
  Function? onClick;
  MessageItem(this.title, this.date, this.text, {this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick!();
      },
      child: Container(
        padding: EdgeInsets.all(15),
        width: maxItemWidth,
        height: 80,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 0),
              blurRadius: 10,
              color: Colors.black.withOpacity(0.05),
            ),
          ],
          borderRadius: BorderRadius.circular(5),
          color: whiteColor,
        ),
        child: Row(
          children: [
            Img(
              messageIcon,
              width: 38,
              height: 30,
              color: AppController.primaryColor,
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: AppController.fontStyle(
                          fontTypes.heading3,
                          itemColor1,
                        ),
                      ),
                      Text(
                        date,
                        style: AppController.fontStyle(
                          fontTypes.heading5,
                          itemColor1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          text,
                          maxLines: 1,
                          style: AppController.fontStyle(
                            fontTypes.text1,
                            itemColor4,
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
    );
  }
}
