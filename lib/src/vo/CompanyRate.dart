
class CompanyRate {
  String companyName;
  String countryCode;
  String countryName;
  String currency;
  String remittanceOption;
  double rate;
  int fee;
  String companyLogo;
  String webUrl;
  String aosUrl;
  String iosUrl;

  CompanyRate(
      {this.companyName,
        this.countryCode,
        this.countryName,
        this.currency,
        this.remittanceOption,
        this.rate,
        this.fee,
        this.companyLogo,
        this.webUrl,
        this.aosUrl,
        this.iosUrl



      });

  CompanyRate.fromJson(Map json)
      : companyName = json['companyName'],
        countryCode = json['countryCode'],
        countryName = json['countryName'],
        currency = json['currency'],
        remittanceOption = json['remittanceOption'],
        rate = json['rate'],
        fee = json['fee'],
        companyLogo = json['companyLogo'],
        webUrl = json['webUrl'],
        aosUrl = json['aosUrl'],
        iosUrl = json['iosUrl'];




}