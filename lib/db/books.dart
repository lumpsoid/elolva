import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BooksDb {
  static final BooksDb _instance = BooksDb.internal();

  factory BooksDb() => _instance;

  static late Database _db;
  static bool isConnected = false;

  Future<Database> get db async {
    if (isConnected) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  BooksDb.internal();

  Future<Database> initDb() async {
    try {
      String databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'lwt.db');
      Database db = await openDatabase(path, version: 1, onCreate: _onCreate);
      isConnected = true;
      return db;
    } catch (e) {
      print("Error initializing database: $e");
      rethrow; // Rethrow the error to see the stack trace
    }
  }

  void _onCreate(Database db, int version) async {
    // books-meta
    //// id name author percent date-created date-completed date-last
    // books-text
    //// id text

    // Create books_meta table
    await db.execute('''
      CREATE TABLE books_meta (
        id INTEGER PRIMARY KEY,
        name TEXT,
        author TEXT,
        percent INTEGER,
        date_created TEXT,
        date_completed TEXT,
        date_last INTEGER
      )
    ''');

    // Create books_text table
    await db.execute('''
      CREATE TABLE books_text (
        id INTEGER PRIMARY KEY,
        text TEXT,
        FOREIGN KEY (id) REFERENCES books_meta(id)
      )
    ''');
  }

  // CRUD operations
  Future<int> insertBookMeta(Map<String, dynamic> book) async {
    Database dbClient = await db;
    return await dbClient.insert('books_meta', book);
  }

  Future<int> insertBookText(Map<String, dynamic> book) async {
    Database dbClient = await db;
    return await dbClient.insert('books_text', book);
  }

  Future<List<Map<String, dynamic>>> getBooks() async {
    Database dbClient = await db;
    return await dbClient.query('books_meta');
  }

  Future<List<Map<String, dynamic>>> getBookMeta(int id) async {
    Database dbClient = await db;
    return await dbClient.query('books_meta', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getIds() async {
    Database dbClient = await db;
    List<Map<String, dynamic>> data = await dbClient.query('books_meta', columns: ['id']);
    return data;
  }

  Future<int> updateBook(Map<String, dynamic> book) async {
    Database dbClient = await db;
    return await dbClient.update('books_meta', book,
        where: 'id = ?', whereArgs: [book['id']]);
  }

  Future<int> deleteBook(int id) async {
    Database dbClient = await db;
    await dbClient.delete('books_text', where: 'id = ?', whereArgs: [id]);
    return await dbClient.delete('books_meta', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> close() async {
    Database dbClient = await db;
    try {
      await dbClient.close();
      isConnected = false;
    } catch(e) {
      print(e);
    }
  }
}
