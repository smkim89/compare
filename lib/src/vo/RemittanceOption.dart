
class RemittanceOption {
  String remittanceOptionCode;
  String remittanceOptionName;

  RemittanceOption(
      {this.remittanceOptionCode,
        this.remittanceOptionName
      });

  RemittanceOption.fromJson(Map json)
      : remittanceOptionCode = json['remittanceOptionCode'],
        remittanceOptionName = json['remittanceOptionName'];
}