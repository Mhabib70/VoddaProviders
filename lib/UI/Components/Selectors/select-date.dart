import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vodda_providers/Logic/Controllers/main-controller.dart';
import 'package:vodda_providers/UI/Components/Items/date-item.dart';
import 'package:vodda_providers/UI/Components/Items/order-item.dart';
import 'package:vodda_providers/UI/Components/Lists/empty-work-list.dart';
import 'package:vodda_providers/UI/Components/Lists/order-list.dart';

class SelectDate extends StatefulWidget {
  SelectDate({Key? key}) : super(key: key);

  @override
  _SelectDateState createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  String? selectedDate;

  @override
  Widget build(BuildContext context) {
    print(
      'aaa>>>${MainController.myOrders.values.where((element) => element.state == 2).length}',
    );
    return MainController.myOrders.values
                .where((element) => element.state == 2)
                .length >
            0
        ? SingleChildScrollView(
            child: Column(
              children: [
                ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    dragDevices: {
                      PointerDeviceKind.touch,
                      PointerDeviceKind.mouse,
                    },
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    child: Container(
                      height: 140,
                      child: Row(
                        textDirection: TextDirection.ltr,
                        children: [
                          for (var date
                              in MainController.myOrdersDates.values.where(
                                (element) =>
                                    element.orderIds != null &&
                                    element.orderIds.length > 0,
                              ))
                            DateItem(
                              date,
                              selected: selectedDate == date.value,
                              onClick: () {
                                setState(() {
                                  selectedDate = date.value;
                                });
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                if (selectedDate != null)
                  for (var orderId
                      in MainController.myOrdersDates[selectedDate]!.orderIds)
                    OrderItem(MainController.myOrders[orderId]!),
                // OrderList(MainController.myOrders.value.values.where((order) => MainController.myOrdersDates[selectedIndex].orderIds.contains(order.id)).toList())
              ],
            ),
          )
        : EmptyWorkList();
  }
}
