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
import 'package:vodda_providers/UI/Components/Headers/back-header.dart';
import 'package:vodda_providers/UI/Components/Inputs/input.dart';
import 'package:vodda_providers/UI/Components/Lists/empty-list.dart';
import 'package:vodda_providers/UI/Components/Popups/bottom-modal.dart';
import 'package:vodda_providers/UI/Components/Popups/loading.dart';
import 'package:vodda_providers/UI/Components/Selectors/select-box.dart';
import 'package:vodda_providers/UI/Components/Items/option-item.dart';

class OptionsList extends StatelessWidget {
  int questionId;

  OptionsList(this.questionId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Obx(() {
      List<Option> options = MainController.myOptions.value.values
          .where((element) => element.questionId == questionId)
          .toList();
      return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: options.length == 0
            ? Container()
            : Container(
                height: 65,
                width: 65,
                child: FloatingActionButton(
                  backgroundColor: AppController.primaryColor,
                  onPressed: () {
                    AddOption();
                  },
                  child: Img(addIcon, width: 25, height: 25, color: whiteColor),
                ),
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        backgroundColor: Color(0xffFAFAFA),
        body: Loading(
          getLoadedComponent: () {
            return options.length == 0
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BackHeader(title: " گزینه ها"),
                      EmptyList(
                        Img(
                          optionIcon,
                          width: 120,
                          height: 120,
                          color: AppController.primaryColor,
                        ),
                        "تنظیم گزینه ها",
                        "تا کنون گززینه ای را تنظیم نکرده اید ...",
                        btn: Btn(
                          btnType.mini,
                          width: 135,
                          height: 40,
                          text: "افزودن گزینه",
                          onClick: () {
                            AddOption();
                          },
                        ),
                      ),
                      Container(),
                    ],
                  )
                : Column(
                    children: [
                      BackHeader(title: 'گزینه ها'),
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
                                for (Option option in options)
                                  OptionItem(option),
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

  void AddOption() {
    Option option = new Option(questionId: questionId);
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
              child: Img(editIcon, width: 16, height: 16, color: itemColor4),
            ),
            lable: 'عنوان',
            onChange: (value) {
              option.title = value;
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
                      onChange: (value) {
                        option.price = int.parse(value);
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
                      onChange: (value) {
                        option.time = int.parse(value);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          MainController.myQuestions.value[questionId]!.type == 1
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
                                      (element.serviceId ==
                                          MainController
                                              .myQuestions[questionId]!
                                              .serviceId &&
                                      element.id != questionId),
                                )
                                .toList())
                          question.title: question.id,
                      },
                      onSelect: (value) {
                        option.targetQuestionId = value;
                      },
                      value: 0,
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
              Navigator.pop(Get.context!);
              MainController.storeQuestionOption(option);
            },
          ),
          SizedBox(height: paddingSize),
        ],
      ),
      title: 'افزودن گزینه',
    );
  }
}
