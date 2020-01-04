import 'dart:async';

import 'package:demo_app/db/item_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PurchaseDatabase {
  static final String _databaseName = 'puchase.db';
  static final int _databaseVersion = 1;

  static final _tableName = 'purchaseTbl';

  static const ID = 'id';
  static const NAME = 'name';
  static const PRICE = 'price';

  static final PurchaseDatabase database = PurchaseDatabase._constructor();

  factory PurchaseDatabase() {
    return database;
  }

  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await _initDb();
    return _db;
  }

  PurchaseDatabase._constructor() {
    print('private const called');
  }

  _initDb() async {
    final database = openDatabase(join(await getDatabasesPath(), _databaseName),
        onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE $_tableName($ID INTEGER PRIMARY KEY AUTOINCREMENT, $NAME TEXT, $PRICE INTEGER)",
      );
    }, version: _databaseVersion);
    return database;
  }

  Future<int> insert(ItemModel model) async {
    Database db = await database.db;
    return db.insert(_tableName, model.toMap());
  }

  Future<List<ItemModel>> queryAllRows() async {
    Database db = await database.db;
    List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(maps.length, (i) {
      return ItemModel(
        id: maps[i][ID],
        name: maps[i][NAME],
        price: maps[i][PRICE],
      );
    });
  }
}
