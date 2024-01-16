import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_lwt_port/library/library.dart';

class LibraryList extends StatelessWidget {
  const LibraryList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryBloc, LibraryState>(builder: (context, state) {
      switch (state) {
        case LibraryLoading():
          return const Center(child: CircularProgressIndicator());
        case LibraryLoaded():
          if (state.library.isEmpty) {
            return const Center(child: Text('no books'));
          }
          return ListView.builder(
              itemCount: state.hasReachedMax
                  ? state.library.length
                  : state.library.length + 1,
              itemBuilder: (context, index) {
                if (index >= state.library.length) {
                  context.read<LibraryBloc>().add(LibraryBookFetch(index));
                  return const BottomLoader();
                }
                return BookCard(book: state.library[index]);
              });
        case LibraryError():
          return const Center(child: Text('Error'));
      }
    });
  }
}
