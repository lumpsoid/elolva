import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_lwt_port/dictionary/dictionary.dart';

class WordInfoDialog extends StatelessWidget {
  final BuildContext context;
  final String word;

  const WordInfoDialog(this.context, {super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    var dictionary =
        (context.read<DictionaryBloc>().state as DictionaryLoaded).dictionary;
    return AlertDialog(
      title: const Text('Word Information'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Word: $word'),
          Text('Translation: TRANSLATION'),
          Text('Pronunciation: PRONUNCIATION'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
