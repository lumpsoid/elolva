import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_lwt_port/dictionary/dictionary.dart';
import 'package:test_lwt_port/main_nav_bar.dart';

class DictionaryScreen extends StatelessWidget {
  const DictionaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Dictionary'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: BlocBuilder<DictionaryBloc, DictionaryState>(
          builder: (context, state) {
        switch (state) {
          case DictionaryLoading():
            return const Center(child: CircularProgressIndicator());
          case DictionaryLoaded():
            if (state.wordsList.isEmpty) {
              return const Center(child: Text('No words.'));
            }
            return ListView.builder(itemBuilder: (context, index) {
              return WordCard(word: state.dictionary[state.wordsList[index]]!);
            });
        }
      }),
      bottomNavigationBar: const MainNavBar(),
    );
  }
}
