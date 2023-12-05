import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_lwt_port/pages_manager.dart';

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
          body: Text(
              context.select<PagesManager, String>((manager) => manager.content)
          )
        )
    );
  }
}