import 'package:flutter/material.dart';
import '../widgets/main_nav_bar.dart' show MainNavBar;

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const Center(
        child: Text('Settings Screen'),
      ),
      bottomNavigationBar: const MainNavBar()
    );
  }
}