import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sqflite/sqflite.dart';

late Future<Database> db;

Future<void> dbInit() async {
  String path;

  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
    path = 'app.db';
  } else {
    path = join(await getDatabasesPath(), 'app.db');
  }

  db = openDatabase(
    path,
    version: 1,
    onCreate: (database, version) {
      return database.transaction((txn) async {
        await txn.execute(
            'CREATE TABLE Events (id INTEGER PRIMARY KEY, date TEXT UNIQUE, severity int, metadata TEXT)');
      });
    },
  );
}
