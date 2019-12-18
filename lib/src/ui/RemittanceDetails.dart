import 'package:flutter/material.dart';
import '../vo/CompanyRate.dart';
import 'package:cached_network_image/cached_network_image.dart';


class RemittanceDetails extends StatefulWidget {
  // Todo를 들고 있을 필드를 선언합니다.

  final CompanyRate companyRate;

  // 생성자는 Todo를 인자로 받습니다.
  RemittanceDetails({Key key, @required this.companyRate}) : super(key: key);

  @override
  _RemittanceDetailsState createState() => _RemittanceDetailsState(companyRate: this.companyRate);
}

class _RemittanceDetailsState extends State<RemittanceDetails> {
  CompanyRate companyRate;

  _RemittanceDetailsState({this.companyRate});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
            color: Colors.black
        ),
        backgroundColor: Colors.white,
        title: CachedNetworkImage(
          imageUrl: companyRate.companyLogo,
          imageBuilder: (context, imageProvider) => Container(
            height: 50,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
      body: Text(companyRate.companyLogo)
    );
  }




}
