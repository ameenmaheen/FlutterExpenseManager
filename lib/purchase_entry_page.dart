import 'package:demo_app/constants/string_constants.dart';
import 'package:demo_app/db/item_model.dart';
import 'package:demo_app/db/purchase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PurchaseEntryPage extends StatefulWidget {
  @override
  _PurchaseEntryPageState createState() => _PurchaseEntryPageState();
}

class _PurchaseEntryPageState extends State<PurchaseEntryPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Purchase Details'),
      ),
      body: Builder(
        builder:(bContext) => Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              getNameWidget(),
              SizedBox(
                height: 8.0,
              ),
              getPriceWidget(),
              SizedBox(
                height: 8.0,
              ),
              getSubmitButton(bContext)
            ],
          ),
        ),
      ),
    );
  }

  Widget getNameWidget() {
    return TextFormField(
      decoration:
          InputDecoration(hintText: StringConstants.ENTER_PURCHASE_ITEM),
      controller: _nameController,
    );
  }

  Widget getPriceWidget() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration:
          InputDecoration(hintText: StringConstants.ENTER_PURCHASE_PRICE,
          ),
      controller: _priceController,
    );
  }

  Widget getSubmitButton(BuildContext context) {
    return new RaisedButton(
      onPressed: () {
        FocusScope.of(context).requestFocus(FocusNode());
        submitPriceData();
        final snackBar = SnackBar(content: Text('Item added succesfully'));
        Scaffold.of(context).showSnackBar(snackBar);
      },
      child: Text('Submit'),
    );
  }

  void submitPriceData() {
    String name = _nameController.text;
    int price = int.tryParse(_priceController.text);
    ItemModel model = ItemModel(name: name,price: price);
    PurchaseDatabase().insert(model);
    _nameController.clear();
    _priceController.clear();
  }
}
