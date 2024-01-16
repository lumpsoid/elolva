import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_lwt_port/dictionary/dictionary.dart';
import 'package:test_lwt_port/main_nav_bar.dart';
import 'package:test_lwt_port/reader/reader.dart';

class ReaderScreen extends StatelessWidget {
  const ReaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: BlocBuilder<ReaderBloc, ReaderState>(
          builder: (context, state) => state is ReaderLoaded
              ? Text(state.book.name)
              : const Text('Loading'),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: BlocBuilder<ReaderBloc, ReaderState>(builder: (context, state) {
        switch (state) {
          case ReaderLoading():
            return const Center(child: CircularProgressIndicator());
          case ReaderLoaded():
            DictionaryBloc dictionaryBloc = context.read<DictionaryBloc>();
            late Map<String, Word> dictionary;
            if (dictionaryBloc.state is DictionaryLoaded) {
              dictionary =
                  (dictionaryBloc.state as DictionaryLoaded).dictionary;
            }

            return SelectionArea(
              child: PageView.builder(
                  controller: state.pageController,
                  itemBuilder: (context, index) {
                    // context.read<ReaderBloc>().add(ReaderNextPage(index));
                    var words = state.pages[index];
                    List<TextSpan> textSpans = [];

                    for (int i = 0; i < words.length; i++) {
                      String word = words[i];
                      Color wordColor;
                      if (dictionaryBloc.state is DictionaryLoaded) {
                        wordColor = dictionary[word]!.color;
                      } else {
                        wordColor = const Color.fromARGB(255, 156, 214, 255);
                      }
                      textSpans.add(
                        TextSpan(
                          text: word,
                          style: TextStyle(
                            color: Colors.black,
                            backgroundColor: wordColor,
                          ),
                        ),
                      );
                      // Add a space between words, except for the last word
                      if (i < words.length - 1) {
                        textSpans.add(const TextSpan(text: ' '));
                      }
                    }

                    return Center(
                      child: SelectableText.rich(
                          TextSpan(
                            style: const TextStyle(
                              height: 1.4,
                              fontSize: 20.0,
                              color: Colors.black,
                            ),
                            children: textSpans,
                          ), onSelectionChanged: (TextSelection selection,
                              SelectionChangedCause? cause) {
                        if (cause == SelectionChangedCause.tap) {
                          // Find the tapped word based on the selection
                          int tappedWordIndex =
                              findTappedWordIndex(words, selection.baseOffset);

                          if (tappedWordIndex != -1) {
                            print('Selected text: ${selection.toString()}');
                            String tappedWord = words[tappedWordIndex];
                            dictionaryBloc.add(DictionaryWordGet(tappedWord));
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  WordInfoDialog(context, word: tappedWord),
                            );
                          }
                        } else if (cause == SelectionChangedCause.longPress) {
                          print('Selected text: ${selection.toString()}');
                        }
                      }),
                    );
                  }),
            );
        }
      }),
      bottomNavigationBar: const MainNavBar(),
    );
  }

  int findTappedWordIndex(List<String> words, int offset) {
    int cumulativeOffset = 0;

    for (int i = 0; i < words.length; i++) {
      String word = words[i];
      cumulativeOffset += word.length;

      // Check if the offset is within the current word
      if (offset <= cumulativeOffset) {
        return i;
      }

      // Add 1 for the space between words
      cumulativeOffset++;
    }

    return -1; // Not found
  }
}
