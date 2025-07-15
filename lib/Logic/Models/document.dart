class Document {
  String? title;
  String? group;
  bool hasError=false;

  Document({this.title, this.group});

  Document.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    group = json['group'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['group'] = this.group;
    return data;
  }
}
