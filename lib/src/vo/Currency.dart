
class Currency {
  String currency;
  String currencyImg;
  String currencyCode;
  int defaultAmount;

  Currency(
      {this.currency,
        this.currencyImg,
        this.currencyCode,
        this.defaultAmount
      });

  Currency.fromJson(Map json)
      : currency = json['currency'],
        currencyImg = json['currencyImg'],
        currencyCode = json['currencyCode'],
        defaultAmount = json['currencyCode'];
}