import 'package:flutter/cupertino.dart';
import 'package:vodda_providers/Logic/Models/addition.dart';
import 'package:vodda_providers/Logic/Models/order-document.dart';
import 'package:vodda_providers/Logic/Models/order-question.dart';
import 'package:vodda_providers/Logic/Models/service.dart';
import 'package:vodda_providers/Public/images.dart';
import 'package:vodda_providers/Public/styles.dart';

class Order {
  int? id;
  int? userId;
  int? serviceId;
  int? providerId;
  String? address;
  String? username;
  String? userMobile;
  String? date;
  int? typeDate;
  String? code;
  int? state;
  int? acceptedProviderId;
  var price;
  int? durationTime;
  int? cityId;
  var description;
  int? typePay;
  int? type;
  int? canceled;
  String? typeTitle;
  String? fullAddress;
  String? fullDate;
  String? fullTime;
  String? time;
  String? typePayTitle;
  int? typeCall;
  String? stateTitle;
  int? countProvider;
  var acceptedProvider;
  var rate;
  bool? isRate;
  bool? isStarted;
  bool? isMyRequested;
  Service? service;
  Map<int, OrderQuestion>? questions;
  String? providerDescription;
  double? lat;
  double? long;
  List<Addition> additions = [];
  String? stateIcon;
  Color? stateColor;

  bool? hasDocument;
  Map<int, OrderDocument> documents = <int, OrderDocument>{};

  String cancelDescription = '';

  Order({
    this.id,
    this.userId,
    this.serviceId,
    this.providerId,
    this.address,
    this.username,
    this.date,
    this.typeDate,
    this.code,
    this.state,
    this.acceptedProviderId,
    this.price,
    this.durationTime,
    this.cityId,
    this.description,
    this.typePay,
    this.type,
    this.typeTitle,
    this.fullAddress,
    this.fullDate,
    this.fullTime,
    this.typePayTitle,
    this.stateTitle,
    this.countProvider,
    this.acceptedProvider,
    this.rate,
    this.isRate,
    this.isMyRequested,
    this.service,
    this.providerDescription,
    this.questions,
  });

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    serviceId = json['service_id'];
    providerId = json['provider_id'];
    address = json['address'];
    username = json['user_name'];
    userMobile = json['user_mobile'];
    date = json['date'];
    hasDocument = json['has_document'];
    typeDate = json['type_date'];
    typeCall = json['type_call'];
    code = json['code'];
    state = json['state'];
    acceptedProviderId = json['accepted_provider_id'];
    price = json['total_price'];
    durationTime = json['duration_time'];
    cityId = json['city_id'];
    description = json['description'];
    typePay = json['type_pay'];
    type = json['type'];
    canceled = json['canceled'];
    typeTitle = json['type_title'];
    fullAddress = json['full_address'];
    fullDate = json['full_date'];
    fullTime = json['full_time'];
    time = json['time'];
    typePayTitle = json['type_pay_title'];
    stateTitle = json['state_title'];
    setColorIconState();
    countProvider = json['count_provider'];
    acceptedProvider = json['accepted_provider'];
    rate = json['rate'];
    isRate = json['is_rate'];
    isStarted = json['is_started'];
    isMyRequested = json['is_my_requested'];
    providerDescription = json['provider_description'];
    if (id == 3) print('nullService>>>${json['service']}');
    service = json['service'] != null
        ? new Service.fromJson(json['service'])
        : null;
    if (json['questions'] != null) {
      questions = <int, OrderQuestion>{};
      json['questions'].forEach((v) {
        OrderQuestion question = OrderQuestion.fromJson(v);
        if (question.typeQuestion == 2 || question.typeQuestion == 3) {
          print("Path image:${question.path_image}");
          if (questions!.containsKey(question.questionId))
            // questions![question.questionId]!.res.add(question.typeQuestion==2?question.path_image:question.res);
            questions![question.questionId]!.res.add(question.res);
          else {
            // question.res=[question.typeQuestion==2?question.path_image:question.res];
            question.res = [question.res];
            questions![question.questionId!] = question;
          }
        } else
          questions![question.questionId!] = question;
      });
    }
    if (json['lat_long'] != null) {
      lat = double.parse(json['lat_long'].split(',').first);
      long = double.parse(json['lat_long'].split(',').last);
    }
    if (json['additions'] != null) {
      additions = [];
      for (var addition in json['additions'])
        additions.add(Addition.fromJson(addition));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['service_id'] = this.serviceId;
    data['provider_id'] = this.providerId;
    data['address'] = this.address;
    data['user_name'] = this.username;
    data['date'] = this.date;
    data['type_date'] = this.typeDate;
    data['code'] = this.code;
    data['state'] = this.state;
    data['accepted_provider_id'] = this.acceptedProviderId;
    data['price'] = this.price;
    data['duration_time'] = this.durationTime;
    data['city_id'] = this.cityId;
    data['description'] = this.description;
    data['type_pay'] = this.typePay;
    data['type'] = this.type;
    data['canceled'] = this.canceled;
    data['type_title'] = this.typeTitle;
    data['full_address'] = this.fullAddress;
    data['full_date'] = this.fullDate;
    data['full_time'] = this.fullTime;
    data['type_pay_title'] = this.typePayTitle;
    data['state_title'] = this.stateTitle;
    data['count_provider'] = this.countProvider;
    data['accepted_provider'] = this.acceptedProvider;
    data['rate'] = this.rate;
    data['is_rate'] = this.isRate;
    data['is_my_requested'] = this.isMyRequested;
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }

    return data;
  }

  setColorIconState() {
    switch (state) {
      case 1:
        stateIcon = waitingstateIcon;
        stateColor = waitingStateColor;
        break;
      case 2:
        stateIcon = doingstateIcon;
        stateColor = doingStateColor;
        break;
      case 3:
        stateIcon = donestateIcon;
        stateColor = doneStateColor;
        break;
      default:
        stateIcon = cancelstateIcon;
        stateColor = errorColor;
    }
  }
}
