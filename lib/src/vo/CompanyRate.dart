
class CompanyRate {
  String companyName;
  String countryCode;
  String currency;
  String remittanceOption;
  double rate;

  CompanyRate(
      {this.companyName,
        this.countryCode,
        this.currency,
        this.remittanceOption,
        this.rate});

  CompanyRate.fromJson(Map json)
      : companyName = json['companyName'],
        countryCode = json['countryCode'],
        currency = json['currency'],
        remittanceOption = json['remittanceOption'],
        rate = json['rate'];
}