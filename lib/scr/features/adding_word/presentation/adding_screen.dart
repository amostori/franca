import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:france_edukacy/scr/features/home/database/hive_functions.dart';

import '../../home/model/word_model.dart';
import '../../home/provider/word_provider.dart';

class AddingScreen extends ConsumerWidget {
  AddingScreen({super.key});
  final TextEditingController polishWordController = TextEditingController();
  final TextEditingController frenchWordController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hiveFunctions = ref.watch(hiveProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dodaj nowe słowo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            // only numbers 0 - 9 and + sing are accepted in TextField
            TextField(
              controller: polishWordController,
              decoration: const InputDecoration(
                  labelText: 'Słowo po polsku', border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: frenchWordController,
              decoration: const InputDecoration(
                  labelText: 'Słowo po francusku',
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    if (polishWordController.text != '' &&
                        frenchWordController.text != '') {
                      final newWord = WordModel(
                          polishWord: polishWordController.text,
                          frenchWord: frenchWordController.text);
                      hiveFunctions.addWordToDatabase(newWord);
                      ref.read(wordProvider.notifier).showWord();
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    'Dodaj',
                    style: TextStyle(fontSize: 20),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
