import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_app/core/error/faliures.dart';
import 'package:flutter_clean_architecture_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_architecture_app/features/number_trivia/domain/repositories/number_trivia_repo.dart';

class GetConcreteNumberTrivia {
  const GetConcreteNumberTrivia(this.numberTriviaRepo);
  final NumberTriviaRepo numberTriviaRepo;

  Future<Either<Failure, NumberTrivia>> execute({required int number}) async {
    return await numberTriviaRepo.getConcreteNumberTrivia(number);
  }
}
