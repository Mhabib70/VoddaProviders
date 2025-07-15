class Wallet {
  int? id;
  int? providerId;
  String? amount;
  int? type;
  String? description;
  int? walletId;
  String? walletType;
  String? date;
  String? time;
  String? typeTitle;

  Wallet(
      {this.id,
        this.providerId,
        this.amount,
        this.type,
        this.description,
        this.walletId,
        this.walletType,
        this.date,
        this.time,
        this.typeTitle});

  Wallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerId = json['provider_id'];
    amount = json['amount'];
    type = json['type'];
    description = json['description'];
    walletId = json['wallet_id'];
    walletType = json['wallet_type'];
    date = json['date'];
    time = json['time'];
    typeTitle = json['type_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['provider_id'] = this.providerId;
    data['amount'] = this.amount;
    data['type'] = this.type;
    data['description'] = this.description;
    data['wallet_id'] = this.walletId;
    data['wallet_type'] = this.walletType;
    data['date'] = this.date;
    data['time'] = this.time;
    data['type_title'] = this.typeTitle;
    return data;
  }
}
