import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Logic/Controllers/main-controller.dart';
import 'package:vodda_providers/Logic/Models/free-time.dart';
import 'package:vodda_providers/Logic/Models/holiday.dart';
import 'package:vodda_providers/Public/images.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/Buttons/btn.dart';
import 'package:vodda_providers/UI/Components/General/img.dart';
import 'package:vodda_providers/UI/Components/Headers/back-header.dart';
import 'package:vodda_providers/UI/Components/Headers/main-header.dart';
import 'package:vodda_providers/UI/Components/Inputs/input.dart';
import 'package:vodda_providers/UI/Components/Items/holyday-item.dart';
import 'package:vodda_providers/UI/Components/Items/time-item.dart';
import 'package:vodda_providers/UI/Components/Popups/bottom-modal.dart';
import 'package:vodda_providers/UI/Components/Popups/loading.dart';
import 'package:vodda_providers/UI/Components/Selectors/date-picker.dart';
import 'package:vodda_providers/UI/Components/Selectors/select-box.dart';
import 'package:vodda_providers/UI/Components/Selectors/select-date.dart';
import 'package:vodda_providers/UI/Components/Selectors/time-picker.dart';

class HolidaysList extends StatelessWidget {
  HolidaysList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Obx(() {
      return Scaffold(
        body: Container(
          child: Loading(
            getLoadedComponent: () {
              return Column(
                children: [
                  BackHeader(title: 'لیست تعطیلات'),
                  Expanded(
                    child: MainController.holidays.length == 0
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Img(
                                dateIcon,
                                width: 100,
                                height: 100,
                                color: AppController.primaryColor,
                              ),
                              SizedBox(height: 50),
                              Text(
                                'لیست خالی میباشد',
                                style: AppController.fontStyle(
                                  fontTypes.heading1,
                                  itemColor1,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'شما هیچ تاریخی را برای تعطیلات کاری مشخص نکرده اید ...',
                                style: AppController.fontStyle(
                                  fontTypes.heading4,
                                  itemColor4,
                                ),
                              ),
                              SizedBox(height: 45),
                              InkWell(
                                onTap: () {
                                  showPopup();
                                },
                                child: Container(
                                  height: 40,
                                  width: 140,
                                  decoration: BoxDecoration(
                                    color: AppController.primaryColor
                                        .withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'ثبت تاریخ',
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
                                  for (var holiday
                                      in MainController.holidays.values)
                                    HolidayItem(holiday),
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
        floatingActionButton: MainController.holidays.length == 0
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
    Holiday newHoliday = Holiday(
      date: '${MainController.years.keys.elementAt(0)}-01-01',
      startHour: TimeOfDay.now().hour,
      startMinute: TimeOfDay.now().minute,
      endHour: TimeOfDay.now().hour,
      endMinute: TimeOfDay.now().minute,
    );
    showBottomModal(
      Get.context!,
      500,
      Container(
        width: maxItemWidth,
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'تاریخ :',
                    style: AppController.fontStyle(
                      fontTypes.heading4,
                      itemColor4,
                    ),
                  ),
                  SizedBox(height: 10),
                  DatePicker(
                    onSelect: (str) {
                      newHoliday.date = str;
                    },
                  ),
                  SizedBox(height: 10),
                  Text(
                    'ساعت شروع :',
                    style: AppController.fontStyle(
                      fontTypes.heading4,
                      itemColor4,
                    ),
                  ),
                  SizedBox(height: 10),
                  TimePicker(
                    initialTime: TimeOfDay.now(),
                    onSelect: (TimeOfDay? time) {
                      newHoliday.startHour = time!.hour;
                      newHoliday.startMinute = time.minute;
                    },
                  ),
                  SizedBox(height: 10),
                  Text(
                    'ساعت پایان :',
                    style: AppController.fontStyle(
                      fontTypes.heading4,
                      itemColor4,
                    ),
                  ),
                  SizedBox(height: 10),
                  TimePicker(
                    initialTime: TimeOfDay.now(),
                    onSelect: (TimeOfDay? time) {
                      newHoliday.endHour = time!.hour;
                      newHoliday.endMinute = time.minute;
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
                  MainController.addHoliday(newHoliday);
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
