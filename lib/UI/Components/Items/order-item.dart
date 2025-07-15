import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Logic/Controllers/main-controller.dart';
import 'package:vodda_providers/Logic/Controllers/user-controller.dart';
import 'package:vodda_providers/Logic/Models/order.dart';
import 'package:vodda_providers/Public/images.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/Buttons/btn.dart';
import 'package:vodda_providers/UI/Components/General/img.dart';
import 'package:vodda_providers/UI/Components/General/myDivider.dart';
import 'package:vodda_providers/UI/Components/Inputs/input.dart';
import 'package:vodda_providers/UI/Components/Popups/alert-dialog.dart';
import 'package:vodda_providers/UI/Components/Popups/bottom-modal.dart';
import 'package:vodda_providers/UI/Views/Main/work-detail.dart';

class OrderItem extends StatelessWidget {
  Order order;
  OrderItem(this.order, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 205,
          width: maxItemWidth,
          decoration: BoxDecoration(
            border: Border.all(width: borderSize, color: itemColor5),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Row(
                            children: [
                              if (order.service!.images.length > 0)
                                Img(
                                  order.service!.images[0],
                                  isNetwork: true,
                                  width: 45,
                                  height: 45,
                                  radius: 5,
                                ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${order.service!.title ?? ''}',
                                    style: AppController.fontStyle(
                                      fontTypes.heading4,
                                      itemColor1,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Img(
                                        dateIcon,
                                        width: 14,
                                        height: 14,
                                        color: itemColor3,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        '${order.fullDate}',
                                        style: AppController.fontStyle(
                                          fontTypes.heading5,
                                          itemColor3,
                                        ),
                                      ),

                                      order.typeDate == 0
                                          ? Container()
                                          : Row(
                                              children: [
                                                SizedBox(width: 10),
                                                Img(
                                                  clockIcon,
                                                  width: 14,
                                                  height: 14,
                                                  color: itemColor3,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  '${order.fullTime}',
                                                  style:
                                                      AppController.fontStyle(
                                                        fontTypes.heading5,
                                                        itemColor3,
                                                      ),
                                                ),
                                              ],
                                            ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Img(
                                        order.stateIcon!,
                                        width: 14,
                                        height: 14,
                                        color: order.stateColor,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        '${order.stateTitle}',
                                        style: AppController.fontStyle(
                                          fontTypes.heading5,
                                          order.stateColor!,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Img(
                                        infoIcon,
                                        width: 14,
                                        height: 14,
                                        color: itemColor4,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        '${order.typeTitle}',
                                        style: AppController.fontStyle(
                                          fontTypes.heading5,
                                          itemColor4,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Img(
                                        doneIcon,
                                        width: 12,
                                        height: 12,
                                        color: itemColor1,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        '${order.code}',
                                        style: AppController.fontStyle(
                                          fontTypes.heading5,
                                          itemColor1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),

                          Positioned(
                            top: 5,
                            left: 5,
                            child:
                                MainController.myOrders.keys.contains(order.id)
                                ? order.state == 2
                                      ? InkWell(
                                          onTap: () {
                                            showBottomModal(
                                              context,
                                              400,
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: SingleChildScrollView(
                                                      child: Center(
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 30,
                                                            ),
                                                            Input(
                                                              lable: 'توضیحات',
                                                              initValue: order
                                                                  .cancelDescription,
                                                              icon1: Container(
                                                                child: Icon(
                                                                  Icons
                                                                      .edit_outlined,
                                                                  size: 20,
                                                                  color:
                                                                      itemColor4,
                                                                ),
                                                                width: 50,
                                                                height: 30,
                                                                alignment:
                                                                    Alignment
                                                                        .topCenter,
                                                                padding:
                                                                    EdgeInsets.only(
                                                                      top: 5,
                                                                    ),
                                                              ),
                                                              lines: 5,
                                                              onChange: (text) {
                                                                order.cancelDescription =
                                                                    text;
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                          bottom: paddingSize,
                                                        ),
                                                    child: Btn(
                                                      btnType.primary,
                                                      text: 'ثبت',
                                                      onClick: () {
                                                        Navigator.pop(context);
                                                        MainController.cancelOrder(
                                                          order,
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              title: 'لغو سفارش',
                                            );
                                          },
                                          child: Container(
                                            width: 45,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                              color: AppController.primaryColor
                                                  .withOpacity(0.15),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'لغو کردن',
                                                style: TextStyle(
                                                  color: AppController
                                                      .primaryColor,
                                                  fontSize: 9,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container()
                                : InkWell(
                                    onTap: () {
                                      MainController.hideRequestedOrders(order);
                                    },
                                    child: Icon(
                                      Icons.clear,
                                      size: 25,
                                      color: itemColor4,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${order.fullAddress == null
                                  ? ''
                                  : order.fullAddress!.length > 30
                                  ? '${order.fullAddress!.substring(0, 29)}...'
                                  : order.fullAddress}',
                              style: AppController.fontStyle(
                                fontTypes.text1,
                                itemColor1,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 10),
                          Spacer(),
                          MainController.myOrders.keys.contains(order.id) ||
                                  order.isMyRequested == true
                              ? Container()
                              : Row(
                                  children: [
                                    order.providerId !=
                                            UserController.user.value.id
                                        ? Container()
                                        : InkWell(
                                            onTap: () {
                                              showAlertDialog(
                                                context,
                                                title: 'رد درخواست',
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'آیا از انتخاب خود مطمین هستید؟',
                                                      style:
                                                          AppController.fontStyle(
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
                                                            Navigator.pop(
                                                              context,
                                                            );
                                                            MainController.notAcceptOrder(
                                                              order,
                                                            );
                                                          },
                                                        ),
                                                        Btn(
                                                          btnType.secondary,
                                                          text: 'خیر',
                                                          width: 80,
                                                          height: 40,
                                                          onClick: () {
                                                            Navigator.pop(
                                                              context,
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                            child: Container(
                                              width: 65,
                                              height: 25,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(2),
                                                color: errorColor.withOpacity(
                                                  0.15,
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'نپذیرفتن',
                                                  style:
                                                      AppController.fontStyle(
                                                        fontTypes.heading5,
                                                        errorColor,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                    SizedBox(width: 10),
                                    InkWell(
                                      onTap: () {
                                        // if(order.type==0){

                                        showBottomModal(
                                          context,
                                          400,
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                          initValue: order
                                                              .providerDescription,
                                                          icon1: Container(
                                                            child: Icon(
                                                              Icons
                                                                  .edit_outlined,
                                                              size: 20,
                                                              color: itemColor4,
                                                            ),
                                                            width: 50,
                                                            height: 30,
                                                            alignment: Alignment
                                                                .topCenter,
                                                            padding:
                                                                EdgeInsets.only(
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
                                                    MainController.acceptOrder(
                                                      order,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          title: 'پذیرفتن درخواست',
                                        );
                                        // }
                                        // else
                                        //   MainController.acceptOrder(order);
                                      },
                                      child: Container(
                                        width: 60,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            2,
                                          ),
                                          color: AppController.primaryColor
                                              .withOpacity(0.15),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'پذیرفتن',
                                            style: AppController.fontStyle(
                                              fontTypes.heading5,
                                              AppController.primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              MyDivider(),
              Container(
                height: 40,
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.monetization_on_outlined,
                          color: AppController.primaryColor,
                          size: 15,
                        ),
                        SizedBox(width: 8),
                        Text(
                          order.price == null
                              ? ''
                              : '${AppController.priceFormat(int.parse(order.price!))} تومان',
                          style: AppController.fontStyle(
                            fontTypes.heading4,
                            AppController.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        MainController.setTime(order);

                        MainController.getOrder(order.id!, hasLoading: true);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => WorkDetail(order.id!),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            'مشاهده و جزيیات',
                            style: AppController.fontStyle(
                              fontTypes.text1,
                              itemColor4,
                            ),
                          ),
                          SizedBox(width: 12),
                          Img(
                            arrowIcon,
                            width: 5,
                            height: 10,
                            color: itemColor4,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
