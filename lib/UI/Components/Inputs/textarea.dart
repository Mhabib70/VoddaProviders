import 'package:flutter/material.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';

import '../../../Public/styles.dart';

class TextArea extends StatelessWidget {
  String? placeholder;
  Function? onChange;
  var initValue;
  TextArea({this.placeholder, this.onChange, this.initValue});
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    controller.text = '${initValue ?? ''}';

    return TextField(
      controller: controller,
      minLines: 6,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: itemColor3, width: borderSize),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppController.primaryColor,
            width: borderSize,
          ),
        ),
        hintStyle: TextStyle(
          color: itemColor4,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        hintText: this.placeholder,
        hintMaxLines: 2,
        alignLabelWithHint: true,
      ),
      onChanged: (text) {
        this.onChange!(text);
      },
    );
  }
}
