import 'package:flutter/material.dart';
import '../screens/settings_screen.dart' show SettingsScreen;
import '../screens/library_screen.dart' show MyHomePage;

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
              onPressed: () {
                // Handle book button press
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
                );
              },
            ),
          ),
          Expanded(
            child: IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () {
                // Handle profile button press
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}