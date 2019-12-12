
import 'dart:async';
import 'package:compare/src/vo/CompanyRate.dart';

class Bloc{
  CompanyRate companyRate = CompanyRate();

  //스냅샷을 동시에 뿌려주기위해서 broadcast로 한다.
  final _savedController = StreamController<CompanyRate>.broadcast();

  get companyRateStream => _savedController.stream;


  addcompanyRate(CompanyRate companyRate ){
    _savedController.sink.add(companyRate);
  }

  //Stream을 사용하면 close해줘야한다.
  dispose(){
    _savedController.close();
  }
}

var bloc = Bloc();