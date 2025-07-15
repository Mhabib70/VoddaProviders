import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Logic/Controllers/main-controller.dart';
import 'package:vodda_providers/Logic/Models/free-time.dart';
import 'package:vodda_providers/Public/images.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/Buttons/btn.dart';
import 'package:vodda_providers/UI/Components/General/img.dart';
import 'package:vodda_providers/UI/Components/Popups/bottom-modal.dart';
import 'package:vodda_providers/UI/Components/Selectors/time-picker.dart';

class TimeItem extends StatelessWidget {
  FreeTime freeTime = FreeTime();
  TimeItem(this.freeTime, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.only(left: 20, right: 20),
      height: 60,
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
                clockIcon,
                width: 32,
                height: 32,
                color: AppController.primaryColor,
              ),
              SizedBox(width: 20),
              Text(
                '${freeTime.startTime}  الی  ${freeTime.endTime}',
                style: AppController.fontStyle(fontTypes.heading3, itemColor2),
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
                  FreeTime updatedFreetime = FreeTime.fromJson(
                    freeTime.toJson(),
                  );
                  showBottomModal(
                    context,
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
                                  initialTime: TimeOfDay(
                                    hour: int.parse(
                                      updatedFreetime.startTime!
                                          .split(':')
                                          .first,
                                    ),
                                    minute: int.parse(
                                      updatedFreetime.startTime!
                                          .split(':')
                                          .last,
                                    ),
                                  ),
                                  onSelect: (TimeOfDay? time) {
                                    updatedFreetime.startTime =
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
                                  initialTime: TimeOfDay(
                                    hour: int.parse(
                                      updatedFreetime.endTime!.split(':').first,
                                    ),
                                    minute: int.parse(
                                      updatedFreetime.endTime!.split(':').last,
                                    ),
                                  ),
                                  onSelect: (TimeOfDay? time) {
                                    updatedFreetime.endTime =
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
                                Navigator.pop(context);
                                MainController.updateFreeTime(updatedFreetime);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    title: 'افزودن بازه زمانی',
                  );
                },
              ),
              SizedBox(width: 20),
              Img(
                removeIcon,
                width: 17,
                height: 18,
                color: itemColor4,
                onClick: () {
                  MainController.deleteFreeTime(freeTime);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
