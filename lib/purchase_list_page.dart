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

  @override
  Widget build(BuildContext context) {
    getItems();
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase History'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, position) {
              final item = items[position];
              return ListTile(
                title: Text(
                  '${item.id}. Name [ ${item.name} ] Price [ ${item.price} ] ',
                  style: Theme.of(context).textTheme.headline,
                ),
              );
            }),
      ),
    );
  }

  void getItems() async {
    List<ItemModel> list = await PurchaseDatabase().queryAllRows();
    setState(() {
      items = list;
    });
  }
}
