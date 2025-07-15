import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/Buttons/btn.dart';
import 'package:vodda_providers/UI/Components/General/img.dart';

class EmptyList extends StatelessWidget {
  Widget icon;
  Widget? btn;
  String title, description;
  EmptyList(this.icon, this.title, this.description, {this.btn});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        SizedBox(height: 50),
        Text(
          title,
          style: AppController.fontStyle(fontTypes.heading1, itemColor1),
        ),
        SizedBox(height: 5),
        Text(
          description,
          style: AppController.fontStyle(fontTypes.heading4, itemColor4),
        ),
        SizedBox(height: 45),
        btn ?? Container(),
      ],
    );
  }
}
