import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:france_edukacy/scr/features/home/database/hive_functions.dart';
import 'package:france_edukacy/scr/features/home/provider/word_provider.dart';

class WordsList extends ConsumerWidget {
  const WordsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hiveFunctions = ref.watch(hiveProvider);
    final listOfWords = hiveFunctions.getWordList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista słówek'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                listOfWords[index].frenchWord,
                style: const TextStyle(fontSize: 24),
              ),
              trailing: IconButton(
                onPressed: () {
                  ref.read(wordProvider.notifier).removeOne(index);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.remove),
              ),
            );
          },
          itemCount: listOfWords.length,
        ),
      ),
    );
  }
}
