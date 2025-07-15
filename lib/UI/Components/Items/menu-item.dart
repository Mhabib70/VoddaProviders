import 'package:flutter/material.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/General/img.dart';

class ListMenuItem extends StatelessWidget {
  String icon, text;
  Function? onClick;
  bool isNetwork;
  ListMenuItem(
    this.icon,
    this.text, {
    Key? key,
    this.onClick,
    this.isNetwork = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          if (onClick != null) onClick!();
        },
        child: Container(
          height: 45,
          width: maxItemWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Img(
                    icon,
                    color: AppController.primaryColor,
                    width: 20,
                    height: 20,
                    isNetwork: isNetwork,
                  ),
                  SizedBox(width: 10),
                  Text(
                    text,
                    style: AppController.fontStyle(
                      fontTypes.heading5,
                      itemColor2,
                    ),
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios, size: 15, color: itemColor4),
            ],
          ),
        ),
      ),
    );
  }
}
