import 'dart:convert';

import 'package:flutter_clean_architecture_app/core/error/exceptions.dart';
import 'package:flutter_clean_architecture_app/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:flutter_clean_architecture_app/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPref extends Mock implements SharedPreferences {}

void main() {
  late NumberTriviaLocalDataSourceImpl dataSource;
  late MockSharedPref mockSharedPref;

  setUp(() {
    mockSharedPref = MockSharedPref();
    dataSource = NumberTriviaLocalDataSourceImpl(sharedPref: mockSharedPref);
  });

  group('get last number trivia', () {
    final tNumberTriviaModel = NumberTriviaModel.fromJson(json.decode(fixture('trivia_cached.json')));
    test('should return data from shared pref if there is any', () async {
      //arrange
      when(() => mockSharedPref.getString(any())).thenReturn(fixture('trivia_cached.json'));
      //act
      final result = await dataSource.getLastNumberTrivia();
      //assert
      verify(() => mockSharedPref.getString(chacheNumberKey));
      expect(result, tNumberTriviaModel);
    });

    test('should return cache exeption when there is no value', () async {
      //arrange
      when(() => mockSharedPref.getString(any())).thenReturn(null);
      //act
      final call = dataSource.getLastNumberTrivia;
      //assert
      expect(() => call(), throwsA(const TypeMatcher<CacheExecption>()));
    });
  });

  group('cache number trivia', () {
    final tNumberTriviaModel = NumberTriviaModel(text: 'test trivia', number: 1);
    final expectedResult = json.encode(tNumberTriviaModel.toJson());
    test('should call shared pref to cache data', () async {
      //arrange
      when(() => mockSharedPref.setString(chacheNumberKey, any())).thenAnswer((_) async => true);
      //act
      dataSource.cacheNumberTrivia(tNumberTriviaModel);
      //assert

      verify(() => mockSharedPref.setString(chacheNumberKey, expectedResult));
    });
  });
}
