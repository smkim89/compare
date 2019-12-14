import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:compare/src/vo/CompanyRate.dart';

class API {
  final http.Client _client = http.Client();
  static const String _url = "https://jsonplaceholder.typicode.com/todos";



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

  Future<List<CompanyRate>> getCompanyRateList() async {


    return tempList;
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
