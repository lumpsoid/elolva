part of 'reader_bloc.dart';

@immutable
sealed class ReaderEvent extends Equatable {
  const ReaderEvent();
}

final class ReaderStarted extends ReaderEvent {
  @override
  List<Object> get props => [];
}
