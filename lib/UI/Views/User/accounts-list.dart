import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Logic/Controllers/main-controller.dart';
import 'package:vodda_providers/Logic/Controllers/user-controller.dart';
import 'package:vodda_providers/Logic/Models/account.dart';
import 'package:vodda_providers/Public/images.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/Buttons/btn.dart';
import 'package:vodda_providers/UI/Components/General/img.dart';
import 'package:vodda_providers/UI/Components/Headers/back-header.dart';
import 'package:vodda_providers/UI/Components/Inputs/input.dart';
import 'package:vodda_providers/UI/Components/Items/card-item.dart';
import 'package:vodda_providers/UI/Components/Popups/bottom-modal.dart';

class AccountsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            children: [
              BackHeader(title: 'لیست حساب ها'),
              Expanded(
                child: MainController.myAccounts.value.length == 0
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Img(
                            cardIcon,
                            color: AppController.primaryColor,
                            width: 130,
                            height: 90,
                          ),
                          SizedBox(height: 50),
                          Text(
                            "موردی یافت نشد !",
                            style: AppController.fontStyle(
                              fontTypes.heading2,
                              itemColor1,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "جهت تسویه حساب , شماره حساب موردنظرتان را اضافه کنید",
                            style: AppController.fontStyle(
                              fontTypes.heading5,
                              itemColor4,
                            ),
                          ),
                          SizedBox(height: 55),
                          InkWell(
                            onTap: () {
                              addAccountModal(context);
                            },
                            child: Container(
                              width: 170,
                              height: 40,
                              decoration: BoxDecoration(
                                color: AppController.primaryColor.withOpacity(
                                  0.15,
                                ),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Center(
                                child: Text(
                                  'افزودن حساب/کارت',
                                  style: AppController.fontStyle(
                                    fontTypes.heading4,
                                    AppController.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.only(
                            left: paddingSize,
                            right: paddingSize,
                          ),
                          child: Column(
                            children: [
                              for (var account
                                  in MainController.myAccounts.value.reversed)
                                CardItem(account),
                            ],
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: MainController.myAccounts.value.length == 0
            ? Container()
            : FloatingActionButton(
                onPressed: () {
                  addAccountModal(context);
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppController.primaryColor,
                  ),
                  child: Center(
                    child: Icon(Icons.add, size: 25, color: Colors.white),
                  ),
                ),
              ),
      ),
    );
  }

  addAccountModal(context) {
    Account newAccount = Account();
    showBottomModal(
      context,
      450,
      Column(
        children: [
          Input(
            lable: 'عنوان حساب',
            icon1: Icon(Icons.edit_outlined, size: 20, color: itemColor4),
            onChange: (text) {
              newAccount.title = text;
            },
            initValue: newAccount.title,
          ),
          SizedBox(height: 15),
          Input(
            lable: 'شماره کارت',
            icon1: Icon(Icons.credit_card, size: 20, color: itemColor4),
            onChange: (text) {
              newAccount.cardNumber = text;
            },
            initValue: newAccount.cardNumber,
            isNumber: true,
          ),
          SizedBox(height: 15),
          Input(
            lable: 'شماره حساب',
            icon1: Icon(Icons.credit_card, size: 20, color: itemColor4),
            onChange: (text) {
              newAccount.accountNumber = text;
            },
            initValue: newAccount.accountNumber,
            isNumber: true,
          ),

          SizedBox(height: 15),
          Input(
            lable: 'شماره شبا',
            icon1: Icon(Icons.credit_card, size: 20, color: itemColor4),
            onChange: (text) {
              newAccount.shebaNumber = text;
            },
            initValue: newAccount.shebaNumber,
            isNumber: false,
          ),
          SizedBox(height: 25),
          Btn(
            btnType.primary,
            text: 'ذخیره اطلاعات',
            onClick: () {
              Navigator.pop(context);
              MainController.addAccount(newAccount);
            },
          ),
        ],
      ),
      title: 'افزودن حساب جدید',
    );
  }
}
