import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final String bookName;
  final VoidCallback onOptionsPressed;
  final bool isLoading;

  // Constructor to receive bookName, the callback for options press, and loading state
  const BookCard({
    super.key,
    required this.bookName,
    required this.onOptionsPressed,
    required this.isLoading,
  });

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
        leading: isLoading
            ? const CircularProgressIndicator()
            : null,
        title: Text(
          bookName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: isLoading
          ? null
          : IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: onOptionsPressed,
        ),
      ),
    );
  }
}
