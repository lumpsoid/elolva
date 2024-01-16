part of 'reader_bloc.dart';

@immutable
sealed class ReaderEvent extends Equatable {
  const ReaderEvent();
}

final class ReaderStarted extends ReaderEvent {
  @override
  List<Object> get props => [];
}

final class ReaderOpenBook extends ReaderEvent {
  const ReaderOpenBook({required this.book});

  final Book book;

  @override
  List<Object> get props => [book];
}

final class ReaderNextPage extends ReaderEvent {
  const ReaderNextPage(this.pageIndex);

  final int pageIndex;

  @override
  List<Object> get props => [pageIndex];
}
