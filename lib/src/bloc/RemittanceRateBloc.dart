
import 'dart:async';
import 'package:compare/src/vo/CompanyRate.dart';
import 'package:compare/src/repository/API.dart';

class RemittanceRateBloc{

  final API api;

  StreamController<List<CompanyRate>> ctrl = StreamController();

  Stream<List<CompanyRate>> get results => ctrl.stream; // 바로 스트림에 접근하지 않기 위해 사용함.


  RemittanceRateBloc(this.api);

  void dispose() {
    ctrl.close(); // 스트림은 안 쓸 때 닫아줘야합니다.
  }

  void getTodo() {
    api.getCompanyRateList().then((todos) {
      ctrl.add(todos);
    });
  }

}