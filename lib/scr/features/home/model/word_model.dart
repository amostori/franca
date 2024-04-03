import 'package:hive_flutter/adapters.dart';
part 'word_model.g.dart';

@HiveType(typeId: 2)
class WordModel extends HiveObject {
  @HiveField(0)
  String frenchWord;
  @HiveField(1)
  String polishWord;

  WordModel({
    required this.frenchWord,
    required this.polishWord,
  });

  WordModel copyWith({
    String? frenchWord,
    String? polishWord,
  }) {
    return WordModel(
      frenchWord: frenchWord ?? this.frenchWord,
      polishWord: polishWord ?? this.polishWord,
    );
  }
}
