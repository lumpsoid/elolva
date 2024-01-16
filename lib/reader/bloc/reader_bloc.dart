import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:bloc/bloc.dart';
import 'package:test_lwt_port/library/models/models.dart';
import 'package:test_lwt_port/library_repository.dart';

part 'reader_event.dart';
part 'reader_state.dart';

class ReaderBloc extends Bloc<ReaderEvent, ReaderState> {
  ReaderBloc(this.libraryRepository) : super(ReaderLoading()) {
    on<ReaderOpenBook>(_onBookOpen);
    on<ReaderNextPage>(_onNextPage);
  }

  final LibraryRepository libraryRepository;

  Future<void> _onBookOpen(
      ReaderOpenBook event, Emitter<ReaderState> emit) async {
    emit(ReaderLoading());
    Book book = event.book;
    if (book.text.isEmpty) {
      book = await libraryRepository.fetchBookText(event.book);
    }
    int wordsPerList = 50;
    List<String> words = book.text.replaceAll('\n', ' ').split(' ');
    List<List<String>> pages = [];
    for (int i = 0; i < words.length; i += wordsPerList) {
      int end =
          (i + wordsPerList < words.length) ? i + wordsPerList : words.length;
      List<String> sublist = words.sublist(i, end);
      // // Split each sentence into words
      // List<List<String>> wordsList =
      //     sublist.map((sentence) => sentence.split(' ')).toList();
      // // Flatten the list of lists to a list of words
      // List<String> flattenedWords = wordsList.expand((list) => list).toList();
      // // Add the flattened list of words to the pages list
      pages.add(sublist);
    }
    PageController pageController =
        PageController(initialPage: event.book.pageLast);
    emit(ReaderLoaded(
        book: event.book,
        pages: pages,
        pageController: pageController,
        pageLast: event.book.pageLast));
  }

  Future<void> _onNextPage(
      ReaderNextPage event, Emitter<ReaderState> emit) async {
    var state = this.state;
    if (state is ReaderLoaded && state.pageLast < event.pageIndex) {
      emit(state.copyWith(
          pageLast: event.pageIndex,
          pageController: PageController(initialPage: event.pageIndex)));
    }
  }

  // Future<void> getContent() async {
  //   if (book.text.isNotEmpty) {
  //     content = book.text;
  //     return;
  //   }
  //   List<Map<String, dynamic>> data = await _booksDb.getBookText(book.id);
  //   if (data.isEmpty) {
  //     throw StateError('Got empty book data from DB.');
  //   }
  //   content = data[0]['text'];
  //   return;
  // }
}
