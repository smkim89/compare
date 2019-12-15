import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:compare/src/vo/CompanyRate.dart';
import 'package:compare/src/vo/Currency.dart';
import 'package:compare/src/vo/RemittanceOption.dart';
import 'package:compare/src/bloc/RemittanceRateBloc.dart';
import 'package:compare/src/bloc/RemittanceRateProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final remittanceRateBloc = RemittanceRateProvider.of(context);


    remittanceRateBloc.getCurrency();

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(title: Text('Compare Remittance')),
      body: ListView(
        children: <Widget>[
          _buildCurrencyAndRemittanceOptionSection(remittanceRateBloc),
          _buildToCurrencySection(),
          _buildTitleSection(),
          _buildDataListSection(remittanceRateBloc)
        ],
      ),
    );
  }

  _buildCurrencyAndRemittanceOptionSection(
      RemittanceRateBloc remittanceRateBloc) {
    return StreamBuilder(
        stream: remittanceRateBloc.currencyStreamResults,
        builder: (context, snapshot) {
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
                      remittanceRateBloc.getCompanyRate(newValue);
                      setState(() {
                        _selectedCurrency = newValue;
                      });
                    },
                    items: _bulidCurrencyDropButtonWidjet(snapshot.data)),
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
        });
  }

  _bulidCurrencyDropButtonWidjet(List<Currency> list) {
    List<DropdownMenuItem> newList = new List<DropdownMenuItem>();
    if (list == null || list.length == 0) {
      return newList;
    }

    newList = list
        .map((companyRate) => DropdownMenuItem(
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Text(companyRate.currency),
                    CachedNetworkImage(
                      imageUrl: companyRate.currencyImg,
                    )
                  ]),
              value: companyRate.currency,
            ))
        .toList();

    return newList;
  }

  _buildToCurrencySection() {
    return Container(
      //margin 설정을 하기위해 컨테이너를 감싸준다.
//      margin: EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          // currency Field
          Expanded(
              child: TextField(
                controller: _textController,
                autofocus: true,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter Amount',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                ),
                onChanged: (amount) {
                  setState(() {
                    krwAmount = double.parse(amount) * fromCurrencyRate;
                    krwAmount = double.parse(krwAmount.toStringAsFixed(2));
                    currencyAmount = int.parse(amount);
                  });

                },
              )),
          new Icon(MdiIcons.equal),
          //KRW
          Expanded(
              child: TextField(
                controller: TextEditingController()..text = krwAmount==null? "":krwAmount.toString(),
                readOnly: true,
                keyboardType: TextInputType.number,

              ))
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

  _buildDataListSection(RemittanceRateBloc remittanceRateBloc) {
    return StreamBuilder(
        stream: remittanceRateBloc.results,
        builder: (context, snapshot) {
          return DataTable(columns: <DataColumn>[
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
          ], rows: _createRows(snapshot.data));
        });
  }
}

List<DataRow> _createRows(List<CompanyRate> list) {
  List<DataRow> newList = new List<DataRow>();
  if (list == null || list.length == 0) {
    return newList;
  }

  fromKrwCurrencyRate = list[0].rate;
  fromCurrencyRate = 1 / list[0].rate;

  newList = list
      .map((companyRate) => DataRow(cells: [
            DataCell(Text(companyRate.companyName), onTap: () {}),
            DataCell(Text(companyRate.rate.toString()), onTap: () {}),
            DataCell(Text(companyRate.remittanceOption), onTap: () {}),
          ]))
      .toList();

  return newList;
}

List<String> _currencyList = ['BDT', 'USD', 'KHR', 'PHP']; // Option 1
String _selectedCurrency; // Option 2

String _selectedRemittanceOption; // Option 2
List<String> _remittanceOptions = ['CASH_PICK_UP', 'BANK_TRANSFER']; // Option 2

double fromKrwCurrencyRate; // Option 2
double fromCurrencyRate; // Option 2
double krwAmount;
int currencyAmount;

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

final TextEditingController _textController = new TextEditingController();