part of 'reader_bloc.dart';

@immutable
sealed class ReaderState extends Equatable {
  const ReaderState();
}

final class ReaderLoading extends ReaderState {
  @override
  List<Object> get props => [];
}

final class ReaderLoaded extends ReaderState {
  const ReaderLoaded(
      {required this.book,
      this.pages = const [],
      required this.pageController,
      this.pageLast = 0});

  final Book book;
  final List<List<String>> pages;
  final PageController pageController;
  final int pageLast;

  ReaderLoaded copyWith(
      {Book? book,
      List<List<String>>? pages,
      PageController? pageController,
      int? pageLast}) {
    return ReaderLoaded(
        book: book ?? this.book,
        pageController: pageController ?? this.pageController,
        pages: pages ?? this.pages,
        pageLast: pageLast ?? this.pageLast);
  }

  @override
  List<Object> get props => [book, pages, pageController, pageLast];
}
