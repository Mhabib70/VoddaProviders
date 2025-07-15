import 'package:flutter/material.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Public/styles.dart';

class CheckBox extends StatefulWidget {
  String? text;
  bool? value;
  Function? onClick;
  CheckBox(this.text, {Key? key, this.value = false, this.onClick})
    : super(key: key);

  @override
  _CheckBoxState createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.value = !widget.value!;
        });
        if (widget.onClick != null) widget.onClick!(widget.value);
      },
      child: Container(
        width: maxItemWidth,
        height: null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                '${widget.text ?? ''}',
                style: AppController.fontStyle(fontTypes.heading4, itemColor2),
              ),
            ),
            Checkbox(
              value: widget.value,
              fillColor: MaterialStateProperty.all(AppController.primaryColor),
              activeColor: AppController.primaryColor,
              side: BorderSide(width: 1, color: itemColor4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
              onChanged: (flag) {
                setState(() {
                  widget.value = flag!;
                });
                if (widget.onClick != null) widget.onClick!(widget.value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
