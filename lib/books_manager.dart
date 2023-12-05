import 'package:flutter/material.dart';
import 'db/books.dart' show BooksDb;
import 'book.dart' show Book;

class BookManager extends ChangeNotifier {
  static BooksDb _booksDb = BooksDb();
  static List<Book> _booksList = [];
  List<Book> get booksList => _booksList;

  BookManager() {
    Future.delayed(Duration.zero, () async {
      await updateBookList();
    });
  }

  Future<List<int>> getIds() async {
    List<Map<String, dynamic>> bookData = await _booksDb.getIds();
    List<int> ids = bookData.map((map) => map['id'] as int).toList();
    return ids;
  }

  Future<void> updateBookList() async {
    List<Map<String, dynamic>> bookData = await _booksDb.getBooks();
    List<Book> books = bookData.map((data) => Book(
      id: data['id'],
      name: data['name'],
      author: data['author'],
      percent: data['percent'],
      dateCreated: data['date_created'],
      dateCompleted: data['date_completed'],
      dateLast: data['date_last'],
    )).toList();
    _booksList = books;
    notifyListeners();
  }

  // Future<void> addId(int id) async {
  //   _booksList.add(id);
  //   notifyListeners();
  // }

  Future<List<Book>> getBooks() async {
    List<Map<String, dynamic>> bookData = await _booksDb.getBooks();
    return bookData.map((data) => Book(
      id: data['id'],
      name: data['name'],
      author: data['author'],
      percent: data['percent'],
      dateCreated: data['date_created'],
      dateCompleted: data['date_completed'],
      dateLast: data['date_last'],
      path: data['path'],
    )).toList();
  }

  Future<Book> createBook(
      String bookName,
      String bookAuthor,
      String pathBook) async {
    Book book = Book(name: bookName, author: bookAuthor, percent: 0);
    // TODO add book text to form
    await _booksDb.insertBookMeta(await book.toBookMeta());
    _booksList.add(book);
    notifyListeners();
    return book;
  }

  Future<Book> getBookInfo(int id) async {
    List<Map<String, dynamic>> bookData = await _booksDb.getBookMeta(id);
    if (bookData.isNotEmpty) {
      Map<String, dynamic> bookInfo = bookData[0];
      Book book = Book(
        id: bookInfo['id'],
        name: bookInfo['name'],
        author: bookInfo['author'],
        percent: bookInfo['percent'],
        dateCreated: bookInfo['date_created'],
        dateCompleted: bookInfo['date_completed'],
        dateLast: bookInfo['date_last'],
        path: bookInfo['path'],
      );
      return book;
    } else {
      throw ArgumentError("Book's id don't exist. Response from db is empty.");
    }
  }

  void renderBookCard(Book book) {
    // Код для отображения карточки книги
  }
}
