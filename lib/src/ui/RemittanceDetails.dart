import 'package:flutter/material.dart';
import '../vo/CompanyRate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class RemittanceDetails extends StatefulWidget {
  // Todo를 들고 있을 필드를 선언합니다.

  final CompanyRate companyRate;

  // 생성자는 Todo를 인자로 받습니다.
  RemittanceDetails({Key key, @required this.companyRate}) : super(key: key);

  @override
  _RemittanceDetailsState createState() =>
      _RemittanceDetailsState(companyRate: this.companyRate);
}

class _RemittanceDetailsState extends State<RemittanceDetails> {
  CompanyRate companyRate;

  _RemittanceDetailsState({this.companyRate});

  BuildContext ctx;

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Scaffold(
        appBar: AppBar(
            title: Text('TRANSMOA',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.grey[400],
                )),
            backgroundColor: Colors.white),
//        appBar: AppBar(
//          leading: BackButton(color: Colors.black),
//          backgroundColor: Colors.white,
//          title: CachedNetworkImage(
//            imageUrl: companyRate.companyLogo,
//            imageBuilder: (context, imageProvider) => Container(
//              height: 50,
//              width: 120,
//              decoration: BoxDecoration(
//                borderRadius: BorderRadius.all(Radius.circular(50)),
//                image: DecorationImage(
//                  image: imageProvider,
//                  fit: BoxFit.cover,
//                ),
//              ),
//            ),
//          ),
//        ),
        body: ListView(children: <Widget>[
          _buildToCurrencySection(),
          _buildInfoSection(),
          _buildButtonSection()
        ]));
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
                double krw = double.parse(amount) * companyRate.rate;
                krw = double.parse(krw.toStringAsFixed(0));
                krwAmount = krw.toInt().toString() + " KRW";
                currencyAmount = amount;
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

  _buildInfoSection() {
    return Container(
        margin: EdgeInsets.all(16),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
                Widget>[
          Row(children: <Widget>[
            Text('Country', style: TextStyle(color: Colors.grey, fontSize: 15)),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.redAccent,
              size: 24.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
            Text(companyRate.countryName.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          ]),
          Divider(
            color: Colors.black,
            height: 36,
          ),
          Row(children: <Widget>[
            Text('Currency',
                style: TextStyle(color: Colors.grey, fontSize: 15)),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.redAccent,
              size: 24.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
            Text(companyRate.currency.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          ]),
          Divider(
            color: Colors.black,
            height: 36,
          ),
          Row(children: <Widget>[
            Text('Rate', style: TextStyle(color: Colors.grey, fontSize: 15)),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.redAccent,
              size: 24.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
            Text(companyRate.remittanceOption.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          ]),
          Divider(
            color: Colors.black,
            height: 36,
          ),
          Row(children: <Widget>[
            Text('Rate', style: TextStyle(color: Colors.grey, fontSize: 15)),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.redAccent,
              size: 24.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
            Text(companyRate.rate.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          ]),
          Divider(
            color: Colors.black,
            height: 36,
          ),
          Row(children: <Widget>[
            Text('Service Fee',
                style: TextStyle(color: Colors.grey, fontSize: 15)),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.redAccent,
              size: 24.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
            Text(companyRate.fee.toString() + " KRW",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          ]),
          Divider(
            color: Colors.black,
            height: 36,
          )
        ]));
  }

  _buildAdSection() {}

  _buildButtonSection() {
    return Center(
        child: FlatButton.icon(
      color: Colors.white,
      icon: Icon(Icons.autorenew), //`Icon` to display
      label: Text('Go to Remittance'), //`Text` to display
      onPressed: () {
        //Code to execute when Floating Action Button is clicked
        //...
      },
    ));
  }

  void showMessage(String msg) {
    final snackbar = SnackBar(content: Text(msg));

    Scaffold.of(ctx)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackbar);
  }
}

final TextEditingController _textController = new TextEditingController();
double fromKrwCurrencyRate; // Option 2
double fromCurrencyRate; // Option 2
String krwAmount;
String currencyAmount;
