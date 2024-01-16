import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_lwt_port/library_repository.dart';
import 'package:test_lwt_port/dictionary/dictionary.dart';
import 'package:test_lwt_port/translater_repository.dart';

part 'words_event.dart';
part 'words_state.dart';

class DictionaryBloc extends Bloc<DictionaryEvent, DictionaryState> {
  DictionaryBloc(this.libraryRepository, this.translateRepository)
      : super(DictionaryLoading()) {
    on<DictionaryStarted>(_onStarted);
    on<DictionaryWordAdd>(_onWordAdd);
    on<DictionaryWordGet>(_onWordGet);
  }

  final LibraryRepository libraryRepository;
  final TranslateRepository translateRepository;

  Future<void> _onStarted(
      DictionaryStarted event, Emitter<DictionaryState> emit) async {
    var (wordsList, dictionary) = await libraryRepository.fetchWordsAll();
    emit(DictionaryLoaded(dictionary: dictionary, wordsList: wordsList));
  }

  Future<void> _onWordAdd(
      DictionaryWordAdd event, Emitter<DictionaryState> emit) async {
    var state = this.state;
    if (state is DictionaryLoaded) {
      Map<String, Word> dictionaryNew = {
        ...state.dictionary,
        event.word.original: event.word
      };
      List<String> wordsListNew = [...state.wordsList, event.word.original];
      emit(
          DictionaryLoaded(dictionary: dictionaryNew, wordsList: wordsListNew));
    }
  }

  Future<void> _getWordFromEngine(
      DictionaryWordGet event, Emitter<DictionaryState> emit) async {
    var state = this.state;
    if (state is DictionaryLoaded) {}
  }

  Future<void> _onWordGet(
      DictionaryWordGet event, Emitter<DictionaryState> emit) async {
    var state = this.state;
    if (state is DictionaryLoaded) {
      if (state.dictionary.containsKey(event.original)) return;
      String translation =
          await translateRepository.getTranslation(event.original);
      Word word = Word(event.original, translation, examples: const []);
    }
    return;
  }
}
