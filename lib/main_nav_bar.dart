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
              onPressed: () => context.go('/dictionary'),
            ),
          ),
          Expanded(
            child: IconButton(
              icon: const Icon(Icons.menu_book_rounded),
              onPressed: () => context.go('/reader'),
            ),
          ),
          Expanded(
            child: IconButton(
              icon: const Icon(Icons.format_list_bulleted_rounded),
              onPressed: () => context.go('/library'),
            ),
          ),
        ],
      ),
    );
  }
}
