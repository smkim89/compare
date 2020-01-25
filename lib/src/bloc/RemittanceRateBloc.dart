
import 'dart:async';
import 'package:compare/src/vo/CompanyRate.dart';
import 'package:compare/src/vo/Currency.dart';
import 'package:compare/src/vo/RemittanceOption.dart';
import 'package:compare/src/repository/API.dart';

class RemittanceRateBloc{

  final API api;

  StreamController<List<CompanyRate>> ctrl = StreamController();
  Stream<List<CompanyRate>> get results => ctrl.stream; // 바로 스트림에 접근하지 않기 위해 사용함.

  StreamController<List<Currency>> currencyStream = StreamController();
  Stream<List<Currency>> get currencyStreamResults => currencyStream.stream; // 바로 스트림에 접근하지 않기 위해 사용함.

  StreamController<List<RemittanceOption>> remittanceOptionStream = StreamController();
  Stream<List<RemittanceOption>> get remittanceOptionStreamResults => remittanceOptionStream.stream; // 바로 스트림에 접근하지 않기 위해 사용함.



  RemittanceRateBloc(this.api);

  void dispose() {
    ctrl.close(); // 스트림은 안 쓸 때 닫아줘야합니다.
    currencyStream.close();
  }

  void getCompanyRate(String currency, String country) {
    api.getCompanyRateList(currency, country).then((companyRates) {
      ctrl.add(companyRates);
    });
  }


  void getCurrency() {
    api.getCoverage().then((currencys) {
      currencyStream.add(currencys);
    });
  }

  void getRemittanceOptionList(String currency) {
    api.getRemittanceOptionList(currency).then((remittanceOptionList) {
      remittanceOptionStream.add(remittanceOptionList);
    });
  }

}