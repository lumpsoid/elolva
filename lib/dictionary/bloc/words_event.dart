part of 'words_bloc.dart';

sealed class DictionaryEvent extends Equatable {
  const DictionaryEvent();
}

final class DictionaryStarted extends DictionaryEvent {
  @override
  List<Object> get props => [];
}

final class DictionaryWordAdd extends DictionaryEvent {
  const DictionaryWordAdd(this.word);

  final Word word;

  @override
  List<Object> get props => [];
}

final class DictionaryWordGet extends DictionaryEvent {
  const DictionaryWordGet(this.original);

  final String original;

  @override
  List<Object> get props => [];
}
