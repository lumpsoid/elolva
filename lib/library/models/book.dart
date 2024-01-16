import 'package:equatable/equatable.dart';

/// A class representing a book.
class Book extends Equatable {
  /// The unique identifier for the book.
  ///
  /// If no [id] is provided, it will be autogenerated based on the current
  /// microsecond timestamp.
  final int id;
  final String name;
  final String author;
  final int percent;
  final int pageLast;
  final String dateCreated;
  final String dateCompleted;
  final int dateLast;
  final String path;
  final String text;

  Book(
      {int? id,
      required this.name,
      this.author = '',
      this.percent = 0,
      this.pageLast = 0,
      String? dateCreated,
      this.dateCompleted = '',
      int? dateLast,
      this.path = '',
      this.text = ''})
      : id = id ?? DateTime.now().microsecondsSinceEpoch,
        dateCreated = dateCreated ?? DateTime.now().toIso8601String(),
        dateLast = dateLast ?? DateTime.now().microsecondsSinceEpoch;

  Book.fromDb(Map<String, dynamic> item)
      : id = item['id'],
        name = item['name'],
        author = item['author'],
        percent = item['percent'],
        pageLast = item['page_last'],
        dateCreated = item['date_created'],
        dateCompleted = item['date_completed'],
        dateLast = item['date_last'],
        path = item['path'],
        text = '';

  Book copyWith(
      {int? id,
      String? name,
      String? author,
      int? percent,
      int? pageLast,
      String? dateCreated,
      String? dateCompleted,
      int? dateLast,
      String? path,
      String? text}) {
    return Book(
      id: id ?? this.id,
      name: name ?? this.name,
      percent: percent ?? this.percent,
      pageLast: pageLast ?? this.pageLast,
      author: author ?? this.author,
      dateCompleted: dateCompleted ?? this.dateCompleted,
      dateCreated: dateCreated ?? this.dateCreated,
      dateLast: dateLast ?? this.dateLast,
      path: path ?? this.path,
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toBookMeta() {
    return {
      'id': id,
      'name': name,
      'author': author,
      'percent': percent,
      'page_last': pageLast,
      'date_created': dateCreated,
      'date_completed': dateCompleted,
      'date_last': dateLast,
      'path': path
    };
  }

  Map<String, dynamic> toBookText() {
    return {'id': id, 'text': text};
  }

  @override
  List<Object> get props => [
        id,
        name,
        author,
        percent,
        pageLast,
        dateCreated,
        dateCompleted,
        dateLast,
        path,
        text
      ];
}
