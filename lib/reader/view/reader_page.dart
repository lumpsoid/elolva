import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_lwt_port/reader/reader.dart';

class ReaderPage extends StatelessWidget {
  const ReaderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: const Text('My books'),
            ),
            body:
                BlocBuilder<ReaderBloc, ReaderState>(builder: (context, state) {
              switch (state) {
                case ReaderLoading():
                  return const Center(child: CircularProgressIndicator());
                case ReaderLoaded():
                  return Text(state.book.text);
              }
            })));
  }
}
