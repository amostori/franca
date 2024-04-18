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
    // WordModel newWord =
    //     WordModel(polishWord: word.polishWord, frenchWord: word.frenchWord);
    // wordBox.add(word);
    wordBox.put(word.frenchWord, word);
  }

  void addWordToArchive(WordModel word) {
    // for (var i in archiveWordBox.values) {
    //   print('${i.frenchWord}  ${word.frenchWord}literacja');
    //   if (i.frenchWord.contains(word.frenchWord)) {
    //     print('i.frenchWord.contains(word.frenchWord) is true');
    //   } else {
    //     print('i.frenchWord.contains(word.frenchWord) is false');
    //     archiveWordBox.add(word);

    archiveWordBox.put(word.frenchWord, word);
  }

  Future<void> clearAll() async {
    await wordBox.clear();
  }

  Future<void> removeOne(WordModel wordModel) async {
    await wordBox.delete(wordModel.frenchWord);
  }

  Future<void> removeFromArchive(WordModel wordModel) async {
    await archiveWordBox.delete(wordModel.frenchWord);
    // await archiveWordBox.delete(key)
  }
}

final hiveProvider = Provider<HiveFunctions>((ref) {
  return HiveFunctions();
});
