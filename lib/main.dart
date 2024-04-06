import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:france_edukacy/scr/features/home/model/word_model.dart';
import 'package:france_edukacy/scr/features/home/presentation/home_screen.dart';
import 'package:france_edukacy/scr/utils/constants.dart';
import 'package:france_edukacy/scr/utils/routing/routing.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(WordModelAdapter());
  await Hive.openBox<WordModel>(Constants.wordBox);
  await Hive.openBox<WordModel>(Constants.archiveWordBox);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: routeByName,
      title: 'Franca',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
