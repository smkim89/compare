
class CompanyRate {

  String companyCode;
  String companyName;
  String companyNameEnglish;
  String companyLogo;
  String webUrl;
  String aosUrl;
  String iosUrl;
  String countryCode;
  String countryName;
  String currency;
  String remittanceOption;
  double rate;
  double reverseRate;
  int fee;

  CompanyRate(
      {this.companyCode,
        this.companyName,
        this.companyNameEnglish,
        this.companyLogo,
        this.webUrl,
        this.aosUrl,
        this.iosUrl,
        this.countryCode,
        this.countryName,
        this.currency,
        this.remittanceOption,
        this.rate,
        this.reverseRate,
        this.fee,

      });

  CompanyRate.fromJson(Map json)
      : companyCode = json['company_code'],
        companyName = json['company_name'],
        companyNameEnglish = json['company_name_english'],
        companyLogo = json['company_logo'],
        webUrl = json['company_home'],
        aosUrl = json['company_aos_url'],
        iosUrl = json['company_ios_url'],
        countryCode = json['country_code'],
        countryName = json['country_name'],
        currency = json['currency'],
        remittanceOption = json['remittance_option'],
        rate = json['rate'],
        reverseRate = json['reverse_rate'],
        fee = json['fee'];



}