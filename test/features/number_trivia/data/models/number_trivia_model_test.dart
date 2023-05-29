import 'dart:convert';

import 'package:flutter_clean_architecture_app/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_clean_architecture_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final numberTriviaModel = NumberTriviaModel(text: 'Test Text', number: 1);

  test('should be a subclass of number trivia entity', () async {
    expect(numberTriviaModel, isA<NumberTrivia>());
  });

  group('from json', () {
    test('should return a valid number trivia model when JSON number is an int', () async {
      //arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('trivia.json'));
      //act
      final result = NumberTriviaModel.fromJson(jsonMap);
      //assert
      expect(result, numberTriviaModel);
    });
    test('should return a valid number trivia model when JSON number is an double', () async {
      //arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('trivia_double.json'));
      //act
      final result = NumberTriviaModel.fromJson(jsonMap);
      //assert
      expect(result, numberTriviaModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      //act
      final result = numberTriviaModel.toJson();
      //assert
      final expectedMap = {
        "text": "Test Text",
        "number": 1,
      };
      expect(result, expectedMap);
    });
  });
}
