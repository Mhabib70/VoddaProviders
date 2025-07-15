import 'package:flutter/material.dart';
import 'package:vodda_providers/Logic/Models/order.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/Items/order-item.dart';
import 'package:vodda_providers/UI/Components/Lists/empty-work-list.dart';

class OrderList extends StatelessWidget {
  List<Order> orders;
  OrderList(this.orders, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return orders.length > 0
        ? SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(left: paddingSize, right: paddingSize),
              child: Column(
                children: [
                  for (int i = 0; i < orders.length; i++) OrderItem(orders[i]),
                  SizedBox(height: 50),
                ],
              ),
            ),
          )
        : EmptyWorkList();
  }
}
