import 'package:flutter/foundation.dart';
import 'package:vodda_providers/Logic/Controllers/user-controller.dart';
import 'package:vodda_providers/Logic/Models/comment.dart';
import 'package:vodda_providers/Logic/Models/service.dart';

class User {
  int? id;
  String? fname;
  String? lname;
  String? fatherName;
  String? mobile;
  String? tell;
  String? degree;
  String? numberCard;
  int? married;
  int? sex;
  int? online;
  int? score;
  String? nationalCode;
  String? inviteCode;
  String? code;
  int? provinceId;
  int? cityId;
  String? place;
  int? state;
  String? errorMessage;
  List<String>? errorDocuments;
  String? titleState;
  int? serviceCount;
  String? avatar;
  String? totalWallet;
  String? lat;
  String? long;
  List<Service> services = [];
  List<int> serviceIds = [];
  String? rate;
  String? typeTitle;
  String? cv;
  String? notificationToken;
  String? provinceNotifToken;
  int? orderCount;
  int? orderInProgressCount;
  List<Comment> comments = [];

  int? permision_questions;

  User({
    this.id,
    this.fname,
    this.lname,
    this.mobile,
    this.married,
    this.nationalCode,
    this.cityId,
    this.place,
    this.provinceId,
    this.state,
    this.errorMessage,
    this.errorDocuments,
    this.sex,
    this.titleState,
    this.serviceCount,
    this.avatar,
    this.totalWallet,
    this.services = const [],
    this.rate,
    this.orderCount,
    this.orderInProgressCount,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fname = json['fname'];
    lname = json['lname'];
    mobile = json['mobile'];
    permision_questions = json['permision_questions'];
    notificationToken = json['notification_token'];
    provinceNotifToken = json['province_notif'];
    married = json['married'];
    nationalCode = json['national_code'];
    inviteCode = json['invite_code'];
    code = json['code'];
    cityId = json['city_id'];
    place = json['place'];
    provinceId = json['province_id'];
    state = json['state'];
    errorMessage = json['error_message'];
    lat = json['lat'];
    long = json['long'];
    fatherName = json['father_name'];
    numberCard = json['number_card'];
    tell = json['tell'];
    degree = json['degree'];
    if (json['error_documents'] != "" && json['error_documents'] != null)
      errorDocuments = json['error_documents'].cast<String>();
    else
      errorDocuments = [];
    sex = json['sex'];
    online = json['online'];
    score = json['score'];
    typeTitle = json['type_title'];
    cv = json['cv'];
    titleState = json['title_state'];
    serviceCount = json['service_count'];
    avatar = kIsWeb ? json['avatar_pwa'] : json['avatar'];
    totalWallet = json['total_wallet'];
    if (json['services'] != null) {
      json['services'].forEach((servicejson) {
        Service service = Service.fromJson(servicejson);
        services.add(service);
        serviceIds.add(service.id!);
      });
    }
    if (json['comments'] != null) {
      for (var commentJson in json['comments']) {
        Comment comment = Comment.fromJson(commentJson);
        comments.add(comment);
      }
    }
    rate = json['rate'];
    orderCount = json['order_count'];
    orderInProgressCount = json['order_in_progress_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    data['mobile'] = this.mobile;
    data['married'] = this.married;
    data['national_code'] = this.nationalCode;
    data['city_id'] = this.cityId;
    data['place'] = this.place;
    data['province_id'] = this.provinceId;
    data['state'] = this.state;
    data['error_message'] = this.errorMessage;
    data['error_documents'] = this.errorDocuments;
    data['sex'] = this.sex;
    data['invite_code'] = this.inviteCode;
    data['title_state'] = this.titleState;
    data['cv'] = this.cv;
    data['avatar'] = this.avatar;
    data['total_wallet'] = this.totalWallet;
    data['service_count'] = this.serviceIds.length;
    for (int i = 0; i < serviceIds.length; i++) {
      data['service_${i}'] = this.serviceIds[i];
    }
    data['rate'] = this.rate;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['order_count'] = this.orderCount;
    data['order_in_progress_count'] = this.orderInProgressCount;
    data['father_name'] = fatherName;
    data['number_card'] = numberCard;
    data['tell'] = tell;
    data['degree'] = degree;
    return data;
  }
}
