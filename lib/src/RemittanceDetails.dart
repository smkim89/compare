
import 'package:flutter/material.dart';
import 'bloc/CompanyRateBloc.dart';
import 'vo/CompanyRate.dart';

class RemittanceDetails extends StatefulWidget {



  @override
  _SavedListState createState() => _SavedListState();
}

class _SavedListState extends State<RemittanceDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved"),

      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    // Devider도 인덱스에 포함된다.
    return StreamBuilder<CompanyRate>(
        stream: bloc.companyRateStream,
        builder: (context, snapshot) {
          return Text(snapshot.data.companyName);
        }
    );
  }

}

