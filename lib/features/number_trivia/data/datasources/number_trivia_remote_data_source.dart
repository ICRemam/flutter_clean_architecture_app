import 'dart:convert';

import 'package:flutter_clean_architecture_app/core/error/exceptions.dart';
import 'package:flutter_clean_architecture_app/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:http/http.dart' as http;

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  const NumberTriviaRemoteDataSourceImpl({required this.httpClient});
  final http.Client httpClient;
  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async {
    return _getTrivia(url: 'http://numbersapi.com/$number');
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() {
    return _getTrivia(url: 'http://numbersapi.com/random');
  }

  Future<NumberTriviaModel> _getTrivia({required String url}) async {
    final res = await httpClient.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );
    if (res.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(res.body));
    } else {
      throw ServerException();
    }
  }
}
