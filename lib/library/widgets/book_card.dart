import 'package:flutter/material.dart';
import 'package:test_lwt_port/library/library.dart';

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
          onTap: () {
            // Handle tap action here
          },
          child: Text(book.name),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {},
        ),
      ),
    );
  }
}
