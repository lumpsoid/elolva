import 'package:sqflite/sqflite.dart';
import 'db/books.dart' show BooksDb;

void testDbScheme() async {
  Database db = await BooksDb().db;
  String tableName = 'books_meta';
  List<Map<String, dynamic>> tableInfo = await db.rawQuery('PRAGMA table_info($tableName);');
  print('Table Info for $tableName:');
  tableInfo.forEach((column) {
    print('Column: ${column['name']}, Type: ${column['type']}, Nullable: ${column['notnull'] == 0}, Default Value: ${column['dflt_value']}');
  });

  List<Map<String, dynamic>> tableList = await db.rawQuery('PRAGMA table_list;');
  print('List of Tables:');
  tableList.forEach((table) {
    print('Table: ${table['name']}');
  });

  List<Map<String, dynamic>> foreignKeys = await db.rawQuery('PRAGMA foreign_key_list($tableName);');
  print('Foreign Key List for $tableName:');
  foreignKeys.forEach((key) {
    print('From: ${key['table']}.${key['from']} To: ${key['table']}(${key['to']})');
  });
}