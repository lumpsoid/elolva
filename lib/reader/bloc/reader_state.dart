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
  const ReaderLoaded({required this.book});

  final Book book;

  @override
  List<Object> get props => [];
}
