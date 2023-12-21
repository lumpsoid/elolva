import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_lwt_port/library/library.dart';
import 'package:test_lwt_port/library_repository.dart';
import 'package:test_lwt_port/simple_blog_observer.dart';
import 'settings/settings_screen.dart';

void main() {
  Bloc.observer = const SimpleBlocObserver();
  runApp(const MyApp());
}

/// The route configuration.
final GoRouter _router = GoRouter(
  initialLocation: '/library',
  routes: <RouteBase>[
    GoRoute(
      path: '/library',
      builder: (BuildContext context, GoRouterState state) {
        return const LibraryScreen();
      },
    ),
    GoRoute(
      path: '/settings',
      builder: (BuildContext context, GoRouterState state) {
        return const SettingsScreen();
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            LibraryBloc(LibraryRepository())..add(LibraryStarted()),
        child: MaterialApp.router(
            routerConfig: _router,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
              useMaterial3: true,
            )));
  }
}
