import 'package:demo_app/add_income_page.dart';
import 'package:demo_app/db/purchase_database.dart';
import 'package:demo_app/purchase_entry_page.dart';
import 'package:demo_app/purchase_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PurchaseHomePage extends StatefulWidget {
  @override
  _PurchaseHomePageState createState() => _PurchaseHomePageState();
}

class _PurchaseHomePageState extends State<PurchaseHomePage> {
  int totalIncome = 0;
  int totalSpent = 0;
  int remainingIncome = 0;

  @override
  void initState() {
    super.initState();
    getSumOfPurchase();
  }

  void getSumOfPurchase() async{
   int purchaseSum = await  PurchaseDatabase().getSumOfPurchases();
   int income = await PurchaseDatabase().getIncome();

   setState(() {
       totalSpent = purchaseSum;
       remainingIncome = income - purchaseSum;
     });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: getSummaryWidget(context),
    );
  }

  Center getSummaryWidget(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          getCreditWidget(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 8.0,
              ),
              RaisedButton(
                child: Text('Add Purchase History'),
                onPressed: () => addPurchase(context),
              ),
              RaisedButton(
                child: Text('View Purchase History'),
                onPressed: () => gotoPurchaseList(context),
              ),
              RaisedButton(
                child: Text('Add Income'),
                onPressed: () => addIncome(context),
              )
            ],
          ),
        ],
      ),
    );
  }

  void addIncome(BuildContext context) async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddIncome()));
    if (result) {
      getSumOfPurchase();
    }
  }

  void gotoPurchaseList(BuildContext context) async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => PurchaseList()));
    if (result) {
      getSumOfPurchase();
    }
  }

  void addPurchase(BuildContext context) async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => PurchaseEntryPage()));
    if (result) {
      getSumOfPurchase();
    }
  }

  Widget getCreditWidget() {
    return Container(
      decoration:
          BoxDecoration(color: Colors.deepPurple, shape: BoxShape.rectangle),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Text(
              'Total Income',
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              '$totalIncome Rs',
              style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              'Total Spent',
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              '$totalSpent Rs',
              style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              'Remaining Balance',
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              '$remainingIncome Rs',
              style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
