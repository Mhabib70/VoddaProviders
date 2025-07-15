import 'package:flutter/cupertino.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MobileInput extends StatelessWidget {
  Function? onChange;
  var initValue;
  MobileInput({this.initValue, this.onChange});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: 45,
      width: maxItemWidth,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: itemColor5, width: borderSize),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              initialValue: initValue,
              textDirection: TextDirection.ltr,
              decoration: const InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintStyle: TextStyle(
                  color: itemColor4,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
                hintText: '_ _ _  _ _ _  _ _ _ _',
                hintTextDirection: TextDirection.ltr,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (text) {
                if (onChange != null) this.onChange!(text);
              },
            ),
          ),
          Container(
            width: borderSize,
            margin: EdgeInsets.all(10),
            color: itemColor5,
          ),
          Container(
            width: 50,
            child: Text(
              '98+',
              style: AppController.fontStyle(fontTypes.heading3, itemColor3),
            ),
          ),
        ],
      ),
    );
  }
}
