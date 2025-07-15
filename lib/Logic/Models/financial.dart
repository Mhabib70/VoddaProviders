class Financial {
  int? id;
  int? providerId;
  String? date;
  String? amount;
  int? type;
  String? accountNumber;
  String? code;
  String? description;
  String? typeTitle;
  String? dateTitle;

  Financial(
      {this.id,
        this.providerId,
        this.date,
        this.amount,
        this.type,
        this.accountNumber,
        this.code,
        this.description,
        this.typeTitle,
        this.dateTitle});

  Financial.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerId = json['provider_id'];
    date = json['date'];
    amount = json['amount'];
    type = json['type'];
    accountNumber = json['account_number'];
    code = json['code'];
    description = json['description'];
    typeTitle = json['type_title'];
    dateTitle = json['date_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['provider_id'] = this.providerId;
    data['date'] = this.date;
    data['amount'] = this.amount;
    data['type'] = this.type;
    data['account_number'] = this.accountNumber;
    data['code'] = this.code;
    data['description'] = this.description;
    data['type_title'] = this.typeTitle;
    data['date_title'] = this.dateTitle;
    return data;
  }
}
