class Account {
  int? id;
  int? providerId;
  String? title;
  String? cardNumber;
  String? accountNumber;
  String? shebaNumber;
  String? formattedCardNumber;

  Account(
      {this.id,
        this.providerId,
        this.title,
        this.cardNumber});

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerId = json['provider_id'];
    title = json['title'];
    cardNumber = json['card_number'];
    accountNumber = json['account_number'];
    shebaNumber = json['shaba_number'];
    formattedCardNumber = json['formatted_card_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['card_number'] = this.cardNumber;
    data['account_number'] = this.accountNumber;
    data['shaba_number'] = this.shebaNumber;
    return data;
  }
}
