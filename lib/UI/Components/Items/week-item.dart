import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Logic/Controllers/main-controller.dart';
import 'package:vodda_providers/Logic/Models/free-time.dart';
import 'package:vodda_providers/Public/images.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/General/img.dart';
import 'package:vodda_providers/UI/Views/User/MyTimes/freetimes-list.dart';

class WeekItem extends StatelessWidget {
  int dayIndex;
  WeekItem(this.dayIndex, {Key? key}) : super(key: key);

  FreeTime? freeTime;
  late List<FreeTime> freeTimes;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    freeTimes = MainController.freeTimes.values
        .where((element) => element.day == dayIndex)
        .toList();
    freeTime = freeTimes.length > 0 ? freeTimes[0] : null;
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.only(left: 10, right: 10),
      height: 70,
      width: maxItemWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: whiteColor,
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (builder) => FreeTimesList(dayIndex)),
          );
        },
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      MainController.days[dayIndex]!,
                      style: AppController.fontStyle(
                        fontTypes.heading4,
                        itemColor1,
                      ),
                    ),
                    freeTime == null
                        ? Container()
                        : Text(
                            ' ${freeTime!.startTime}  الی  ${freeTime!.endTime}',
                            style: AppController.fontStyle(
                              fontTypes.heading5,
                              itemColor4,
                            ),
                          ),
                  ],
                ),
              ],
            ),
            Img(arrowIcon, width: 8, height: 14, color: itemColor4),
          ],
        ),
      ),
    );
  }
}
