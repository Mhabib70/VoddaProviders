import 'package:flutter/material.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Logic/Controllers/main-controller.dart';
import 'package:vodda_providers/Logic/Controllers/user-controller.dart';
import 'package:vodda_providers/Logic/Models/account.dart';
import 'package:vodda_providers/Public/images.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/Buttons/btn.dart';
import 'package:vodda_providers/UI/Components/General/img.dart';
import 'package:vodda_providers/UI/Components/Inputs/input.dart';
import 'package:vodda_providers/UI/Components/Popups/bottom-modal.dart';

class CardItem extends StatelessWidget {
  Account account = Account();

  CardItem(this.account, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(15),
      height: 145,
      decoration: BoxDecoration(
        color: Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Color(0xffEFEFEF), width: 1),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Img(
                    cardIcon,
                    width: 25,
                    height: 20,
                    color: AppController.primaryColor,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "${account.title}",
                    style: AppController.fontStyle(
                      fontTypes.heading4,
                      itemColor2,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      MainController.removeAccount(account);
                    },
                    child: Icon(Icons.clear, size: 20, color: itemColor4),
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: Text(
                "${account.formattedCardNumber}",
                style: AppController.fontStyle(fontTypes.heading2, itemColor1),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${UserController.user.value.fname} ${UserController.user.value.lname}',
                style: AppController.fontStyle(fontTypes.heading5, itemColor4),
              ),
              InkWell(
                onTap: () {
                  showBottomModal(
                    context,
                    450,
                    Column(
                      children: [
                        Input(
                          lable: 'عنوان حساب',
                          icon1: Icon(
                            Icons.edit_outlined,
                            size: 20,
                            color: itemColor4,
                          ),
                          onChange: (text) {
                            account.title = text;
                          },
                          initValue: account.title,
                        ),
                        SizedBox(height: 15),
                        Input(
                          lable: 'شماره کارت',
                          icon1: Icon(
                            Icons.credit_card,
                            size: 20,
                            color: itemColor4,
                          ),
                          onChange: (text) {
                            account.cardNumber = text;
                          },
                          initValue: account.cardNumber,
                          isNumber: true,
                        ),
                        SizedBox(height: 15),
                        Input(
                          lable: 'شماره حساب',
                          icon1: Icon(
                            Icons.credit_card,
                            size: 20,
                            color: itemColor4,
                          ),
                          onChange: (text) {
                            account.accountNumber = text;
                          },
                          initValue: account.accountNumber,
                          isNumber: true,
                        ),

                        SizedBox(height: 15),
                        Input(
                          lable: 'شماره شبا',
                          icon1: Icon(
                            Icons.credit_card,
                            size: 20,
                            color: itemColor4,
                          ),
                          onChange: (text) {
                            account.shebaNumber = text;
                          },
                          initValue: account.shebaNumber,
                          isNumber: false,
                        ),
                        SizedBox(height: 25),
                        Btn(
                          btnType.primary,
                          text: 'ذخیره اطلاعات',
                          onClick: () {
                            Navigator.pop(context);
                            MainController.updateAccount(account);
                          },
                        ),
                      ],
                    ),
                    title: 'ویرایش حساب',
                  );
                },
                child: Container(
                  width: 45,
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppController.primaryColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Center(
                    child: Text(
                      'ویرایش',
                      style: TextStyle(
                        color: AppController.primaryColor,
                        fontSize: 9,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              // Row(
              //     children: [
              //       Row(
              //           children: [
              //             Text("06 / 04",style: TextStyle(color: Color(0xff9E9E9E),fontSize: 11,fontWeight: FontWeight.w400)),
              //             SizedBox(width: 5),
              //             Img(dateIcon,width: 14,height: 14,color: itemColor4,)
              //           ])
              //     ])
            ],
          ),
        ],
      ),
    );
  }
}
