
class Currency {
  String country;
  String countryName;
  String currency;

  Currency(

      {
        this.country,
        this.countryName,
        this.currency,
      });


  Currency.fromJson(Map json)
      :
        country = json['country_code'],
        countryName = json['country_name'],
        currency = json['currency'];

}