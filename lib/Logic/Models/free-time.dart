class FreeTime {
  int? id;
  String? startTime;
  String? endTime;
  int? providerId;
  int? day;

  FreeTime({this.id, this.startTime, this.endTime, this.providerId, this.day});

  FreeTime.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    providerId = json['provider_id'];
    day = json['day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['provider_id'] = this.providerId;
    data['day'] = this.day;
    return data;
  }
}
