import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Logic/Controllers/main-controller.dart';
import 'package:vodda_providers/Logic/Controllers/user-controller.dart';
import 'package:vodda_providers/Public/images.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/Buttons/btn.dart';
import 'package:vodda_providers/UI/Components/General/img.dart';
import 'package:vodda_providers/UI/Components/Inputs/input.dart';
import 'package:vodda_providers/UI/Components/Items/finantial-item.dart';
import 'package:vodda_providers/UI/Components/Items/payment-item.dart';
import 'package:vodda_providers/UI/Components/Items/wallet-item.dart';
import 'package:vodda_providers/UI/Components/Popups/bottom-modal.dart';
import 'package:vodda_providers/UI/Components/Selectors/radio-group.dart';
import 'package:vodda_providers/UI/Components/Selectors/select-box.dart';

class PaymentsList extends StatelessWidget {
  const PaymentsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: paddingSize, right: paddingSize),
          child: Stack(
            children: [
              Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "موجودی شما :",
                      style: AppController.fontStyle(
                        fontTypes.heading5,
                        itemColor4,
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          UserController.user.value.totalWallet == null
                              ? ''
                              : "${AppController.priceFormat(int.parse(UserController.user.value.totalWallet!))}",
                          style: AppController.fontStyle(
                            fontTypes.heading1,
                            itemColor2,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'تومان',
                          style: AppController.fontStyle(
                            fontTypes.heading4,
                            itemColor2,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
              Positioned(
                top: 0,
                left: 0,
                child: Btn(
                  btnType.mini,
                  text: 'درخواست تسویه',
                  width: 140,
                  height: 30,
                  fontType: fontTypes.heading5,
                  onClick: () {
                    MainController.getAllCash.value = true;
                    MainController.newTransaction.amount =
                        UserController.user.value.totalWallet;
                    showBottomModal(
                      context,
                      450,
                      SingleChildScrollView(
                        child: Obx(() {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 25),
                              Text(
                                'حساب / شماره کارت :',
                                style: AppController.fontStyle(
                                  fontTypes.heading4,
                                  itemColor4,
                                ),
                              ),
                              SizedBox(height: 10),
                              SelectBox(
                                text: 'انتخاب حساب',
                                icon: Img(
                                  cardIcon,
                                  width: 20,
                                  height: 14,
                                  color: itemColor4,
                                ),
                                options: {
                                  for (var account
                                      in MainController.myAccounts.value)
                                    '${account.formattedCardNumber} | ${account.title}':
                                        account.id,
                                },
                                onSelect: (val) {
                                  MainController.newTransaction.accountId = val;
                                },
                                value: MainController.newTransaction.accountId,
                              ),
                              SizedBox(height: 25),
                              RadioGroup(
                                MainController.getAllCash.value,
                                {
                                  'دریافت کل موجودی': true,
                                  'مشخص کردن مبلغ': false,
                                },
                                onChange: (val) {
                                  if (val) {
                                    MainController.newTransaction.amount =
                                        UserController.user.value.totalWallet;

                                    MainController.getAllCash.value = true;
                                  } else {
                                    MainController.getAllCash.value = false;
                                  }
                                },
                              ),
                              SizedBox(height: 30),
                              MainController.getAllCash.value
                                  ? Container(height: 45)
                                  :
                                    // Input(initValue: MainController.newTransaction
                                    //     .amount,
                                    //   icon1: Icon(Icons.money,
                                    //     color: itemColor2, size: 20,),
                                    //   isNumber: true,
                                    //   lable: 'مبلغ درخواستی (تومان)',
                                    //   onChange: (text) {
                                    //     MainController.newTransaction.amount = text;
                                    //     MainController.getAllCash.value = false;
                                    //   },),
                                    Input(
                                      lable: 'مبلغ',
                                      initValue:
                                          MainController.newTransaction.amount,
                                      icon1: Container(
                                        width: 20,
                                        height: 20,
                                        child: Img(
                                          moneyIcon,
                                          width: 20,
                                          height: 20,
                                          color: itemColor4,
                                        ),
                                      ),
                                      isNumber: true,
                                      icon2: Container(
                                        width: 25,
                                        height: 25,
                                        child: Center(
                                          child: Text(
                                            'تومان',
                                            style: AppController.fontStyle(
                                              fontTypes.heading5,
                                              itemColor4,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onChange: (text) {
                                        MainController.newTransaction.amount =
                                            text;
                                      },
                                    ),
                              SizedBox(height: 25),
                              Btn(
                                btnType.primary,
                                text: 'ثبت درخواست',
                                onClick: () {
                                  MainController.getWalletCash();
                                },
                              ),
                            ],
                          );
                        }),
                      ),
                      title: 'درخواست تسویه حساب',
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Expanded(
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  labelColor: itemColor1,
                  unselectedLabelColor: itemColor3,
                  indicatorWeight: 3,
                  indicatorColor: AppController.primaryColor,
                  tabs: [
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        'سند مالی',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        'کیف پول',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: paddingSize,
                            right: paddingSize,
                          ),
                          child: Obx(() {
                            return Column(
                              children: [
                                for (var finantial
                                    in MainController.myFinancial.value)
                                  FinantialItem(finantial),
                              ],
                            );
                          }),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: paddingSize,
                            right: paddingSize,
                          ),
                          child: Obx(() {
                            return Column(
                              children: [
                                for (var wallet
                                    in MainController.mywallets.value)
                                  WalletItem(wallet),
                              ],
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
