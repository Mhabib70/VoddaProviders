import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Logic/Controllers/main-controller.dart';
import 'package:vodda_providers/Logic/Models/service.dart';
import 'package:vodda_providers/Public/images.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/Buttons/btn.dart';
import 'package:vodda_providers/UI/Components/General/img.dart';
import 'package:vodda_providers/UI/Components/Inputs/input.dart';
import 'package:vodda_providers/UI/Components/Popups/bottom-modal.dart';
import 'package:vodda_providers/UI/Components/Selectors/radio-group.dart';
import 'package:vodda_providers/UI/Views/User/MyServices/questions-list.dart';

class ServiceItem extends StatelessWidget {
  Service service = Service();
  ServiceItem(this.service);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 15),
      width: maxItemWidth,
      height: 140,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: itemColor5),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            color: Color(0xff000000).withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
        color: whiteColor,
      ),
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Img(
                service.images[0],
                width: 45,
                height: 45,
                radius: 5,
                isNetwork: true,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  service.title ?? '',
                  style: AppController.fontStyle(
                    fontTypes.heading3,
                    itemColor1,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                width:
                    (maxItemWidth > size.width ? size.width : maxItemWidth) / 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Img(
                          moneyIcon,
                          width: 12,
                          height: 12,
                          color: AppController.primaryColor,
                        ),
                        SizedBox(width: 5),
                        Text(
                          ' قیمت پایه : ${service.providerPrice} ',
                          style: AppController.fontStyle(
                            fontTypes.text1,
                            itemColor4,
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Img(
                          clockIcon,
                          width: 12,
                          height: 12,
                          color: AppController.primaryColor,
                        ),
                        SizedBox(width: 5),
                        Text(
                          ' زمان پایه : ${service.providerTime} ',
                          style: AppController.fontStyle(
                            fontTypes.text1,
                            itemColor4,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(width: 15),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (service.type == 1 && service.negotiable == 1)
                Btn(
                  btnType.mini,
                  width:
                      ((size.width < maxItemWidth ? size.width : maxItemWidth) -
                          (2 * paddingSize)) /
                      2.5,
                  height: 30,
                  text: 'ویرایش خدمت',
                  fontType: fontTypes.text1,
                  onClick: () {
                    Service s = Service(
                      id: service.id,
                      providerTime: service.providerTime,
                      providerPrice: service.providerPrice,
                      isActiveDetail: 1,
                    );
                    showBottomModal(
                      context,
                      500,
                      Column(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Input(
                                  icon1: Container(
                                    width: 20,
                                    height: 20,
                                    child: Img(
                                      clockIcon,
                                      width: 20,
                                      height: 20,
                                      color: itemColor3,
                                    ),
                                  ),
                                  isNumber: true,
                                  lable: 'زمان',
                                  initValue: service.providerTime.toString(),
                                  onChange: (value) {
                                    s.providerTime = int.parse(value);
                                  },
                                ),
                                SizedBox(height: 30),
                                Input(
                                  icon1: Container(
                                    width: 20,
                                    height: 20,
                                    child: Img(
                                      moneyIcon,
                                      width: 20,
                                      height: 20,
                                      color: itemColor3,
                                    ),
                                  ),
                                  isNumber: true,
                                  lable: 'هزینه',
                                  initValue: service.providerPrice,
                                  onChange: (value) {
                                    s.providerPrice = value;
                                  },
                                ),
                                // SizedBox(height: 30,),
                                // RadioGroup(s.isActiveDetail, {'اطلاعات پیش فرض به کاربر نمایش داده شود':0,'اطلاعاتی که من وارد کردم به کاربر نمایش داده شود':1},onChange: (val){
                                //   s.isActiveDetail=val;
                                // },)
                              ],
                            ),
                          ),
                          Btn(
                            btnType.primary,
                            text: 'ذخیره',
                            onClick: () {
                              Navigator.pop(context);
                              MainController.updateService(s);
                            },
                          ),
                          SizedBox(height: paddingSize),
                        ],
                      ),
                      title: 'ویرایش خدمت',
                    );
                  },
                ),
              // SizedBox(width: 10),
              // Btn(btnType.mini,width: ((size.width<maxItemWidth?size.width:maxItemWidth)-(2*paddingSize))/2.5,height: 30,text: 'ویرایش سوالات',fontType: fontTypes.text1,onClick: (){
              //   MainController.getServiceQuestions(service.id!);
              //   Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionsList(service.id!)));
              // },),
            ],
          ),
        ],
      ),
    );
  }
}
