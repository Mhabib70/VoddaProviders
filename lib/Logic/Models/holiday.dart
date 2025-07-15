import 'package:flutter/material.dart';
import 'package:vodda_providers/Logic/Controllers/main-controller.dart';

class Holiday {
  int? id;
  String? startDate;
  String? endDate;
  int? providerId;
  int? addressId;
  int? startYear;
  int? startMonth;
  int? startDay;
  int? startHour;
  int? startMinute;
  int? endHour;
  int? endMinute;
  String? startFullTime;
  String? endFullTime;

  String? date;
  Holiday({
    this.id,
    this.startDate,
    this.endDate,
    this.providerId,
    this.startYear,
    this.startMonth,
    this.startDay,
    this.startHour,
    this.startMinute,
    this.endHour,
    this.endMinute,
    this.startFullTime,
    this.endFullTime,
    this.date,
  });

  Holiday.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    providerId = json['provider_id'];
    addressId = json['address_id'];
    startYear = json['start_year'];
    startMonth = json['start_month'];
    startDay = json['start_day'];
    startHour = json['start_hour'];
    startMinute = json['start_minute'];
    endHour = json['end_hour'];
    endMinute = json['end_minute'];
    startFullTime = json['start_full_time'];
    endFullTime = json['end_full_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address_id'] = this.addressId;
    data['start_date'] =
        '${this.date} ${startHour.toString().padLeft(2, '0')}:${startMinute.toString().padLeft(2, '0')}:00';
    data['end_date'] =
        '${this.date} ${endHour.toString().padLeft(2, '0')}:${endMinute.toString().padLeft(2, '0')}:00';
    data['start_year'] = startYear;
    data['start_month'] = startMonth;
    data['start_day'] = startDay;
    data['start_hour'] = startHour;
    data['start_minute'] = startMinute;
    data['end_hour'] = endHour;
    data['end_minute'] = endMinute;
    data['start_full_time'] = startFullTime;
    data['end_full_time'] = endFullTime;
    return data;
  }
}
