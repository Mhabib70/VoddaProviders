import 'package:flutter/foundation.dart';
import 'package:vodda_providers/Logic/Models/service-question.dart';

class Service {
  int? id;
  String? title;
  String? description;
  String? createdAt;
  String? updatedAt;
  int? categoryId;
  String? price;
  int? time;
  String? providerPrice;
  int? providerTime;
  int? typePlace;
  int? typePay;
  int? type;
  int? type_online;
  String? notificationToken;
  int? providerCount;
  int? orderProgressCount;
  int? orderCount;
  int? isActiveDetail;
  int? negotiable;
  bool? isFavorite;
  List<String> images = [];
  List<int> questionIds = [];

  Service({
    this.id,
    this.title,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.categoryId,
    this.price,
    this.time,
    this.type,
    this.typePlace,
    this.typePay,
    this.isFavorite,
    this.providerTime,
    this.providerPrice,
    this.isActiveDetail,
  });

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryId = json['category_id'];
    price = json['price'];
    time = json['time'];
    negotiable = json['negotiable'];
    type_online = json['type_online'];
    providerPrice = json['provider_price'];
    providerTime = json['provider_time'];
    type = json['type'];
    typePlace = json['type_place'];
    notificationToken = json['notification_token'];
    typePay = json['type_pay'];
    isFavorite = json['is_favorite'];
    providerCount = json['provider_count'];
    orderCount = json['order_count'];
    orderProgressCount = json['order_in_progress_count'];
    isActiveDetail = json['is_active_detail'];
    if (json['images'] != null) {
      for (var image in json['images'])
        images.add(kIsWeb ? image['file_pwa'] : image['file']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_id'] = this.id;
    // data['title'] = this.title;
    // data['description'] = this.description;
    // data['created_at'] = this.createdAt;
    // data['updated_at'] = this.updatedAt;
    // data['category_id'] = this.categoryId;
    data['price'] = this.providerPrice;
    data['time'] = this.providerTime;
    data['is_active_detail'] = this.isActiveDetail;
    // data['type'] = this.type;
    // data['type_place'] = this.typePlace;
    // data['type_pay'] = this.typePay;
    // data['is_favorite']= this.isFavorite;
    return data;
  }
}
