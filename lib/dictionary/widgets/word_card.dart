import 'package:flutter/material.dart';
import 'package:test_lwt_port/dictionary/dictionary.dart';

class WordCard extends StatelessWidget {
  const WordCard({super.key, required this.word});

  final Word word;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle tap action
        print('tap on wordcard: ${word.original}');
      },
      onLongPress: () {
        // Handle long tap action
        print('longpress on wordcard: ${word.original}');
      },
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          child: Row(
            children: [
              Text(word.original),
              Text(word.translation),
            ],
          )),
    );
  }
}
