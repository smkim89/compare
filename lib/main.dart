import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:compare/src/vo/CompanyRate.dart';
import 'src/bloc/CompanyRateBloc.dart';
import 'src/RemittanceDetails.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(title: Text('Compare Remittance')),
      body: ListView(
        children: <Widget>[
          _buildCurrencyAndRemittanceOptionSection(),
          _buildToCurrencySection(),
          _buildTitleSection(),
          _buildDataListSection()
        ],
      ),
    );
  }

  _buildCurrencyAndRemittanceOptionSection() {
    return Container(
//      margin: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          DropdownButton(
              hint: Text('Please choose a Curreny'),
              // Not necessary for Option 1
              value: _selectedCurrency,
              onChanged: (newValue) {
                setState(() {
                  _selectedCurrency = newValue;
                });
              },
              items: _currencyList.map((location) {
                return DropdownMenuItem(
                  child: new Text(location),
                  value: location,
                );
              }).toList()),
          DropdownButton(
              hint: Text('Remittance Options'),
              // Not necessary for Option 1
              value: _selectedRemittanceOption,
              onChanged: (newValue) {
                setState(() {
                  _selectedRemittanceOption = newValue;
                });
              },
              items: _remittanceOptions.map((location) {
                return DropdownMenuItem(
                  child: new Text(location),
                  value: location,
                );
              }).toList()),
        ],
      ),
    );
  }

  _buildToCurrencySection() {
    return Container(
      //margin 설정을 하기위해 컨테이너를 감싸준다.
//      margin: EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          Expanded(child: TextField()),
          new Icon(MdiIcons.equal),
          Expanded(child: TextField()),
        ],
      ),
    );
  }

  _buildTitleSection() {
    return Container(
      //margin 설정을 하기위해 컨테이너를 감싸준다.
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Remittance Company List',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
          Text('order by Exchange Rate',
              style: TextStyle(color: Colors.grey, fontSize: 15)),
        ],
      ),
    );
  }

  _buildDataListSection() {
    return StreamBuilder<CompanyRate>(
        stream: bloc.companyRateStream,
        builder: (context, snapshot) {
          return DataTable(
              columns: <DataColumn>[
                DataColumn(
                    label: Text("Company"),
                    numeric: false,
                    onSort: (i, b) {},
                    tooltip: "company name"),
                DataColumn(
                    label: Text("Rate(KRW)"),
                    numeric: false,
                    onSort: (i, b) {},
                    tooltip: "Exchange Rate"),
                DataColumn(
                    label: Text("Options"),
                    numeric: false,
                    onSort: (i, b) {},
                    tooltip: "Remittance Option")
              ],
              rows: companyRateList
                  .map((companyRate) => DataRow(cells: [
                DataCell(Text(companyRate.companyName), onTap: () {
                  print(companyRate.companyName);
                  bloc.addcompanyRate(companyRate);

                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => RemittanceDetails()));
                }),
                DataCell(Text(companyRate.rate.toString()), onTap: () {
                  print("hello");
                  bloc.addcompanyRate(companyRate);
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => RemittanceDetails()));
                }),
                DataCell(Text(companyRate.remittanceOption), onTap: () {
                  bloc.addcompanyRate(companyRate);
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => RemittanceDetails()));
                }),
              ]))
                  .toList());
        }
    );

  }
}

Widget _buildContainer() {
  return Material(
    color: Colors.blue,
    child: InkWell(
      onTap: () => print("Container pressed"), // handle your onTap here
      child: Container(height: 200, width: 200),
    ),
  );
}

List<String> _currencyList = ['BDT', 'USD', 'KHR', 'PHP']; // Option 1
String _selectedCurrency; // Option 2

String _selectedRemittanceOption; // Option 2
List<String> _remittanceOptions = ['CASH_PICK_UP', 'BANK_TRANSFER']; // Option 2


var companyRateList = <CompanyRate>[
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
