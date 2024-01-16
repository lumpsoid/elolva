part of 'words_bloc.dart';

sealed class DictionaryState extends Equatable {
  const DictionaryState();
}

final class DictionaryLoading extends DictionaryState {
  @override
  List<Object> get props => [];
}

final class DictionaryLoaded extends DictionaryState {
  const DictionaryLoaded({required this.dictionary, required this.wordsList});

  final Map<String, Word> dictionary;
  final List<String> wordsList;

  @override
  List<Object> get props => [];
}
