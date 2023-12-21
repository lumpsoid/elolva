import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:test_lwt_port/library/models/models.dart';
import 'package:test_lwt_port/library_repository.dart';

part 'reader_event.dart';
part 'reader_state.dart';

class ReaderBloc extends Bloc<ReaderEvent, ReaderState> {
  ReaderBloc(this.libraryRepository) : super(ReaderLoading());

  final LibraryRepository libraryRepository;

  // Future<void> getContent() async {
  //   if (book.text.isNotEmpty) {
  //     content = book.text;
  //     return;
  //   }
  //   List<Map<String, dynamic>> data = await _booksDb.getBookText(book.id);
  //   if (data.isEmpty) {
  //     throw StateError('Got empty book data from DB.');
  //   }
  //   content = data[0]['text'];
  //   return;
  // }
}
