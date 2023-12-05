import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../book.dart';
import '../books_manager.dart' show BookManager;
import '../widgets/book_card.dart' show BookCard;
import '../widgets/main_nav_bar.dart';

class LibraryWidget extends StatelessWidget {
  const LibraryWidget({super.key});

  // TODO add return the file path
  Future<String> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt'],
    );

    if (result != null) {
      print("Selected file: ${result.files.single.path!}");
      return result.files.single.path!;
    } else {
      // User canceled the picker
    }
    return '';
  }

  // Function to show the input dialog
  Future<void> _addBookDialog(BuildContext context) async {
    String bookName = '';
    String bookAuthor = '';
    String pathToBook = '';

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
                TextButton(
                  onPressed: () {
                    _pickFile();
                  },
                  // TODO add state managment for add form
                  // rebuild this part when user picked file
                  child: pathToBook == ''
                      ? const Text('Pick a file')
                      : Text(pathToBook),
                ),
              ],
            ),
            actions: [
              // TODO is there a way to create a new dialog? or some kind of tooltip
              // that name is empty
              ElevatedButton(
                onPressed: () async {
                  if (bookName.isNotEmpty && pathToBook.isNotEmpty) {
                    final bookManager = context.read<BookManager>();
                    await bookManager.createBook(
                        bookName, bookAuthor, pathToBook);
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
          itemCount: context
              .select<BookManager, int>((manager) => manager.booksList.length),
          itemBuilder: (context, index) {
            List<Book> bookList = context.read<BookManager>().booksList;
            return BookCard(book: bookList[index]);
          }),
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
