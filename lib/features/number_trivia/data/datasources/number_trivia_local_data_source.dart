import 'dart:convert';

import 'package:flutter_clean_architecture_app/core/error/exceptions.dart';
import 'package:flutter_clean_architecture_app/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel> getLastNumberTrivia();
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}

const chacheNumberKey = 'CAHCED_NUMBER_TRIVIA';

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  const NumberTriviaLocalDataSourceImpl({required this.sharedPref});

  final SharedPreferences sharedPref;

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final jsonString = sharedPref.getString(chacheNumberKey);
    if (jsonString != null) {
      return Future.value(NumberTriviaModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheExecption();
    }
  }

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) {
    return sharedPref.setString(chacheNumberKey, json.encode(triviaToCache.toJson()));
  }
}
