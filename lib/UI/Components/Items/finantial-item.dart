import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Logic/Models/Settlement.dart';
import 'package:vodda_providers/Logic/Models/financial.dart';
import 'package:vodda_providers/Logic/Models/wallet.dart';
import 'package:vodda_providers/Public/images.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/Buttons/btn.dart';
import 'package:vodda_providers/UI/Components/General/img.dart';
import 'package:vodda_providers/UI/Components/Inputs/input.dart';
import 'package:vodda_providers/UI/Components/Popups/bottom-modal.dart';
import 'package:vodda_providers/UI/Components/Selectors/radio-group.dart';
import 'package:vodda_providers/UI/Components/Selectors/select-box.dart';

class FinantialItem extends StatelessWidget {
  Financial finantial;

  FinantialItem(this.finantial);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    Color color = successColor;
    IconData icon = Icons.check;
    if (finantial.type == 0) {
      color = errorColor;
      icon = Icons.error;
    } else if (finantial.type == 1) {
      color = successColor;
      icon = Icons.check;
    }
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(right: 20, left: 20, top: 15, bottom: 15),
          margin: EdgeInsets.only(top: 10, bottom: 10),
          width: maxItemWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: borderSize, color: itemColor5),
            color: whiteColor,
          ),
          child:
              // Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: color,
                    ),
                    width: 45,
                    height: 45,
                    child: Icon(icon, size: 25, color: Colors.white),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          finantial.amount == null
                              ? ''
                              : "${AppController.priceFormat(int.parse(finantial.amount!))} تومان",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xff212121),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 6),
                        Row(
                          children: [
                            Img(
                              dateIcon,
                              width: 10,
                              height: 10,
                              color: itemColor4,
                            ),
                            SizedBox(width: 5),
                            Text(
                              '${finantial.dateTitle}',
                              style: AppController.fontStyle(
                                fontTypes.text1,
                                itemColor4,
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(icon, size: 25, color: itemColor4),
                            SizedBox(width: 3),
                            Text(
                              '${finantial.typeTitle}',
                              style: AppController.fontStyle(
                                fontTypes.text1,
                                itemColor4,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        finantial.description == null ||
                                finantial.description == ''
                            ? Container()
                            : Text(
                                '${finantial.description}',
                                style: AppController.fontStyle(
                                  fontTypes.text1,
                                  itemColor4,
                                ),
                              ),

                        SizedBox(height: 6),
                        finantial.accountNumber == null ||
                                finantial.accountNumber == ''
                            ? Container()
                            : Text(
                                'شماره حساب : ${finantial.accountNumber}',
                                style: AppController.fontStyle(
                                  fontTypes.text1,
                                  itemColor4,
                                ),
                              ),

                        SizedBox(height: 6),
                        finantial.code == null || finantial.code == ''
                            ? Container()
                            : Text(
                                'شماره پیگیری : ${finantial.code}',
                                style: AppController.fontStyle(
                                  fontTypes.text1,
                                  itemColor4,
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
          // Img(arrowIcon,width: 5,height: 10,color: itemColor4,),

          //   ],
          // ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
