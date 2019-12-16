
class Currency {
  String country;
  String countryName;
  String currency;
  String currencyImg;
  String currencyCode;
  int defaultAmount;

  Currency(

      {
        this.country,
        this.countryName,
        this.currency,
        this.currencyImg,
        this.currencyCode,
        this.defaultAmount
      });

  Currency.fromJson(Map json)
      :
        country = json['country'],
        countryName = json['countryName'],
        currency = json['currency'],
        currencyImg = json['currencyImg'],
        currencyCode = json['currencyCode'],
        defaultAmount = json['currencyCode'];
}