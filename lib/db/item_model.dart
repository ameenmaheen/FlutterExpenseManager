import 'package:demo_app/db/purchase_database.dart';

class ItemModel {
  final int id;
  final String name;
  final int price;

  ItemModel({this.id, this.name, this.price});

  Map<String, dynamic> toMap() {
    return {
      PurchaseDatabase.ID: id,
      PurchaseDatabase.NAME: name,
      PurchaseDatabase.PRICE: price
    };
  }
}
