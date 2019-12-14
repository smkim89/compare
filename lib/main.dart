import 'package:flutter/material.dart';
import 'src/ui/RemittanceCompare.dart';
import 'src/bloc/RemittanceRateBloc.dart';
import 'src/bloc/RemittanceRateProvider.dart';
import 'package:compare/src/repository/API.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RemittanceRateProvider(
      remittanceRateBloc: RemittanceRateBloc(API()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: HomeScreen()
      ),
    );
  }
}
