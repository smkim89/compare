import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:compare/src/vo/CompanyRate.dart';
import 'package:compare/src/vo/RemittanceOption.dart';
import 'package:compare/src/vo/Currency.dart';
import 'package:dio/dio.dart';

class API {
  final http.Client _client = http.Client();
  static const String _url =
      "https://3baade5kxf.execute-api.ap-northeast-2.amazonaws.com/test";

  static final API _singleton = API._internal();

  Dio dio = new Dio();

  factory API() {
    return _singleton;
  }

  API._internal();



  var _remittanceOptions = <RemittanceOption>[
    RemittanceOption(
        remittanceOptionCode: "CASH_PICK_UP",
        remittanceOptionName: "Cash Pay Out"),
    RemittanceOption(
        remittanceOptionCode: "BANK_TRANSFER",
        remittanceOptionName: "Bank Account Pay Out")
  ];



  Future<List<CompanyRate>> getCompanyRateList(String currency, String country) async {

    List<CompanyRate> list = [];
    await dio.get("https://n28wlgso4f.execute-api.ap-northeast-2.amazonaws.com/real/getservicecompare?currency="+currency+"&country="+country).then((res) => res.data).then(
            (companyRateList) => companyRateList
            .forEach((companyRate) => list.add(CompanyRate.fromJson(companyRate))));


    print('????');
    return list;
  }

  Future<List<RemittanceOption>> getRemittanceOptionList(String currency) async {
    return _remittanceOptions;
  }

  Future<List<Currency>> getCoverage() async {
    List<Currency> list = [];

    print('!!!');


    await dio.get("$_url/getCoverage").then((res) => res.data['body']).then(
            (currencyList) => currencyList
            .forEach((currency) => list.add(Currency.fromJson(currency))));


    return list;
  }


}
