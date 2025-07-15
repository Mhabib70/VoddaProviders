import 'package:vodda_providers/Logic/Models/order.dart';

class Date {
  String? key;
  String? value;
  String? day;
  String? weekDay;
  String? month;
  List<int> orderIds = [];

  Date({this.key, this.value, this.day, this.weekDay, this.month});

  Date.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
    day = json['day'];
    weekDay = json['week_day'];
    month = json['month'];
    if (json['orders'] != null) {
      for (var orderJson in json['orders']) {
        Order order = Order.fromJson(orderJson);
        orderIds.add(order.id!);
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    data['day'] = this.day;
    data['week_day'] = this.weekDay;
    data['month'] = this.month;
    return data;
  }
}
