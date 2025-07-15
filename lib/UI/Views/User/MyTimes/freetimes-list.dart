import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Logic/Controllers/main-controller.dart';
import 'package:vodda_providers/Logic/Models/free-time.dart';
import 'package:vodda_providers/Public/images.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/Buttons/btn.dart';
import 'package:vodda_providers/UI/Components/General/img.dart';
import 'package:vodda_providers/UI/Components/Headers/back-header.dart';
import 'package:vodda_providers/UI/Components/Headers/main-header.dart';
import 'package:vodda_providers/UI/Components/Items/time-item.dart';
import 'package:vodda_providers/UI/Components/Lists/empty-list.dart';
import 'package:vodda_providers/UI/Components/Popups/bottom-modal.dart';
import 'package:vodda_providers/UI/Components/Popups/loading.dart';
import 'package:vodda_providers/UI/Components/Selectors/time-picker.dart';

class FreeTimesList extends StatelessWidget {
  int dayIndex;
  FreeTimesList(this.dayIndex, {Key? key}) : super(key: key);
  List<FreeTime> dayList = [];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Obx(() {
      dayList = MainController.freeTimes.values
          .where((element) => element.day == dayIndex)
          .toList();
      return Scaffold(
        body: Container(
          child: Loading(
            getLoadedComponent: () {
              return Column(
                children: [
                  BackHeader(title: 'تنظیم ساعات کاری'),
                  Expanded(
                    child: dayList.length == 0
                        ? EmptyList(
                            Img(
                              clockIcon2,
                              width: 100,
                              height: 100,
                              color: AppController.primaryColor,
                            ),
                            'ساعات کاری روز ${MainController.days[dayIndex]}',
                            'برای این روز هنوز هیچ ساعتی مشخص نکرده اید .',
                            btn: Btn(
                              btnType.mini,
                              width: 170,
                              height: 40,
                              text: 'افزودن بازه زمانی',
                              fontType: fontTypes.heading4,
                              onClick: () {
                                showPopup();
                              },
                            ),
                          )
                        : SingleChildScrollView(
                            child: Container(
                              margin: EdgeInsets.only(
                                left: paddingSize,
                                right: paddingSize,
                              ),
                              child: Column(
                                children: [
                                  for (int i = 0; i < dayList.length; i++)
                                    TimeItem(dayList[i]),
                                ],
                              ),
                            ),
                          ),
                  ),
                ],
              );
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: dayList.length == 0
            ? Container()
            : Container(
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                  color: AppController.primaryColor,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: FloatingActionButton(
                  onPressed: () {
                    showPopup();
                  },
                  child: Img(addIcon, width: 25, height: 25, color: whiteColor),
                ),
              ),
      );
    });
  }

  showPopup() {
    FreeTime newFreeTime = FreeTime(
      day: dayIndex,
      startTime:
          '${TimeOfDay.now().hour.toString().padLeft(2, '0')}:${TimeOfDay.now().minute.toString().padLeft(2, '0')}',
      endTime:
          '${TimeOfDay.now().hour.toString().padLeft(2, '0')}:${TimeOfDay.now().minute.toString().padLeft(2, '0')}',
    );
    showBottomModal(
      Get.context!,
      360,
      Container(
        width: maxItemWidth,
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'شروع :',
                    style: AppController.fontStyle(
                      fontTypes.heading4,
                      itemColor4,
                    ),
                  ),
                  SizedBox(height: 10),
                  TimePicker(
                    initialTime: TimeOfDay.now(),
                    onSelect: (TimeOfDay? time) {
                      newFreeTime.startTime =
                          '${time!.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
                    },
                  ),
                  SizedBox(height: 10),
                  Text(
                    'پایان :',
                    style: AppController.fontStyle(
                      fontTypes.heading4,
                      itemColor4,
                    ),
                  ),
                  SizedBox(height: 10),
                  TimePicker(
                    initialTime: TimeOfDay.now(),
                    onSelect: (TimeOfDay? time) {
                      newFreeTime.endTime =
                          '${time!.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: paddingSize),
              child: Btn(
                btnType.primary,
                text: 'ثبت ساعت',
                onClick: () {
                  Navigator.pop(Get.context!);
                  MainController.addFreeTime(newFreeTime);
                },
              ),
            ),
          ],
        ),
      ),
      title: 'افزودن بازه زمانی',
    );
  }
}
