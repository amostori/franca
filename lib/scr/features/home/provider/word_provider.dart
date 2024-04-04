import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:france_edukacy/scr/features/home/database/hive_functions.dart';
import 'package:france_edukacy/scr/features/home/model/word_model.dart';

import '../../../utils/constants.dart';

class Word extends StateNotifier<WordModel> {
  Word({required this.delay, required this.hiveFunctions})
      : super(WordModel(
            frenchWord: '',
            polishWord: 'Naciśnij przycisk na dole ekranu.'
                ''));
  final int delay;
  final HiveFunctions hiveFunctions;

  Future<void> showWord() async {
    final word = getQuestion();
    print(word.frenchWord);
    state = state.copyWith(
        frenchWord: Constants.progressIndicator, polishWord: word.polishWord);
    await Future.delayed(Duration(seconds: delay));
    state = state.copyWith(frenchWord: word.frenchWord);
  }

  Future<void> clearAll() async {
    await hiveFunctions.clearAll();
    showWord();
  }

  Future<void> removeOne(int index) async {
    await hiveFunctions.removeOne(index);
    showWord();
  }

  WordModel getQuestion() {
    var wordList = hiveFunctions.getWordList();
    if (wordList.isNotEmpty) {
      final random = Random().nextInt(wordList.length);
      return wordList[random];
    } else {
      return WordModel(frenchWord: '', polishWord: 'Brak słówek');
    }
  }
}

final delayProvider = StateProvider<int>((ref) {
  return 5;
});

final wordProvider = StateNotifierProvider<Word, WordModel>((ref) {
  final delay = ref.watch(delayProvider);
  final hiveFunctions = ref.watch(hiveProvider);
  return Word(delay: delay, hiveFunctions: hiveFunctions);
});
