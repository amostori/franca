import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:france_edukacy/scr/features/home/database/hive_functions.dart';
import 'package:france_edukacy/scr/features/home/provider/word_provider.dart';
import 'package:france_edukacy/scr/utils/routing/routing.dart';
import 'package:go_router/go_router.dart';

class WordsList extends ConsumerWidget {
  const WordsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hiveFunctions = ref.watch(hiveProvider);
    final delay = ref.watch(delayProvider);
    final listOfWords = hiveFunctions.getWordList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Opóźnienie $delay s'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(delayProvider.notifier).state++;
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              ref.read(delayProvider.notifier).state--;
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
                  ref
                      .read(wordProvider.notifier)
                      .removeOne(index, listOfWords[index]);
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
