import 'package:flutter_test/flutter_test.dart';
import 'package:test_lwt_port/library/models/book.dart';

void main() {
  test('Book from precreated values', () {
    DateTime now = DateTime.now();
    String nowIso = now.toIso8601String();
    int nowMicroseconds = now.microsecondsSinceEpoch;

    Book book = Book(
      name: 'testName',
      author: 'testAuthor',
      dateCompleted: nowIso,
      dateCreated: nowIso,
      dateLast: nowMicroseconds,
      id: nowMicroseconds,
      path: 'testPath',
      text: 'testText',
      percent: 99,
    );

    expect(book.id, nowMicroseconds);
    expect(book.dateCompleted, nowIso);
    expect(book.dateCreated, nowIso);
    expect(book.dateLast, nowMicroseconds);
    expect(book.name, 'testName');
    expect(book.author, 'testAuthor');
    expect(book.text, 'testText');
    expect(book.path, 'testPath');
    expect(book.percent, 99);
  });
}
