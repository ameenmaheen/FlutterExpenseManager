import 'package:demo_app/db/purchase_database.dart';
import 'package:flutter/material.dart';

class AddIncome extends StatefulWidget {
  @override
  _AddIncomeState createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
  var _incomeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: <Widget>[
              getNameWidget(),
              SizedBox(
                height: 8.0,
              ),
              getSubmitButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget getNameWidget() {
    return TextFormField(
      decoration: InputDecoration(hintText: 'Enter Income'),
      controller: _incomeController,
    );
  }

  Widget getSubmitButton() {
    return RaisedButton(
      child: Text('Add Income'),
      onPressed: () => addIncome(),
    );
  }

  addIncome() {
    FocusScope.of(context).requestFocus(FocusNode());
    int income = int.tryParse(_incomeController.text);
    PurchaseDatabase().insertIncome(income).then((result)  {
      print('Income added [$result]');
    });
  }
}
