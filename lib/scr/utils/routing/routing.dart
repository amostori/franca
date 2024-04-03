import 'package:france_edukacy/scr/features/adding_word/presentation/adding_screen.dart';
import 'package:france_edukacy/scr/features/home/presentation/home_screen.dart';
import 'package:france_edukacy/scr/features/word_list/presentation/word_list.dart';
import 'package:go_router/go_router.dart';

import 'error_page.dart';

enum AppRoute {
  home,
  adding,
  wordList,
}

final routeByName = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: false,
  errorBuilder: (context, state) => const ErrorPage(),
  routes: [
    GoRoute(
      path: '/',
      name: AppRoute.home.name,
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'adding',
          name: AppRoute.adding.name,
          builder: (context, state) => AddingScreen(),
        ),
        GoRoute(
          path: 'word_list',
          name: AppRoute.wordList.name,
          builder: (context, state) => const WordsList(),
        ),
      ],
    ),
  ],
);
