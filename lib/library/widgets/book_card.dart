import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_lwt_port/library/library.dart';
import 'package:test_lwt_port/reader/reader.dart';

class BookCard extends StatelessWidget {
  final Book book;

  // Constructor to receive bookName, the callback for options press, and loading state
  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: Theme.of(context).primaryColor, // Customize the border color
          width: 1.5, // Customize the border width
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        title: InkWell(
          child: Text(book.name),
          onLongPress: () {},
        ),
        trailing: TextButton(
          child: const Text('Open'),
          onPressed: () {
            context.read<ReaderBloc>().add(ReaderOpenBook(book: book));
            context.go('/reader');
          },
        ),
      ),
    );
  }
}
