import 'package:demo_app/purchase_entry_page.dart';
import 'package:demo_app/purchase_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PurchaseHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('Add Purchase History'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PurchaseEntryPage()));
              },
            ),
            RaisedButton(
              child: Text('View Purchase History'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PurchaseList()));
              },
            )
          ],
        ),
      ),
    );
  }
}
