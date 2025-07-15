import 'package:flutter/cupertino.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vodda_providers/UI/Components/Popups/snackbar.dart';

class Input extends StatelessWidget {
  String? lable, hint;
  Function? onChange;
  bool isNumber, isHalf;
  TextAlign align;
  Widget? icon1, icon2;
  int lines;
  var initValue;
  double? width;
  Input({
    this.lable,
    this.hint,
    this.initValue,
    this.onChange,
    this.isNumber = false,
    this.isHalf = false,
    this.icon1,
    this.icon2,
    this.lines = 1,
    this.align = TextAlign.right,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    if (WidgetsBinding.instance.window.viewInsets.bottom == 0) {
      FocusManager.instance.primaryFocus!.unfocus();
    }

    var size = MediaQuery.of(context).size;
    return Container(
      height: lines == 1 ? 45 : null,
      width: this.isHalf
          ? ((size.width < maxItemWidth ? size.width : maxItemWidth) -
                    (2 * paddingSize)) /
                2.05
          : width ?? maxItemWidth,
      alignment: Alignment.center,
      color: Colors.white,
      child: TextFormField(
        initialValue: isNumber ? initValue : '${initValue ?? ''} ',
        textAlign: align,

        minLines: lines,
        maxLines: lines,
        textDirection: isNumber ? TextDirection.ltr : TextDirection.rtl,

        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: lines > 1 ? 30 : 5),
          prefixIcon: icon1 != null ? icon1 : null,
          suffixIcon: icon2 != null ? icon2 : null,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: itemColor5, width: borderSize),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppController.primaryColor,
              width: borderSize,
            ),
          ),
          floatingLabelStyle: TextStyle(color: AppController.primaryColor),
          labelStyle: AppController.fontStyle(fontTypes.heading4, itemColor2),
          alignLabelWithHint: true,
          labelText: this.lable ?? '',
          hintText: this.hint ?? '',
          hintStyle: AppController.fontStyle(fontTypes.heading4, itemColor4),
        ),
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        inputFormatters: <TextInputFormatter>[
          isNumber
              ? FilteringTextInputFormatter.digitsOnly
              : FilteringTextInputFormatter.singleLineFormatter,
        ],
        onChanged: (text) {
          if (onChange != null) this.onChange!(text);
        },
      ),
    );
  }
}
