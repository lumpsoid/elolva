import 'helpers.dart' show countDigits;

/// A class representing a book.
class Book {
  /// The unique identifier for the book.
  ///
  /// If no [id] is provided, it will be autogenerated based on the current
  /// microsecond timestamp.
  final int id;
  late String name;
  late String author;
  late int percent;
  late String dateCreated;
  late String dateCompleted;
  late int dateLast;
  late String? text;

  Book({
    int? id,
    required this.name,
    this.author = '',
    required this.percent,
    String? dateCreated,
    this.dateCompleted = '',
    int? dateLast,
    this.text
  }) : id = id ?? DateTime.now().microsecondsSinceEpoch {
    final DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(this.id);
    if (dateCreated == null) {
      this.dateCreated = dateTime.toIso8601String();
    }
    if (dateLast == null) {
      this.dateLast = this.id;
    } else {
      if (countDigits(dateLast) != 16) {
        throw ArgumentError('dateLast must be int and represents microseconds since epoch');
      }
    }
  }

  Future<Map<String, dynamic>> toBookMeta() async {
    return {
      'id': id,
      'name': name,
      'author': author,
      'percent': percent,
      'date_created': dateCreated,
      'date_completed': dateCompleted,
      'date_last': dateLast
    };
  }

  Future<Map<String, dynamic>> toBookText() async {
    return {
      'id': id,
      'text': text
    };
  }
}