import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../home/database/hive_functions.dart';
import '../../home/provider/word_provider.dart';

class ArchiveListPage extends ConsumerStatefulWidget {
  const ArchiveListPage({super.key});

  @override
  ConsumerState createState() => _ArchiveListPageState();
}

class _ArchiveListPageState extends ConsumerState<ArchiveListPage> {
  @override
  Widget build(BuildContext context) {
    final hiveFunctions = ref.watch(hiveProvider);
    final listOfWords = hiveFunctions.getArchiveList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Archiwum słówek'),
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
                  hiveFunctions.addWordToDatabase(listOfWords[index]);
                  setState(() {});
                  showInfoAboutAddingWord(listOfWords[index].frenchWord);

                  // Navigator.pop(context);
                },
                icon: const Icon(Icons.add),
              ),
              trailing: IconButton(
                onPressed: () {
                  ref
                      .read(wordProvider.notifier)
                      .removeFromArchive(index, listOfWords[index]);
                  setState(() {});

                  // Navigator.pop(context);
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

  void showInfoAboutAddingWord(String word) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Dodano słowo $word do '
            'nauki')));
  }
}
