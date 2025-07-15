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
import 'package:vodda_providers/UI/Components/Headers/back-header.dart';
import 'package:vodda_providers/UI/Components/Inputs/input.dart';
import 'package:vodda_providers/UI/Components/Lists/empty-list.dart';
import 'package:vodda_providers/UI/Components/Popups/bottom-modal.dart';
import 'package:vodda_providers/UI/Components/Popups/loading.dart';
import 'package:vodda_providers/UI/Components/Selectors/checkbox.dart';
import 'package:vodda_providers/UI/Components/Selectors/select-box.dart';
import 'package:vodda_providers/UI/Components/Items/question-item.dart';

class QuestionsList extends StatelessWidget {
  int serviceId;
  QuestionsList(this.serviceId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Obx(() {
      List<ServiceQuestion> questions = MainController.myQuestions.value.values
          .where((element) => element.serviceId == serviceId)
          .toList();
      return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: questions.length == 0
            ? Container()
            : Container(
                height: 65,
                width: 65,
                child: FloatingActionButton(
                  backgroundColor: AppController.primaryColor,
                  onPressed: () {
                    AddQuestion();
                  },
                  child: Img(addIcon, width: 25, height: 25, color: whiteColor),
                ),
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        backgroundColor: Color(0xffFAFAFA),
        body: Loading(
          getLoadedComponent: () {
            return questions.length == 0
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BackHeader(title: 'ویرایش سوالات'),
                      EmptyList(
                        Img(
                          questionIcon,
                          width: 120,
                          height: 120,
                          color: AppController.primaryColor,
                        ),
                        "موردی یافت نشد",
                        "تا کنون هیچ سوالی را تنظیم نکرده اید ...",
                        btn: Btn(
                          btnType.mini,
                          width: 135,
                          height: 40,
                          text: "افزودن سوال",
                          onClick: () {
                            AddQuestion();
                          },
                        ),
                      ),
                      Container(),
                    ],
                  )
                : Column(
                    children: [
                      BackHeader(title: 'سوالات'),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            width: size.width,
                            margin: EdgeInsets.only(
                              right: paddingSize,
                              left: paddingSize,
                            ),
                            child: Column(
                              children: [
                                for (ServiceQuestion question in questions)
                                  QuestionItem(question),
                                SizedBox(height: 100),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
          },
        ),
      );
    });
  }

  void AddQuestion() {
    ServiceQuestion question = ServiceQuestion(serviceId: serviceId);
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
              child: Img(editIcon, width: 16, height: 16, color: itemColor4),
            ),
            lable: 'عنوان سوال',
            onChange: (text) {
              question.title = text;
            },
          ),
          SizedBox(height: 20),
          Container(
            width: maxItemWidth,
            child: Row(
              children: [
                Text(
                  "نوع سوال :",
                  style: AppController.fontStyle(fontTypes.text1, itemColor2),
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
            options: {'متنی': 0, 'انتخابی': 1, 'فایل': 2, 'چند انتخابی': 3},
            onSelect: (value) {
              question.type = value;
            },
          ),

          SizedBox(height: 20),
          Container(
            width: maxItemWidth,
            child: Row(
              children: [
                Text(
                  "سوال بعدی :",
                  style: AppController.fontStyle(fontTypes.text1, itemColor2),
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
                      .where((element) => element.serviceId == serviceId)
                      .toList())
                question.title: question.id,
            },
            value: 0,
          ),
          SizedBox(height: 40),
          CheckBox(
            'الزامی',
            onClick: (value) {
              question.required = value ? 1 : 0;
            },
          ),
          Spacer(),
          Btn(
            btnType.primary,
            width: maxItemWidth,
            height: 45,
            text: 'ذخیره',
            onClick: () {
              Navigator.pop(Get.context!);
              MainController.storeServiceQuestion(question);
            },
          ),
          SizedBox(height: paddingSize),
        ],
      ),
      title: 'افزودن سوال جدید',
    );
  }
}
