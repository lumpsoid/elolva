import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../book.dart';
import '../widgets/main_nav_bar.dart';
import '../widgets/book_card.dart' show BookCard;
import '../books_manager.dart' show BookManager;

class LibraryWidget extends StatelessWidget {
  const LibraryWidget({super.key});

  // Function to show the input dialog
  Future<void> _addBookDialog(BuildContext context) async {
    String bookName = '';
    String bookAuthor = '';

    return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: AlertDialog(
            title: const Text('Enter Book Name'),
            content: Column(
              children: [
                TextField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                  onChanged: (value) {
                    bookName = value;
                  },
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Author',
                  ),
                  onChanged: (value) {
                    bookAuthor = value;
                  },
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  if (bookName.isNotEmpty) {
                    final bookManager = context.read<BookManager>();
                    await bookManager.createBook(bookName, bookAuthor);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Add'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('My books'),
      ),
      body: ListView.builder(
        itemCount: context.select<BookManager, int>(
          (manager) => manager.booksList.length
        ),
        itemBuilder: (context, index) {
          List<Book> bookList = context.read<BookManager>().booksList;
          return BookCard(book: bookList[index]);
        }
      ),
      bottomNavigationBar: const MainNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addBookDialog(context);
        },
        tooltip: 'add book',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}