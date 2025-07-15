import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Logic/Controllers/main-controller.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/General/myDivider.dart';
import 'package:vodda_providers/UI/Components/Items/order-item.dart';
import 'package:vodda_providers/UI/Components/Lists/order-list.dart';
import 'package:vodda_providers/UI/Components/Selectors/select-date.dart';

class MyWorks extends StatelessWidget {
  const MyWorks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Container(
            height: 50,
            width: maxItemWidth,
            alignment: Alignment.centerRight,
            child: TabBar(
              labelColor: itemColor1,
              unselectedLabelColor: itemColor3,
              indicatorWeight: 3,
              indicatorColor: AppController.primaryColor,
              tabs: [
                // Container(
                //   height: 50,
                //   alignment: Alignment.center,
                //   child: Text('در حال انتظار', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),),),
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    'در حال انجام',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    'انجام شده',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    ' لغو شده',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: MyDivider(padding: paddingSize),
            width: maxItemWidth,
          ),
          SizedBox(height: 20),
          Expanded(
            child: Obx(() {
              return TabBarView(
                children: [
                  // OrderList(MainController.myOrders.value.values.where((order) => order.state==1).toList()),
                  // OrderList(MainController.myOrders.value.values.where((order) => order.state==2).toList()),
                  SelectDate(),
                  OrderList(
                    MainController.myOrders.value.values
                        .where((order) => order.state == 3)
                        .toList(),
                  ),
                  OrderList(
                    MainController.myOrders.value.values
                        .where((order) => order.state == 0 || order.state == 4)
                        .toList(),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
