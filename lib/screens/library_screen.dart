import 'package:flutter/material.dart';
import '../widgets/main_nav_bar.dart';
import '../widgets/book_card.dart' show BookCard;
import '../db/books.dart' show BooksDb;
import '../books_manager.dart' show BookManager;
import '../book.dart' show Book;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late BooksDb bookDb;
  late BookManager bookManager;
  late Future<void> bookChecked;

  // first time insert into tree
  // all initialization go here
  @override
  void initState() {
    super.initState();
    bookDb = BooksDb();
    // TODO из за того, что здесь async функция, не успевает подгружаться данные
    // до того момента, как дальше FutureBuilder начинает строить дерево BookCard
    bookManager = BookManager(bookDb);
    if (BookManager.booksId.isEmpty) {
      bookChecked = bookManager.updateBookList();
    } else {
      bookChecked = Future(() => null);
    }
  }

  // Function to show the input dialog
  Future<void> _addBook(BuildContext context) async {
    String bookName = '';
    String bookAuthor = '';

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
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
                  int id = await bookManager.createBook(bookName, bookAuthor);

                  // Add the new book to the list
                  setState(() {
                    bookManager.addId(id);
                  });
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
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('My books'),
      ),
      body: FutureBuilder<void>(
        future: bookChecked,
        builder: (context, listSnapshot) {
          if (listSnapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Display a loading indicator while waiting for book info
          } else if (listSnapshot.hasError) {
          return Text('Error on list: ${listSnapshot.error}');
          } else {
            return ListView.builder(
              itemCount: BookManager.booksId.length,
              itemBuilder: (context, index) {
                int bookId = BookManager.booksId[index];
                return FutureBuilder<Book>(
                  future: bookManager.getBookInfo(bookId),
                  builder: (context, bookSnapshot) {
                    if (bookSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return BookCard( isLoading: true, bookName: 'Loading', onOptionsPressed: (){}, ); // Display a loading indicator while waiting for book info
                    } else if (bookSnapshot.hasError) {
                      return Text('Error on book: ${bookSnapshot.error}');
                    } else if (!bookSnapshot.hasData) {
                      return const Text('No book info available.');
                    } else {
                      Book book = bookSnapshot.data!;
                      // Build your widget using the book info
                      return BookCard(
                        isLoading: false,
                        bookName: book.name,
                        onOptionsPressed: () {
                          // Handle options press
                          print('Options pressed ${book.id}');
                        },
                      );
                    }
                  },
                );
              },
            );
          }
        }
      ),
      bottomNavigationBar: const MainNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addBook(context);
        },
        tooltip: 'add book',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}