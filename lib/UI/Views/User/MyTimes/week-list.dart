import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Logic/Controllers/main-controller.dart';
import 'package:vodda_providers/Logic/Models/holiday.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/Buttons/btn.dart';
import 'package:vodda_providers/UI/Components/Headers/back-header.dart';
import 'package:vodda_providers/UI/Components/Headers/main-header.dart';
import 'package:vodda_providers/UI/Components/Items/week-item.dart';
import 'package:vodda_providers/UI/Components/Popups/bottom-modal.dart';
import 'package:vodda_providers/UI/Components/Popups/loading.dart';
import 'package:vodda_providers/UI/Components/Selectors/date-picker.dart';
import 'package:vodda_providers/UI/Components/Selectors/time-picker.dart';
import 'package:vodda_providers/UI/Views/User/MyTimes/holidays-list.dart';

class WeekList extends StatelessWidget {
  const WeekList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: Loading(
          getLoadedComponent: () => Column(
            children: [
              BackHeader(title: 'ساعات کاری'),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    width: maxItemWidth,
                    margin: EdgeInsets.only(
                      right: paddingSize,
                      left: paddingSize,
                    ),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          height: 145,
                          padding: EdgeInsets.only(
                            right: 20,
                            left: 25,
                            top: 20,
                            bottom: 25,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'در صورتی که در تاریخ مشخصی مایل به ارائه خدمات نیستید , از این قسمت میتوانید تاریخ مشخص کنید : ',
                                style: AppController.fontStyle(
                                  fontTypes.heading5,
                                  itemColor2,
                                ),
                              ),
                              Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Btn(btnType.primary,height:35,text:'ثبت تاریخ',width: 150,onClick: (){
                                  //   Holiday newHoliday=Holiday(date: '${MainController.years.keys.elementAt(0)}-01-01'
                                  //       ,startHour: TimeOfDay.now().hour,startMinute: TimeOfDay.now().minute,endHour: TimeOfDay.now().hour,endMinute: TimeOfDay.now().minute);
                                  //   showBottomModal(context, 500, Container(
                                  //       width: maxItemWidth,
                                  //       child: Column(
                                  //         children: [
                                  //           Expanded(
                                  //             child: Column(
                                  //               crossAxisAlignment: CrossAxisAlignment.start,
                                  //               children: [
                                  //                 Text('تاریخ :',style: AppController.fontStyle(fontTypes.heading4, itemColor4),),
                                  //                 SizedBox(height: 10,),
                                  //                 DatePicker(onSelect: (str){
                                  //                   newHoliday.date=str;
                                  //                 }),
                                  //                 SizedBox(height: 10,),
                                  //                 Text('ساعت شروع :',style: AppController.fontStyle(fontTypes.heading4, itemColor4),),
                                  //                 SizedBox(height: 10,),
                                  //                 TimePicker(initialTime: TimeOfDay.now(),onSelect: (TimeOfDay? time){
                                  //                   newHoliday.startHour=time!.hour;
                                  //                   newHoliday.startMinute=time.minute;
                                  //                 }),
                                  //                 SizedBox(height: 10,),
                                  //                 Text('ساعت پایان :',style: AppController.fontStyle(fontTypes.heading4, itemColor4),),
                                  //                 SizedBox(height: 10,),
                                  //                 TimePicker(initialTime: TimeOfDay.now(),onSelect: (TimeOfDay? time){
                                  //                   newHoliday.endHour=time!.hour;
                                  //                   newHoliday.endMinute=time.minute;                  }),
                                  //               ],
                                  //             ),
                                  //           ),
                                  //           Container(
                                  //               padding: EdgeInsets.only(bottom: paddingSize),
                                  //               child: Btn(btnType.primary,text: 'ثبت ساعت',onClick: (){
                                  //                 Navigator.pop(context);
                                  //                 MainController.addHoliday(newHoliday);
                                  //               },))
                                  //         ],
                                  //       )),title: 'افزودن بازه زمانی');
                                  // },),
                                  Btn(
                                    btnType.primary,
                                    height: 35,
                                    text: 'لیست تعطیلات',
                                    width: 150,
                                    onClick: () {
                                      MainController.getHolidays();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (builder) => HolidaysList(),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              // Container(
                              //   height: 35,width: 135,
                              //   decoration: BoxDecoration(
                              //     color: AppController.primaryColor,
                              //     borderRadius: BorderRadius.circular(5),
                              //   ),
                              //   child: Center(
                              //     child: Text('تنظیم تاریخ',
                              //       style: AppController.fontStyle(fontType.heading4, whiteColor),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                'از این قسمت میتوانید برای هر روز از هفته , ساعت کاری مشخص کنید .',
                                maxLines: null,
                                style: AppController.fontStyle(
                                  fontTypes.heading5,
                                  itemColor2,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 25),
                        Column(
                          children: [
                            for (int day = 0; day < 7; day++) WeekItem(day),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
