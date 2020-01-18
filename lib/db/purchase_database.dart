import 'dart:async';

import 'package:demo_app/db/item_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PurchaseDatabase {
  static final String _databaseName = 'puchase.db';
  static final int _databaseVersion = 1;

  static const _expenseTable = 'purchaseTbl';
  static const _incomeTable = 'incomeTbl';

  static const ID = 'id';
  static const NAME = 'name';
  static const PRICE = 'price';
  static const PURCHASE_DATE = 'purchaseDate';
  static const BALANCE_INCOME = 'balanceIncome';

  static const INCOME = 'income';
  static const INCOME_DATE = 'incomeDate';

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
      db.execute(
        "CREATE TABLE $_incomeTable($ID INTEGER PRIMARY KEY AUTOINCREMENT, $INCOME_DATE TEXT, $INCOME INTEGER)",
      );
      db.execute(
        "CREATE TABLE $_expenseTable($ID INTEGER PRIMARY KEY AUTOINCREMENT, $NAME TEXT, $PRICE INTEGER)",
      );
    }, version: _databaseVersion);
    return database;
  }

  Future<int> insertPurchase(ItemModel model) async {
    Database db = await database.db;
    return db.insert(_expenseTable, model.toMap());
  }

  Future<int> insertIncome(int income) async {
    Database db = await database.db;
    return db.insert(_incomeTable, {INCOME: income});
  }

  Future<List<ItemModel>> queryAllRows() async {
    Database db = await database.db;
    List<Map<String, dynamic>> maps = await db.query(_expenseTable);
    return List.generate(maps.length, (i) {
      return ItemModel(
        id: maps[i][ID],
        name: maps[i][NAME],
        price: maps[i][PRICE],
      );
    });
  }

  Future<int> deletePurchase(int id) async {
    final db = await database.db;
    return await db.delete(
      _expenseTable,
      where: "$ID = ?",
      whereArgs: [id],
    );
  }

  Future<int> getSumOfPurchases() async {
    final db = await database.db;
    List<Map<String, dynamic>> maps = await db
        .rawQuery('SELECT SUM($PRICE)  as $BALANCE_INCOME FROM $_expenseTable');
    int sum = maps.first[BALANCE_INCOME];
    return sum;
  }

  Future<int> getIncome() async {
    final db = await database.db;
    List<Map<String, dynamic>> maps = await db
        .rawQuery('SELECT $INCOME FROM $_incomeTable');
    int sum = maps.first[INCOME];
    return sum;
  }
}
