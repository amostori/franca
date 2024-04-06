import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../../utils/constants.dart';
import '../model/word_model.dart';

class HiveFunctions {
  static final wordBox = Hive.box<WordModel>(Constants.wordBox);
  static final archiveWordBox = Hive.box<WordModel>(Constants.archiveWordBox);

  List<WordModel> getWordList() {
    List<WordModel> wordList = [];
    if (wordBox.isNotEmpty) {
      for (WordModel wordModel in wordBox.values) {
        wordList.add(WordModel(
            frenchWord: wordModel.frenchWord,
            polishWord: wordModel.polishWord));
      }
      return wordList;
    } else {
      return [];
    }
  }

  List<WordModel> getArchiveList() {
    List<WordModel> wordList = [];
    if (archiveWordBox.isNotEmpty) {
      for (WordModel wordModel in archiveWordBox.values) {
        wordList.add(WordModel(
            frenchWord: wordModel.frenchWord,
            polishWord: wordModel.polishWord));
      }
      return wordList;
    } else {
      return [];
    }
  }

  void addWordToDatabase(WordModel word) {
    WordModel newWord =
        WordModel(polishWord: word.polishWord, frenchWord: word.frenchWord);
    wordBox.add(newWord);
  }

  void addWordToArchive(WordModel word) {
    WordModel newWord =
        WordModel(polishWord: word.polishWord, frenchWord: word.frenchWord);
    archiveWordBox.add(newWord);
  }

  Future<void> clearAll() async {
    await wordBox.clear();
    // print('word.clear word = ${wordBox.values.first.frenchWord}');
  }

  Future<void> removeOne(int index) async {
    await wordBox.deleteAt(index);
  }

  Future<void> removeFromArchive(int index) async {
    await archiveWordBox.deleteAt(index);
  }
}

final hiveProvider = Provider<HiveFunctions>((ref) {
  return HiveFunctions();
});
