
class CompanyRate {
  String companyName;
  String countryCode;
  String currency;
  String remittanceOption;
  double rate;
  String companyLogo;
  String webUrl;
  String aosUrl;
  String iosUrl;

  CompanyRate(
      {this.companyName,
        this.countryCode,
        this.currency,
        this.remittanceOption,
        this.rate,
        this.companyLogo,
        this.webUrl,
        this.aosUrl,
        this.iosUrl



      });

  CompanyRate.fromJson(Map json)
      : companyName = json['companyName'],
        countryCode = json['countryCode'],
        currency = json['currency'],
        remittanceOption = json['remittanceOption'],
        rate = json['rate'],
        companyLogo = json['companyLogo'],
        webUrl = json['webUrl'],
        aosUrl = json['aosUrl'],
        iosUrl = json['iosUrl'];




}