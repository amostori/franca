import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/routing/routing.dart';
import '../../home/database/hive_functions.dart';
import '../../home/provider/word_provider.dart';

class WordList extends ConsumerStatefulWidget {
  const WordList({super.key});

  @override
  ConsumerState createState() => _WordListState();
}

class _WordListState extends ConsumerState<WordList> {
  @override
  Widget build(BuildContext context) {
    final hiveFunctions = ref.watch(hiveProvider);
    final delay = ref.watch(delayProvider);
    final listOfWords = hiveFunctions.getWordList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Czas: $delay s'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(delayProvider.notifier).state++;
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              if (delay > 1) {
                ref.read(delayProvider.notifier).state--;
              } else {
                return;
              }
            },
            icon: const Icon(Icons.remove),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goNamed(AppRoute.archiveList.name);
        },
        child: const Icon(Icons.all_inclusive),
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
              leading: IconButton(
                onPressed: () {
                  ref.read(wordProvider.notifier).removeOne(listOfWords[index]);
                  setState(() {});
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
