import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:my_financial_app/models/TotalIncomeModel.dart';
import 'package:my_financial_app/models/Transaction_type.dart';
import 'package:my_financial_app/models/TransactionModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseInstance {
  final String _databaseName = 'bt66tech_financial_app.db';
  final int _databaseVersion = 1;

  // DatabaseInstance._privateConstructor();
  DatabaseInstance._();
  static final DatabaseInstance db = DatabaseInstance._();
  static Database? _database;

  // final String id = 'id';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    if(kDebugMode) {
      print(_database);
    }
    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory  = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,version: _databaseVersion, onConfigure: _onConfigure, onCreate: _onCreate);
  }
  _onConfigure(Database db) async {
    await db.execute("PRAGMA foreign_keys = ON");
  }
  Future _onCreate(Database db, int version) async {

    // create table type
    await db.execute(
      '''CREATE TABLE transaction_type (
          id INTEGER PRIMARY KEY AUTOINCREMENT, 
          name TEXT NOT NULL
      )'''
    );
    await db.execute(
      '''CREATE TABLE user_transaction (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL, 
          description TEXT, 
          ammount REAL NOT NULL,
          date TEXT NOT NULL,
          transaction_type_id INTEGER NOT NULL,
          FOREIGN KEY (transaction_type_id) REFERENCES transaction_type (id)
      )'''
    );
    await db.rawInsert('INSERT INTO transaction_type (name) VALUES("INCOME")');
    await db.rawInsert('INSERT INTO transaction_type (name) VALUES("OUTCOME")');
  }

  // action for transaction type
  addTransactionType(TransactionType transactionType) async {
    final db = await database;
    if(kDebugMode) {
      print(transactionType.toMap());
    }
    await db.insert(
      "transaction_type", 
      transactionType.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future <List<TransactionType>> getAllTransactionType() async {
    final db = await database;
    var response = await db.query("transaction_type");
    List<TransactionType> list = response.map((e) => TransactionType.fromMap(e)).toList();
    if(kDebugMode) {
      print(list);
    }
    return list;
  }

  addUserTransaction(TransactionModel transactionModel) async {
    final db = await database;
    if(kDebugMode) {
      print(transactionModel.toMap());
    }
    await db.insert(
      "user_transaction", 
      transactionModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future<int> updateUserTransaction(int idParam, Map<String, dynamic> row) async {
    final db = await database;
    var response = await db.update("user_transaction", row, where: 'id=?', whereArgs: [idParam]);
    // List<TransactionModel> list = response.map((e) => TransactionModel.fromMap(e)).toList();
    return response;
    // return list;
  }

  Future<int> deleteUserTransaction(int idParam) async {
    final db = await database;
    var response = await db.delete("user_transaction", where: 'id=?', whereArgs: [idParam]);
    // List<TransactionModel> list = response.map((e) => TransactionModel.fromMap(e)).toList();
    return response;
    // return list;
  }

  Future <List<TransactionModel>> getAllUserTransaction() async {
    final db = await database;
    var response = await db.query("user_transaction");
    List<TransactionModel> list = response.map((e) => TransactionModel.fromMap(e)).toList();
    return list;
  }

  Future <List<TransactionModel>> getTransactionByMonth(String mmYY) async {
    final db = await database;
    var response = await db.rawQuery('SELECT id, name, description, ammount, date, transaction_type_id FROM user_transaction WHERE STRFTIME("%m-%Y", date)="$mmYY"');
    List<TransactionModel> list = response.map((e) => TransactionModel.fromMap(e)).toList();
    return list;
  }

  Future testGetTransactionByMonth(String mmYY) async {
    final db = await database;
    var response = await db.rawQuery('SELECT id, name, description, ammount, date, transaction_type_id FROM user_transaction WHERE STRFTIME("%m-%Y", date)="$mmYY"');
    return response;
  }
  Future <List<TotalIncomeModel>> getIncomeByMonth(mmYY) async{
    final db = await database;
    var response = await db.rawQuery('SELECT SUM(ammount) AS ammount,name FROM user_transaction WHERE transaction_type_id=2 AND STRFTIME("%m-%Y", date)="$mmYY"');
    if(kDebugMode) {
      print(response);
    }
    List<TotalIncomeModel> list = response.map((e) => TotalIncomeModel.fromMap(e)).toList();

    return list;
  }

  Future <List<TotalIncomeModel>> getOutcomeByMonth(mmYY) async{
    final db = await database;
    var response = await db.rawQuery('SELECT SUM(ammount) AS ammount,name FROM user_transaction WHERE transaction_type_id=1 AND STRFTIME("%m-%Y", date)="$mmYY"');
    if(kDebugMode) {
      print(response);
    }
    List<TotalIncomeModel> list = response.map((e) => TotalIncomeModel.fromMap(e)).toList();

    return list;
  }
}