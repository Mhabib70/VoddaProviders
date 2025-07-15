import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Logic/Controllers/main-controller.dart';
import 'package:vodda_providers/Logic/Models/free-time.dart';
import 'package:vodda_providers/Logic/Models/holiday.dart';
import 'package:vodda_providers/Public/images.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/Buttons/btn.dart';
import 'package:vodda_providers/UI/Components/General/img.dart';
import 'package:vodda_providers/UI/Components/Popups/bottom-modal.dart';
import 'package:vodda_providers/UI/Components/Selectors/date-picker.dart';
import 'package:vodda_providers/UI/Components/Selectors/select-date.dart';
import 'package:vodda_providers/UI/Components/Selectors/time-picker.dart';

class HolidayItem extends StatelessWidget {
  Holiday holiday = Holiday();
  HolidayItem(this.holiday, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.only(left: 10, right: 10),
      height: 70,
      width: maxItemWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: whiteColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Img(
                dateIcon,
                width: 35,
                height: 35,
                color: AppController.primaryColor,
              ),
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'تاریخ : ${holiday.startFullTime}',
                    style: AppController.fontStyle(
                      fontTypes.heading5,
                      itemColor4,
                    ),
                  ),
                  Text(
                    ' ساعت : ${holiday.startHour.toString().padLeft(2, '0')}:${holiday.startMinute.toString().padLeft(2, '0')} تا ${holiday.endHour.toString().padLeft(2, '0')}:${holiday.endMinute.toString().padLeft(2, '0')}',
                    style: AppController.fontStyle(
                      fontTypes.heading5,
                      itemColor4,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Img(
                editIcon,
                width: 18,
                height: 18,
                color: itemColor4,
                onClick: () {
                  Holiday updatedHoliday = Holiday.fromJson(holiday.toJson());
                  updatedHoliday.date =
                      '${holiday.startYear}-${holiday.startMonth.toString().padLeft(2, '0')}-${holiday.startDay.toString().padLeft(2, '0')}';

                  showBottomModal(
                    context,
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
                                    updatedHoliday.date = str;
                                  },
                                  year: updatedHoliday.startYear,
                                  month: updatedHoliday.startMonth,
                                  day: updatedHoliday.startDay,
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
                                  initialTime: TimeOfDay(
                                    hour: updatedHoliday.startHour!,
                                    minute: updatedHoliday.startMinute!,
                                  ),
                                  onSelect: (TimeOfDay? time) {
                                    updatedHoliday.startHour = time!.hour;
                                    updatedHoliday.startMinute = time.minute;
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
                                  initialTime: TimeOfDay(
                                    hour: updatedHoliday.endHour!,
                                    minute: updatedHoliday.endMinute!,
                                  ),
                                  onSelect: (TimeOfDay? time) {
                                    updatedHoliday.endHour = time!.hour;
                                    updatedHoliday.endMinute = time.minute;
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
                                Navigator.pop(context);
                                MainController.updateHoliday(updatedHoliday);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    title: 'ویرایش بازه زمانی',
                  );
                },
              ),
              SizedBox(width: 15),
              Img(
                removeIcon,
                width: 17,
                height: 18,
                color: itemColor4,
                onClick: () {
                  MainController.deleteHoliday(holiday);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
