import 'package:flutter/cupertino.dart';

import 'book.dart' show Book;
import 'db/books.dart' show BooksDb;

class PagesManager extends ChangeNotifier {
  static BooksDb _booksDb = BooksDb();
  final Book book;
  late String content;

  PagesManager(this.book);

  Future<void> getContent() async {
    if (book.text.isNotEmpty) {
      content = book.text;
      return;
    }
    List<Map<String, dynamic>> data = await _booksDb.getBookText(book.id);
    if (data.isEmpty) {
      throw StateError('Got empty book data from DB.');
    }
    content = data[0]['text'];
    return;
  }
}
