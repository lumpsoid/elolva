import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_lwt_port/library/library.dart';
import 'package:test_lwt_port/main_nav_bar.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Library'),
      ),
      body: const LibraryList(),
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
    String bookPath = '';

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
                    onPressed: () async {
                      bookPath = await _pickFile();
                    },
                    child: bookPath.isEmpty
                        ? const Text('Pick a file')
                        : Text(bookPath)),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  if (bookName.isNotEmpty && bookPath.isNotEmpty) {
                    context.read<LibraryBloc>().add(LibraryBookAdded(Book(
                        name: bookName, author: bookAuthor, path: bookPath)));
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
}
