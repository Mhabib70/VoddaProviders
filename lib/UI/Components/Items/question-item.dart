import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Logic/Controllers/main-controller.dart';
import 'package:vodda_providers/Logic/Models/service-question.dart';
import 'package:vodda_providers/Public/images.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/Buttons/btn.dart';
import 'package:vodda_providers/UI/Components/General/img.dart';
import 'package:vodda_providers/UI/Components/Inputs/input.dart';
import 'package:vodda_providers/UI/Components/Popups/bottom-modal.dart';
import 'package:vodda_providers/UI/Components/Selectors/checkbox.dart';
import 'package:vodda_providers/UI/Components/Selectors/select-box.dart';
import 'package:vodda_providers/UI/Views/User/MyServices/options-list.dart';

class QuestionItem extends StatelessWidget {
  ServiceQuestion question = ServiceQuestion();
  QuestionItem(this.question, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.all(15),
      width: maxItemWidth,
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
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Img(
                questionIcon,
                width: 25,
                height: 25,
                color: AppController.primaryColor,
              ),
              SizedBox(width: 15),
              Expanded(
                child: Text(
                  question.title ?? '',
                  maxLines: 2,
                  style: AppController.fontStyle(
                    fontTypes.heading4,
                    itemColor1,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              question.type == 1 || question.type == 3
                  ? Btn(
                      btnType.mini,
                      width: 90,
                      height: 25,
                      text: 'گزینه ها',
                      fontType: fontTypes.text1,
                      onClick: () {
                        MainController.getQuestionOptions(question.id!);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OptionsList(question.id!),
                          ),
                        );
                      },
                    )
                  : Container(),
              Spacer(),
              InkWell(
                onTap: () {
                  ServiceQuestion q = ServiceQuestion.fromJson(
                    question.toJson(),
                  );
                  showBottomModal(
                    Get.context!,
                    585,
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
                          lable: 'عنوان سوال',
                          onChange: (text) {
                            q.title = text;
                          },
                          initValue: question.title,
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: maxItemWidth,
                          child: Row(
                            children: [
                              Text(
                                "نوع سوال :",
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
                          text: 'انتخاب نوع سوال',
                          options: {
                            'متنی': 0,
                            'انتخابی': 1,
                            'فایل': 2,
                            'چند انتخابی': 3,
                          },
                          onSelect: (value) {
                            q.type = value;
                          },
                          value: question.type,
                        ),

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
                                          (element.serviceId ==
                                              question.serviceId &&
                                          element.id != question.id),
                                    )
                                    .toList())
                              question.title: question.id,
                          },
                          value: question.targetQuestionId,
                          onSelect: (value) {
                            q.targetQuestionId = value;
                          },
                        ),
                        SizedBox(height: 40),
                        CheckBox(
                          'الزامی',
                          onClick: (value) {
                            q.required = value ? 1 : 0;
                          },
                          value: question.required == 1,
                        ),
                        Spacer(),
                        Btn(
                          btnType.primary,
                          width: maxItemWidth,
                          height: 45,
                          text: 'ذخیره',
                          onClick: () {
                            Navigator.pop(context);
                            MainController.storeServiceQuestion(q);
                          },
                        ),
                        SizedBox(height: paddingSize),
                      ],
                    ),
                    title: 'ویرایش سوال',
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
              SizedBox(width: 30),
              InkWell(
                onTap: () {
                  MainController.deleteServiceQuestion(question);
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
            ],
          ),
        ],
      ),
    );
  }
}
