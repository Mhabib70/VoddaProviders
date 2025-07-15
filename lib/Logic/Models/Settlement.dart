class Settlement {
  int? id;
  int? providerId;
  int? accountId;
  String? amount;
  int? state;
  String? description;
  String? stateTitle;
  String? date;

  Settlement(
      {this.id,
        this.providerId,
        this.accountId,
        this.amount,
        this.state,
        this.description,
        this.date,
        this.stateTitle});

  Settlement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerId = json['provider_id'];
    accountId = json['account_id'];
    amount = json['amount'];
    state = json['state'];
    description = json['description']==null?'':json['description'];
    date = json['date'];
    stateTitle = json['state_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['provider_id'] = this.providerId;
    data['account_id'] = this.accountId;
    data['amount'] = this.amount;
    data['state'] = this.state;
    data['description'] = this.description;
    data['date'] = this.date;
    data['state_title'] = this.stateTitle;
    return data;
  }
}