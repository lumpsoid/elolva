import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:test_lwt_port/config.dart';
import 'package:test_lwt_port/dictionary/dictionary.dart';
import 'package:test_lwt_port/library/library.dart';

class LibraryRepository {
  static final LibraryRepository _instance = LibraryRepository.internal();

  factory LibraryRepository() => _instance;

  static late Database _db;
  static bool isConnected = false;

  Future<Database> get db async {
    if (isConnected) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  LibraryRepository.internal();

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
    /// books-meta
    /// id name author percent date-created date-completed date-last
    /// books-text
    /// id text

    // Create books_meta table
    await db.execute('''
      CREATE TABLE books_meta (
        id INTEGER PRIMARY KEY,
        name TEXT,
        author TEXT,
        percent INTEGER,
        page_last INTEGER,
        date_created TEXT,
        date_completed TEXT,
        date_last INTEGER,
        path TEXT
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

    // Create words table
    await db.execute('''
      CREATE TABLE words (
        original TEXT PRIMARY KEY,
        translation TEXT,
        pronunciation TEXT,
        state TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE words_examples (
        original TEXT PRIMARY KEY,
        example TEXT,
        FOREIGN KEY (original) REFERENCES words(original)
      )
    ''');
  }

  // CRUD operations
  Future<int> insertBookMeta(Book book) async {
    Database dbClient = await db;
    return await dbClient.insert('books_meta', book.toBookMeta());
  }

  Future<int> insertBookText(Book book) async {
    Database dbClient = await db;
    return await dbClient.insert('books_text', book.toBookText());
  }

  /// Get list of book objects that are in the DB
  Future<List<Book>> fetchBooks(int startingIndex) async {
    Database dbClient = await db;
    List<Map<String, dynamic>> result = await dbClient.rawQuery(
      'SELECT * FROM books_meta ORDER BY id LIMIT $itemsPerPage OFFSET $startingIndex',
    );
    if (result.isEmpty) return [];
    return result.map<Book>((item) => Book.fromDb(item)).toList();
  }

  /// Get list of book objects that are in the DB
  Future<List<Book>> fetchBooksAll() async {
    Database dbClient = await db;
    List<Map<String, dynamic>> result = await dbClient.query('books_meta');
    return List.generate(result.length, (index) => Book.fromDb(result[index]));
  }

  Future<Book> fetchBookMeta(int id) async {
    Database dbClient = await db;
    List<Map<String, dynamic>> result =
        await dbClient.query('books_meta', where: 'id = ?', whereArgs: [id]);
    if (result.isEmpty) {
      throw StateError('There is not such ID in DB');
    }
    Map<String, dynamic> bookData = result[0];
    return Book.fromDb(bookData);
  }

  Future<Book> fetchBookText(Book book) async {
    Database dbClient = await db;
    List<Map<String, dynamic>> result = await dbClient
        .query('books_text', where: 'id = ?', whereArgs: [book.id]);
    if (result.isEmpty) {
      throw StateError('There is not such ID in DB');
    }
    Map<String, dynamic> bookData = result[0];
    return book.copyWith(text: bookData['text']);
  }

  Future<List<int>> fetchIds() async {
    Database dbClient = await db;
    List<Map<String, dynamic>> data =
        await dbClient.query('books_meta', columns: ['id']);
    return data.map<int>((item) => item['id']).toList();
  }

  Future<int> updateBook(Book book) async {
    Database dbClient = await db;
    return await dbClient.update('books_meta', book.toBookMeta(),
        where: 'id = ?', whereArgs: [book.id]);
  }

  Future<int> deleteBook(int id) async {
    Database dbClient = await db;
    await dbClient.delete('books_text', where: 'id = ?', whereArgs: [id]);
    return await dbClient
        .delete('books_meta', where: 'id = ?', whereArgs: [id]);
  }

  Future<(List<String>, Map<String, Word>)> fetchWordsAll() async {
    Database dbClient = await db;
    List<Map<String, dynamic>> result = await dbClient.query('words');
    List<String> listWords = [];
    Map<String, Word> dictionary = {};
    for (Map<String, dynamic> map in result) {
      Word word = Word.fromDb(map);
      listWords.add(word.original);
      dictionary.addAll({word.original: word});
    }
    return (listWords, dictionary);
  }

  Future<void> close() async {
    Database dbClient = await db;
    try {
      await dbClient.close();
      isConnected = false;
    } catch (e) {
      print(e);
    }
  }
}
