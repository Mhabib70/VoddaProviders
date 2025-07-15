import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Logic/Controllers/main-controller.dart';
import 'package:vodda_providers/Logic/Models/option.dart';
import 'package:vodda_providers/Logic/Models/service-question.dart';
import 'package:vodda_providers/Public/images.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/Buttons/btn.dart';
import 'package:vodda_providers/UI/Components/General/img.dart';
import 'package:vodda_providers/UI/Components/Inputs/input.dart';
import 'package:vodda_providers/UI/Components/Popups/bottom-modal.dart';
import 'package:vodda_providers/UI/Components/Selectors/select-box.dart';

class OptionItem extends StatelessWidget {
  Option option = Option();

  OptionItem(this.option, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 15),
      width: maxItemWidth,
      height: 120,
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
        children: [
          Expanded(
            child: Text(
              option.title ?? '',
              maxLines: 2,
              style: AppController.fontStyle(fontTypes.heading4, itemColor1),
            ),
          ),
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
                'قیمت : ${option.price} تومان',
                style: AppController.fontStyle(fontTypes.text1, itemColor4),
              ),
              SizedBox(width: 15),
              Img(
                clockIcon,
                width: 12,
                height: 12,
                color: AppController.primaryColor,
              ),
              SizedBox(width: 5),
              Text(
                'زمان : ${option.time} دقیقه',
                style: AppController.fontStyle(fontTypes.text1, itemColor4),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  MainController.deleteQuestionOption(option);
                },
                child: Container(
                  child: Img(
                    removeIcon,
                    width: 20,
                    height: 20,
                    color: itemColor4,
                  ),
                ),
              ),
              SizedBox(width: 20),
              InkWell(
                onTap: () {
                  Option o = Option.fromJson(option.toJson());
                  showBottomModal(
                    Get.context!,
                    480,
                    Column(
                      children: [
                        Input(
                          width: maxItemWidth,
                          icon1: Container(
                            width: 16,
                            height: 16,
                            child: Img(
                              editIcon,
                              width: 16,
                              height: 16,
                              color: itemColor4,
                            ),
                          ),
                          lable: 'عنوان',
                          initValue: option.title,
                          onChange: (value) {
                            o.title = value;
                          },
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: maxItemWidth,
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'قیمت :',
                                    style: AppController.fontStyle(
                                      fontTypes.text1,
                                      itemColor2,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Input(
                                    isHalf: true,
                                    icon1: Container(
                                      width: 18,
                                      height: 18,
                                      child: Img(
                                        moneyIcon,
                                        width: 18,
                                        height: 18,
                                        color: itemColor4,
                                      ),
                                    ),
                                    lable: 'تومان',
                                    isNumber: true,
                                    initValue: option.price.toString(),
                                    onChange: (value) {
                                      o.price = int.parse(value);
                                    },
                                  ),
                                ],
                              ),
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'زمان :',
                                    style: AppController.fontStyle(
                                      fontTypes.text1,
                                      itemColor2,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Input(
                                    isHalf: true,
                                    icon1: Container(
                                      width: 18,
                                      height: 18,
                                      child: Img(
                                        clockIcon,
                                        width: 18,
                                        height: 18,
                                        color: itemColor4,
                                      ),
                                    ),
                                    lable: 'دقیقه',
                                    isNumber: true,
                                    initValue: option.time.toString(),
                                    onChange: (value) {
                                      o.time = int.parse(value);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        MainController
                                    .myQuestions
                                    .value[option.questionId]!
                                    .type ==
                                1
                            ? Column(
                                children: [
                                  SizedBox(height: 20),
                                  Container(
                                    width: maxItemWidth,
                                    child: Row(
                                      children: [
                                        Text(
                                          "سوال بعدی :",
                                          style: AppController.fontStyle(
                                            fontTypes.text1,
                                            itemColor2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  SelectBox(
                                    width: maxItemWidth,
                                    icon: Container(
                                      width: 18,
                                      height: 18,
                                      child: Img(
                                        questionIcon,
                                        width: 18,
                                        height: 18,
                                        color: itemColor4,
                                      ),
                                    ),
                                    text: 'انتخاب سوال بعدی',
                                    options: {
                                      'سوال بعدی': 0,
                                      for (ServiceQuestion question
                                          in MainController.myQuestions.values
                                              .where(
                                                (element) =>
                                                    element.serviceId ==
                                                        MainController
                                                            .myQuestions[option
                                                                .questionId]!
                                                            .serviceId &&
                                                    element.id !=
                                                        option.questionId,
                                              )
                                              .toList())
                                        question.title: question.id,
                                    },
                                    value: option.targetQuestionId,
                                    onSelect: (value) {
                                      o.targetQuestionId = value;
                                    },
                                  ),
                                ],
                              )
                            : Container(),

                        Spacer(),
                        Btn(
                          btnType.primary,
                          width: maxItemWidth,
                          height: 45,
                          text: 'ذخیره',
                          onClick: () {
                            Navigator.pop(context);
                            MainController.storeQuestionOption(o);
                          },
                        ),
                        SizedBox(height: paddingSize),
                      ],
                    ),
                    title: 'ویرایش گزینه',
                  );
                },
                child: Container(
                  child: Img(
                    editIcon,
                    width: 20,
                    height: 20,
                    color: itemColor4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
