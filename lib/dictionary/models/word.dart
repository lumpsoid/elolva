import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

enum WordStatus { unknown, known, learning }

class Word extends Equatable {
  static const Map<WordStatus, Color> colorMap = {
    WordStatus.unknown: Color.fromARGB(255, 156, 214, 255),
    WordStatus.learning: Color.fromARGB(255, 255, 220, 156),
    WordStatus.known: Color.fromARGB(255, 156, 255, 169),
  };

  const Word(this.original, this.translation,
      {this.pronunciation = '',
      this.state = WordStatus.unknown,
      required this.examples});

  Word.fromDb(item)
      : original = item['original'],
        translation = item['translation'],
        pronunciation = item['pronunciation'],
        examples = [],
        state = item['state'];

  final String original;
  final String translation;
  final String pronunciation;
  final List<String> examples;
  final WordStatus state;

  get color => colorMap[state];

  Word copyWith(
      {String? original,
      String? translation,
      String? pronunciation,
      WordStatus? state,
      List<String>? examples}) {
    return Word(original ?? this.original, translation ?? this.translation,
        pronunciation: pronunciation ?? this.pronunciation,
        state: state ?? this.state,
        examples: examples ?? this.examples);
  }

  @override
  List<Object?> get props =>
      [original, translation, pronunciation, examples, state];
}
