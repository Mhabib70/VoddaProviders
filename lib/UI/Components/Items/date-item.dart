import 'package:flutter/material.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Logic/Models/date.dart';
import 'package:vodda_providers/Public/styles.dart';

class DateItem extends StatelessWidget {
  Date date = Date();
  bool selected;
  Function? onClick;
  DateItem(this.date, {Key? key, this.selected = false, this.onClick})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (this.onClick != null) this.onClick!();
      },
      child: Container(
        width: selected ? 100 : 90,
        height: selected ? 140 : 120,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            width: 3,
            color: selected ? AppController.primaryColor : itemColor5,
          ),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '${date.day ?? ''}',
              style: AppController.fontStyle(
                fontTypes.heading1,
                selected ? AppController.primaryColor : itemColor4,
              ),
            ),
            Text(
              '${date.weekDay ?? ''}',
              style: AppController.fontStyle(
                fontTypes.heading3,
                selected ? AppController.primaryColor : itemColor2,
              ),
            ),
            Text(
              '${date.month ?? ''}',
              style: AppController.fontStyle(
                fontTypes.text1,
                selected ? AppController.primaryColor : itemColor4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
