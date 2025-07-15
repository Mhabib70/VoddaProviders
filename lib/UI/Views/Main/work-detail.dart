import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Logic/Controllers/main-controller.dart';
import 'package:vodda_providers/Logic/Controllers/user-controller.dart';
import 'package:vodda_providers/Logic/Models/order.dart';
import 'package:vodda_providers/Logic/Models/order-question.dart';
import 'package:vodda_providers/Public/images.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/Buttons/btn.dart';
import 'package:vodda_providers/UI/Components/General/img.dart';
import 'package:vodda_providers/UI/Components/Headers/back-header.dart';
import 'package:vodda_providers/UI/Components/Inputs/input.dart';
import 'package:vodda_providers/UI/Components/Items/addition-item.dart';
import 'package:vodda_providers/UI/Components/Items/map-item.dart';
import 'package:vodda_providers/UI/Components/Items/overview-item.dart';
import 'package:vodda_providers/UI/Components/Items/answer-item.dart';
import 'package:vodda_providers/UI/Components/Popups/alert-dialog.dart';
import 'package:vodda_providers/UI/Components/Popups/bottom-modal.dart';
import 'package:vodda_providers/UI/Components/Popups/loading.dart';
import 'package:vodda_providers/UI/Views/Main/order-document-list.dart';
import 'package:url_launcher/url_launcher_string.dart';

class WorkDetail extends StatelessWidget {
  int orderId;
  WorkDetail(this.orderId, {Key? key}) : super(key: key);

  Order order = Order();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      body: Container(
        width: size.width,
        height: size.height,
        child: Loading(
          getLoadedComponent: () {
            return Obx(() {
              if (MainController.myOrders.containsKey(orderId))
                order = MainController.myOrders.value[orderId]!;
              else
                order = MainController.sugestedOrders.value[orderId]!;
              return Column(
                children: [
                  BackHeader(title: '${order.service!.title ?? ''}'),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.only(
                          left: paddingSize,
                          right: paddingSize,
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 25),

                            OverviewItem(
                              userIcon,
                              title: 'نام مشتری :',
                              value: '${order.username}',
                            ),
                            order.typeCall == null || order.typeCall == 0
                                ? Container()
                                : Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Img(
                                                callIcon,
                                                width: 18,
                                                height: 18,
                                                color:
                                                    AppController.primaryColor,
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                'شماره تماس :',
                                                style: AppController.fontStyle(
                                                  fontTypes.heading5,
                                                  itemColor3,
                                                ),
                                              ),
                                            ],
                                          ),
                                          InkWell(
                                            onTap: () {
                                              if (order.typeCall == 1)
                                                launchUrlString(
                                                  'tel:${order.userMobile}',
                                                );
                                              else
                                                MainController.callUser(
                                                  orderId,
                                                );
                                            },
                                            child: Container(
                                              width: 110,
                                              height: 25,
                                              decoration: BoxDecoration(
                                                color: AppController
                                                    .primaryColor
                                                    .withOpacity(0.15),
                                                borderRadius:
                                                    BorderRadius.circular(2),
                                              ),
                                              alignment: Alignment.center,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    '${order.typeCall == 1 ? order.userMobile : 'تماس'}',
                                                    style:
                                                        AppController.fontStyle(
                                                          fontTypes.heading5,
                                                          AppController
                                                              .primaryColor,
                                                        ),
                                                  ),
                                                  Icon(
                                                    Icons.call,
                                                    color: AppController
                                                        .primaryColor,
                                                    size: 15,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                    ],
                                  ),
                            OverviewItem(
                              moneyIcon,
                              title: 'هزینه خدمات :',
                              value: '${order.price} تومان',
                            ),
                            OverviewItem(
                              dateIcon,
                              title: 'تاریخ دریافت خدمات :',
                              value: '${order.fullDate}',
                            ),
                            OverviewItem(
                              clockIcon,
                              title: 'ساعت :',
                              value: '${order.fullTime}',
                            ),
                            OverviewItem(
                              infoIcon,
                              title: 'نوع درخواست :',
                              value: '${order.typeTitle}',
                            ),
                            OverviewItem(
                              order.stateIcon!,
                              title: 'وضعیت :',
                              value: '${order.stateTitle}',
                            ),
                            order.additions.length == 0
                                ? Container()
                                : Container(
                                    width: maxItemWidth,
                                    margin: EdgeInsets.only(bottom: 15),
                                    decoration: BoxDecoration(
                                      boxShadow: shadow,
                                      borderRadius: BorderRadius.circular(10),
                                      color: whiteColor,
                                    ),
                                    padding: EdgeInsets.all(15),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'درخواست های اضافه :',
                                              style: AppController.fontStyle(
                                                fontTypes.heading4,
                                                itemColor1,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        for (var addition in order.additions)
                                          AdditionItem(addition),
                                      ],
                                    ),
                                  ),
                            order.lat == null
                                ? Container()
                                : Column(
                                    children: [
                                      OverviewItem(
                                        locationIcon,
                                        title: 'آدرس :',
                                        value: '${order.fullAddress ?? ''}',
                                        isRow: false,
                                      ),
                                      MapItem(
                                        order.lat!,
                                        order.long!,
                                        '${order.fullAddress ?? ''}',
                                      ),
                                    ],
                                  ),
                            SizedBox(height: 15),
                            order.hasDocument != true
                                ? Container()
                                : Container(
                                    width: maxItemWidth,
                                    decoration: BoxDecoration(
                                      boxShadow: shadow,
                                      borderRadius: BorderRadius.circular(25),
                                      color: whiteColor,
                                    ),
                                    padding: EdgeInsets.all(15),
                                    margin: EdgeInsets.only(bottom: 20),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Img(
                                              infoIcon,
                                              width: 45,
                                              height: 45,
                                              color: AppController.primaryColor,
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: Text(
                                                'جهت مشاهده عکس و توضیحات تکمیلی از این قسمت استفاده کنید',
                                                style: AppController.fontStyle(
                                                  fontTypes.text2,
                                                  itemColor2,
                                                ),
                                                maxLines: null,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Btn(
                                          btnType.primary,
                                          width: 170,
                                          height: 35,
                                          text: 'اطلاعات تکمیلی',
                                          onClick: () {
                                            MainController.getOrderDocuments(
                                              order.id!,
                                            );
                                            Get.to(
                                              () => OrderDocumentList(order),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                            order.description == null || order.description == ''
                                ? Container()
                                : answerItem(
                                    OrderQuestion(
                                      question: 'توضیحات درخواست',
                                      res: order.description ?? '',
                                    ),
                                  ),
                            order.providerDescription == null ||
                                    order.providerDescription == ''
                                ? Container()
                                : answerItem(
                                    OrderQuestion(
                                      question: 'توضیحات متخصص',
                                      res: order.providerDescription ?? '',
                                    ),
                                  ),
                            if (order.questions != null)
                              for (var question in order.questions!.values)
                                answerItem(question),
                          ],
                        ),
                      ),
                    ),
                  ),
                  order.isMyRequested == false
                      ? Container(
                          padding: EdgeInsets.only(
                            left: paddingSize,
                            right: paddingSize,
                            bottom: paddingSize,
                          ),
                          child: Btn(
                            btnType.primary,
                            text: 'پذیرفتن',
                            onClick: () {
                              showBottomModal(
                                context,
                                400,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Center(
                                          child: Column(
                                            children: [
                                              // SizedBox(height: 25,),
                                              // Input(initValue: '${order.durationTime}',
                                              //   icon1: Icon(Icons.timer,color:itemColor2 ,size: 20,),
                                              //   lable: 'زمان انجام(دقیقه)',onChange: (text){
                                              //   order.durationTime=text;
                                              // },),
                                              // SizedBox(height: 30,),
                                              // Input(initValue:'${order.price}',icon1: Icon(Icons.monetization_on_outlined,color:itemColor2 ,size: 20,),lable: 'مبلغ درخواستی(تومان)',onChange: (text){
                                              //   order.price=text;
                                              // },),
                                              SizedBox(height: 30),
                                              Input(
                                                lable: 'توضیحات',
                                                initValue:
                                                    order.providerDescription,
                                                icon1: Container(
                                                  child: Icon(
                                                    Icons.edit_outlined,
                                                    size: 20,
                                                    color: itemColor4,
                                                  ),
                                                  width: 50,
                                                  height: 30,
                                                  alignment:
                                                      Alignment.topCenter,
                                                  padding: EdgeInsets.only(
                                                    top: 5,
                                                  ),
                                                ),
                                                lines: 5,
                                                onChange: (text) {
                                                  order.providerDescription =
                                                      text;
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: paddingSize,
                                      ),
                                      child: Btn(
                                        btnType.primary,
                                        text: 'ثبت',
                                        onClick: () {
                                          Navigator.pop(context);
                                          MainController.acceptOrder(order);
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                title: 'پذیرفتن درخواست',
                              );
                            },
                          ),
                        )
                      : order.state == 2 && order.service!.typePlace == 2
                      ? Container(
                          padding: EdgeInsets.only(
                            left: paddingSize,
                            right: paddingSize,
                            bottom: paddingSize,
                          ),
                          child: Btn(
                            btnType.primary,
                            text:
                                MainController.timerDuration.value.inSeconds !=
                                    0
                                ? MainController.getTime()
                                : 'تماس',
                            onClick: () {
                              if (MainController
                                      .timerDuration
                                      .value
                                      .inSeconds ==
                                  0)
                                if (order.service!.type_online == 0)
                                  MainController.meetOrder(orderId);
                                else
                                  MainController.callOrder(orderId);
                            },
                          ),
                        )
                      : order.state == 2 && !order.isStarted!
                      ? Container(
                          padding: EdgeInsets.only(
                            left: paddingSize,
                            right: paddingSize,
                            bottom: paddingSize,
                          ),
                          child: Btn(
                            btnType.primary,
                            text: 'شروع کار',
                            onClick: () {
                              showAlertDialog(
                                context,
                                title: 'شروع کار',
                                child: Column(
                                  children: [
                                    Text(
                                      'آیا از انتخاب خود مطمین هستید؟',
                                      style: AppController.fontStyle(
                                        fontTypes.heading5,
                                        itemColor1,
                                      ),
                                    ),
                                    SizedBox(height: 30),
                                    Row(
                                      children: [
                                        Btn(
                                          btnType.primary,
                                          text: 'بله',
                                          width: 80,
                                          height: 40,
                                          onClick: () {
                                            Navigator.pop(context);
                                            MainController.startOrder(order);
                                          },
                                        ),
                                        Btn(
                                          btnType.secondary,
                                          text: 'خیر',
                                          width: 80,
                                          height: 40,
                                          onClick: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      : Container(),
                ],
              );
            });
          },
        ),
      ),
    );
  }
}
