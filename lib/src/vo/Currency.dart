
class Currency {
  String currency;
  String currencyImg;
  String currencyCode;

  Currency(
      {this.currency,
        this.currencyImg,
        this.currencyCode});

  Currency.fromJson(Map json)
      : currency = json['currency'],
        currencyImg = json['currencyImg'],
        currencyCode = json['currencyCode'];
}