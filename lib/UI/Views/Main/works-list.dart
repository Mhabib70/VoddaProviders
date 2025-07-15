import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Logic/Controllers/main-controller.dart';
import 'package:vodda_providers/Logic/Controllers/user-controller.dart';
import 'package:vodda_providers/Public/images.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/Buttons/btn.dart';
import 'package:vodda_providers/UI/Components/General/img.dart';
import 'package:vodda_providers/UI/Components/Inputs/input.dart';
import 'package:vodda_providers/UI/Components/Items/order-item.dart';
import 'package:vodda_providers/UI/Components/Lists/order-list.dart';
import 'package:vodda_providers/UI/Components/Popups/bottom-modal.dart';
import 'package:vodda_providers/UI/Components/Popups/loading.dart';
import 'package:vodda_providers/UI/Components/Selectors/select-box.dart';

class WorksList extends StatelessWidget {
  const WorksList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        // SizedBox(height: 10,),
        // Padding(
        //   padding: const EdgeInsets.only(left: paddingSize,right: paddingSize),
        //   child: Input(lable: 'جستجو در لیست کارها ...',icon1: Icon(Icons.search,size: 25,color: itemColor4),onChange: (text){
        //
        //   }),
        // ),
        SizedBox(height: 15),
        Expanded(
          child: Obx(() {
            return Container(
              width: size.width,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  OrderList(
                    MainController.sugestedOrders.value.values
                        .where(
                          (element) =>
                              (MainController.filterDay.value != null
                                  ? element.fullDate!.startsWith(
                                      MainController.filterDay.value!,
                                    )
                                  : true) &&
                              (MainController.filterType.value != null
                                  ? element.type ==
                                        MainController.filterType.value
                                  : true),
                        )
                        .toList()
                        .reversed
                        .toList(),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 30,
                    left: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: AppController.primaryColor,
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: FloatingActionButton(
                            heroTag: 'filter',
                            onPressed: () {
                              showBottomModal(
                                context,
                                450,
                                Column(
                                  children: [
                                    SizedBox(height: 40),
                                    Container(
                                      width: maxItemWidth,
                                      child: Row(
                                        children: [
                                          Text(
                                            'انتخاب روز :',
                                            style: AppController.fontStyle(
                                              fontTypes.heading4,
                                              itemColor2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    SelectBox(
                                      value: MainController.filterDay.value,
                                      options: {
                                        'هر روز': null,
                                        for (var day
                                            in MainController.days.values)
                                          day: day,
                                      },
                                      onSelect: (value) {
                                        MainController.filterDay.value = value;
                                      },
                                    ),
                                    SizedBox(height: 40),
                                    Container(
                                      width: maxItemWidth,
                                      child: Row(
                                        children: [
                                          Text(
                                            'نوع خدمات :',
                                            style: AppController.fontStyle(
                                              fontTypes.heading4,
                                              itemColor2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(height: 10),
                                    SelectBox(
                                      text: '',
                                      icon: Img(
                                        infoIcon,
                                        width: 18,
                                        height: 18,
                                        color: itemColor2,
                                      ),
                                      value: MainController.filterType.value,
                                      options: {
                                        'همه': null,
                                        'فراخوان': 0,
                                        'انتخابی': 1,
                                      },
                                      onSelect: (value) {
                                        MainController.filterType.value = value;
                                      },
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Btn(
                                            btnType.primary,
                                            text: 'بستن',
                                            onClick: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: paddingSize),
                                  ],
                                ),
                                title: 'فیلتر ها',
                              );
                            },
                            child: Img(filterIcon),
                          ),
                        ),
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: Loading(
                            getLoadedComponent: () => FloatingActionButton(
                              heroTag: 'online',
                              backgroundColor:
                                  UserController.user.value.online == 1
                                  ? successColor
                                  : warningColor,
                              child: Text(
                                UserController.user.value.online == 1
                                    ? 'آنلاین'
                                    : 'آفلاین',
                              ),
                              onPressed: () async {
                                await MainController.setOnline();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
