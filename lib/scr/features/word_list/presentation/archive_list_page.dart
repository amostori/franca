import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:france_edukacy/scr/features/home/model/word_model.dart';

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
              trailing: IconButton(
                onPressed: () {
                  hiveFunctions.addWordToDatabase(listOfWords[index]);
                  setState(() {});
                  showInfoAboutAddingWord(listOfWords[index].frenchWord);

                  // Navigator.pop(context);
                },
                icon: const Icon(Icons.add),
              ),
              onLongPress: () {
                _showAlertDialog(context, ref, listOfWords[index]);
              },
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

  Future<void> _showAlertDialog(
      BuildContext context, WidgetRef ref, WordModel wordModel) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Kasowanie wpisu'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Jesteś pewien, że chcesz to usunąć?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Anuluj'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Tak'),
              onPressed: () {
                ref.read(wordProvider.notifier).removeFromArchive(wordModel);
                setState(() {});
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
