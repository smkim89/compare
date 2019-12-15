import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:compare/src/vo/CompanyRate.dart';
import 'package:compare/src/vo/RemittanceOption.dart';
import 'package:compare/src/vo/Currency.dart';

class API {
  final http.Client _client = http.Client();
  static const String _url = "https://jsonplaceholder.typicode.com/todos";




  String currency;
  String currencyImg;
  String currencyCode;

  var tempList = <CompanyRate>[
    CompanyRate(
        companyName: "Hanpass",
        countryCode: "BD",
        currency: "BDT",
        remittanceOption: "CASH_PICK_UP",
        rate: 11.55),
    CompanyRate(
        companyName: "Hanpass",
        countryCode: "BD",
        currency: "BDT",
        remittanceOption: "BANK_TRANSFER",
        rate: 11.23),
    CompanyRate(
        companyName: "E9PAY",
        countryCode: "BD",
        currency: "BDT",
        remittanceOption: "CASH_PICK_UP",
        rate: 10.55)
  ];

  var _remittanceOptions = <RemittanceOption>[
    RemittanceOption(
        remittanceOptionCode: "CASH_PICK_UP",
        remittanceOptionName: "Cash Pay Out"),
    RemittanceOption(
        remittanceOptionCode: "BANK_TRANSFER",
        remittanceOptionName: "Bank Account Pay Out")
  ];

  var _currencyList = <Currency>[
    Currency(
        currency: "USD",
        currencyImg: "https://shop.r10s.jp/tospa/cabinet/406104.gif",
        currencyCode: "\$"),
    Currency(
        currency: "BDT",
        currencyImg: "http://image.auction.co.kr/itemimage/c0/41/3a/c0413a956.jpg",
        currencyCode: "\$"),
  ];



  Future<List<CompanyRate>> getCompanyRateList() async {

    return tempList;
  }

  Future<List<RemittanceOption>> getRemittanceOptionList(String currency) async {

    return _remittanceOptions;
  }

  Future<List<Currency>> getCurrencyList() async {

    return _currencyList;
  }

//
//  Future<List<CompanyRate>> getCompanyRateList() async {
//    List<CompanyRate> list = [];
//    await _client
//        .get(Uri.parse(_url))
//        .then((res) => res.body)
//        .then(json.decode)
//        .then((todos) =>
//            todos.forEach((todo) => list.add(CompanyRate.fromJson(todo))));
//    return list;
//  }
}
