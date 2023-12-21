import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainNavBar extends StatelessWidget {
  const MainNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: IconButton(
              icon: const Icon(Icons.abc),
              onPressed: () {
                // Handle home button press
              },
            ),
          ),
          Expanded(
            child: IconButton(
              icon: const Icon(Icons.library_books_outlined),
              onPressed: () => context.go('/library'),
            ),
          ),
          Expanded(
            child: IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () => context.go('/settings'),
            ),
          ),
        ],
      ),
    );
  }
}