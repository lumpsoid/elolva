import 'package:equatable/equatable.dart';
import 'package:test_lwt_port/library/library.dart';

class Library extends Equatable {
  const Library({required this.books});

  final List<Book> books;

  @override
  get props => [books];
}
