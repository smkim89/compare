import 'package:flutter/material.dart';
import 'RemittanceRateBloc.dart';
import '../repository/API.dart';

class RemittanceRateProvider extends InheritedWidget { // 자식 위젯에서 접근하기 위함
  final RemittanceRateBloc remittanceRateBloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static RemittanceRateBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(RemittanceRateProvider) as RemittanceRateProvider).remittanceRateBloc; // static으로 해서 1번만 초기화하도록 함.

  RemittanceRateProvider({Key key , RemittanceRateBloc remittanceRateBloc, Widget child })
      : this.remittanceRateBloc = remittanceRateBloc ?? RemittanceRateBloc(API()),
        super(child: child, key: key);
}