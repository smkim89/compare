import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:compare/src/vo/CompanyRate.dart';
import 'package:compare/src/vo/Currency.dart';
import 'package:compare/src/bloc/RemittanceRateBloc.dart';
import 'package:compare/src/bloc/RemittanceRateProvider.dart';
import 'package:compare/src/ui/RemittanceDetails.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:compare/src/repository/API.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final remittanceRateBloc = RemittanceRateProvider.of(context);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
          title: Text('TRANSMOA',
              style: TextStyle(
                fontSize: 40,
                color: Colors.grey[400],
              )),
          backgroundColor: Colors.white),
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
        if (snapshot.hasError) print(snapshot.error);
        return snapshot.hasData
            ? Container(
                color: Colors.grey,
                child: DropdownButton<Currency>(
                    isExpanded: true,
                    hint: Text('Please choose a Curreny'),
                    // Not necessary for Option 1
                    value: isLoad == false ? snapshot.data[0] : _selectedCurrency,
                    onChanged: (Currency newValue) {
                      isLoad = true;
                      remittanceRateBloc.getCompanyRate(
                          newValue.currency, newValue.country);
                      setState(() {
                        _selectedCurrency = newValue;
                      });
                    },
                    items: snapshot.data
                        .map<DropdownMenuItem<Currency>>((currencyVo) =>
                            DropdownMenuItem<Currency>(
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,

                                    children: <Widget>[
                                      Image.asset(
                                        'images/flag/flag_' +
                                            currencyVo.country.toLowerCase() +
                                            '.png',
                                        width: 40,
                                        height: 40,
                                      ),
                                      Spacer(flex: 30),
                                      new Text(currencyVo.countryName),
                                      Spacer(flex: 30),
                                      new Text(currencyVo.currency),
                                    ]),
                                value: currencyVo))
                        .toList()),
              )
            : Center(child: CircularProgressIndicator());
      },
    );
  }


  _buildToCurrencySection() {
    return Container(
      color: Colors.grey,
      //margin 설정을 하기위해 컨테이너를 감싸준다.
//      margin: EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // currency Field
          Expanded(
              child: TextField(
            controller: _textController,
            autofocus: true,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0), borderSide: BorderSide(color: Colors.white)),
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
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0), borderSide: BorderSide(color: Colors.white)),
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
          return snapshot.hasData
              ? DataTable(columns: <DataColumn>[
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
                ], rows: _createRows(context, snapshot.data))
              : Container();
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

bool isLoad = false;

Currency _selectedCurrency =
    Currency(country: "KH", countryName: "Cambodia", currency: "KHR");

double fromKrwCurrencyRate; // Option 2
double fromCurrencyRate; // Option 2
String krwAmount;
int currencyAmount;

final TextEditingController _textController = new TextEditingController();
