import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_app/core/error/faliures.dart';
import 'package:flutter_clean_architecture_app/core/usecases/usecases.dart';
import 'package:flutter_clean_architecture_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_architecture_app/features/number_trivia/domain/repositories/number_trivia_repo.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  const GetRandomNumberTrivia(this.numberTriviaRepo);
  final NumberTriviaRepo numberTriviaRepo;

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await numberTriviaRepo.getRandomNumberTrivia();
  }
}
