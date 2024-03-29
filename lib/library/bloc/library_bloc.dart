import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_lwt_port/library/library.dart';
import 'package:test_lwt_port/library_repository.dart';
import 'package:test_lwt_port/config.dart';
import 'package:meta/meta.dart';

part 'library_state.dart';
part 'library_event.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  LibraryBloc(this.libraryRepository) : super(LibraryLoading()) {
    on<LibraryStarted>(_onStarted);
    on<LibraryBookAdded>(_onBookAdded);
    on<LibraryBookRemoved>(_onBookRemoved);
    on<LibraryBookFetch>(_onFetchBooks);
    // on<LibraryTextAdded>(_onTextAdded);
  }

  final LibraryRepository libraryRepository;

  Future<void> _onStarted(
      LibraryStarted event, Emitter<LibraryState> emit) async {
    final List<Book> books = await libraryRepository.fetchBooks(0);
    try {
      emit(LibraryLoaded(library: books));
    } catch (_) {
      emit(LibraryError());
    }
  }

  Future<void> _onFetchBooks(
      LibraryBookFetch event, Emitter<LibraryState> emit) async {
    final state = this.state;
    final List<Book> books =
        await libraryRepository.fetchBooks(event.startingIndex);
    if (state is LibraryLoading) {
      try {
        emit(LibraryLoaded(library: books));
      } catch (_) {
        emit(LibraryError());
      }
    } else if (state is LibraryLoaded) {
      if (state.hasReachedMax) return;
      try {
        books.isEmpty
            ? emit(LibraryLoaded(library: [...state.library]))
            : emit(LibraryLoaded(library: [...state.library, ...books]));
      } catch (_) {
        emit(LibraryError());
      }
    }
  }

  Future<void> _onBookAdded(
      LibraryBookAdded event, Emitter<LibraryState> emit) async {
    final state = this.state;
    if (state is LibraryLoaded) {
      try {
        File file = File(event.book.path);
        String fileContent = await file.readAsString();

        Book book = event.book.copyWith(text: fileContent);

        if (state.hasReachedMax) {
          emit(LibraryLoaded(library: [...state.library, event.book]));
        }
        libraryRepository.insertBookMeta(book);
        libraryRepository.insertBookText(book);
      } catch (_) {
        emit(LibraryError());
      }
    }
  }

  Future<void> _onBookRemoved(
      LibraryBookRemoved event, Emitter<LibraryState> emit) async {
    final state = this.state;
    if (state is LibraryLoaded) {
      try {
        libraryRepository.deleteBook(event.book.id);
        emit(LibraryLoaded(library: [...state.library]..remove(event.book)));
      } catch (_) {
        emit(LibraryError());
      }
    }
  }

  // Future<void> _onTextAdded(
  //     LibraryTextAdded event, Emitter<LibraryState> emit) async {
  //   var state = this.state;
  //   if (state is LibraryLoaded) {
  //     List<Book> libraryUpdated = [...state.library];
  //     emit(LibraryLoaded(library: [...state.library]));
  //   }
  // }
}
