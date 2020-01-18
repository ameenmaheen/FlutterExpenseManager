import 'package:demo_app/db/item_model.dart';
import 'package:demo_app/db/purchase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PurchaseList extends StatefulWidget {
  @override
  _PurchaseListState createState() => _PurchaseListState();
}

class _PurchaseListState extends State<PurchaseList> {
  List<ItemModel> items = List();
  String availableIncome;

  @override
  void initState() {
    super.initState();
    getItems();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Purchase History'),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: ListView.separated(
              separatorBuilder: (context, index) =>
                  Divider(color: Colors.black),
              itemCount: items.length,
              itemBuilder: (context, position) {
                final item = items[position];
                return Dismissible(
                  key: Key("${item.id}"),
                  background: Container(color: Colors.deepOrangeAccent),
                  onDismissed: (direction) {
                    deleteItem(item);
                  },
                  child: ListTile(
                    title: Text('${item.name}'),
                    subtitle: Text('Price [ ${item.price} ] '),
                  ),
                );
              }),
        ),
      ),
    );
  }

  void getItems() async {
    List<ItemModel> list = await PurchaseDatabase().queryAllRows();
    setState(() {
      items = list;
    });
  }

  void deleteItem(ItemModel item) {
    PurchaseDatabase().deletePurchase(item.id).then((value) {
      print('Result = $value');
      if (value == 1) {
        setState(() {
          items.remove(item);
        });
      }
    });
  }

  Future<bool> onBackPressed() async {
    Navigator.pop(context, true);
    return false;
  }
}
