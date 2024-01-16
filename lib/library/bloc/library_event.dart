part of 'library_bloc.dart';

@immutable
sealed class LibraryEvent extends Equatable {
  const LibraryEvent();
}

final class LibraryStarted extends LibraryEvent {
  @override
  List<Object> get props => [];
}

final class LibraryBookFetch extends LibraryEvent {
  const LibraryBookFetch(this.index);

  final int index;
  get startingIndex => (index ~/ itemsPerPage) * itemsPerPage;

  @override
  List<Object> get props => [index];
}

final class LibraryBookAdded extends LibraryEvent {
  const LibraryBookAdded(this.book);

  final Book book;

  @override
  List<Object> get props => [book];
}

final class LibraryBookRemoved extends LibraryEvent {
  const LibraryBookRemoved(this.book);

  final Book book;

  @override
  List<Object> get props => [book];
}

final class LibraryBookUpdated extends LibraryEvent {
  const LibraryBookUpdated(this.book);

  final Book book;

  @override
  List<Object> get props => [book];
}

final class LibraryTextAdded extends LibraryEvent {
  const LibraryTextAdded(this.book, this.text);

  final Book book;
  final String text;

  @override
  List<Object> get props => [book];
}
