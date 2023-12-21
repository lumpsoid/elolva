part of 'library_bloc.dart';

@immutable
sealed class LibraryState extends Equatable {
  const LibraryState();
}

final class LibraryLoading extends LibraryState {
  @override
  List<Object> get props => [];
}

final class LibraryLoaded extends LibraryState {
  const LibraryLoaded({required this.library});

  final Library library;
  bool get hasReachedMax {
    if (library.books.isEmpty || library.books.length < itemsPerPage) {
      return true;
    }
    return false;
  }

  LibraryLoaded copyWith({Library? library, bool? hasReachedMax}) {
    return LibraryLoaded(library: library ?? this.library);
  }

  @override
  List<Object> get props => [library];
}

final class LibraryError extends LibraryState {
  @override
  List<Object> get props => [];
}
