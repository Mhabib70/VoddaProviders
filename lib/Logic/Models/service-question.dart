
class ServiceQuestion{
  int? id;
  String? title;
  int? type;
  int? max;
  int? required;
  int? targetQuestionId;
  int? serviceId;
  List<int> optionIds=[];
  ServiceQuestion({this.id, this.title, this.type, this.max,this.required,this.serviceId,this.targetQuestionId});

  ServiceQuestion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceId = json['service_id'];
    title = json['title'];
    type = json['type'];
    max = json['max'];
    required = json['required'];
    targetQuestionId = json['target_question_id'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['type'] = this.type;
    data['max'] = this.max??0;
    data['required'] = this.required;
    data['service_id'] = this.serviceId;
    data['target_question_id'] = this.targetQuestionId??0;

    return data;
  }
}