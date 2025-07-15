import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:vodda_providers/Logic/Models/service.dart';

class Category {
  int? id;
  String? title;
  String? type;
  bool? hasSub;
  int? categoryId;
  String? createdAt;
  String? updatedAt;
  String? icon;
  String? description;
  Category? parent;
  List<int> categoryIds = [];
  List<Service>? services;

  Category({
    this.id,
    this.title,
    this.type,
    this.hasSub,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    hasSub = json['has_sub'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    description = json['description'];
    icon = json['icon'];
    if (json['services'] != null) {
      services = <Service>[];
      json['services'].forEach((v) {
        services!.add(new Service.fromJson(v));
      });
    }
  }
}
