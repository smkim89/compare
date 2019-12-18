import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:compare/src/vo/CompanyRate.dart';
import 'package:compare/src/vo/Currency.dart';
import 'package:compare/src/bloc/RemittanceRateBloc.dart';
import 'package:compare/src/bloc/RemittanceRateProvider.dart';
import 'package:compare/src/ui/RemittanceDetails.dart';
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
    remittanceRateBloc.getCompanyRate(_selectedCurrency);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(title: Text('TRANSMOA')),
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Image.asset(
                      'images/flag/flag_' +
                          companyRate.country.toLowerCase() +
                          '.png',
                      width: 30,
                      height: 30,
                    ),
                    new Text(companyRate.currency),

//                CachedNetworkImage(
//                    imageUrl: companyRate.currencyImg,
//                    height: 50.0,
//                    width: 50.0,
//                    fit: BoxFit.cover,
//                )
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
                double krw = double.parse(amount) * fromCurrencyRate;
                krw = double.parse(krw.toStringAsFixed(0));
                krwAmount = krw.toInt().toString() + " KRW";
                currencyAmount = int.parse(amount);
              });
            },
          )),
          new Icon(MdiIcons.equal),
          //KRW
          Expanded(
              child: TextField(
            controller: TextEditingController()
              ..text = krwAmount == null ? "" : krwAmount.toString(),
            readOnly: true,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'KRW(원)',
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            ),
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
          ], rows: _createRows(context, snapshot.data));
        });
  }
}

List<DataRow> _createRows(BuildContext context, List<CompanyRate> list) {
  List<DataRow> newList = new List<DataRow>();
  if (list == null || list.length == 0) {
    return newList;
  }

  fromKrwCurrencyRate = list[0].rate;
  fromCurrencyRate = 1 / list[0].rate;

  newList = list
      .map((companyRate) => DataRow(cells: [
            DataCell(
                CachedNetworkImage(
                  imageUrl: companyRate.companyLogo,
                  imageBuilder: (context, imageProvider) => Container(
                    height: 50,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ), onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      RemittanceDetails(companyRate: companyRate),
                ),
              );


            }),
            DataCell(Text(companyRate.rate.toString()), onTap: () {}),
            DataCell(Text(companyRate.remittanceOption), onTap: () {}),
          ]))
      .toList();

  return newList;
}

List<String> _currencyList = ['BDT', 'USD', 'KHR', 'PHP']; // Option 1
String _selectedCurrency = 'USD'; // Option 2

String _selectedRemittanceOption; // Option 2
List<String> _remittanceOptions = ['CASH_PICK_UP', 'BANK_TRANSFER']; // Option 2

double fromKrwCurrencyRate; // Option 2
double fromCurrencyRate; // Option 2
String krwAmount;
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
