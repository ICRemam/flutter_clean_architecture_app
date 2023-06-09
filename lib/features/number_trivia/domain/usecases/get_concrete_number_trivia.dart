import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_app/core/error/faliures.dart';
import 'package:flutter_clean_architecture_app/core/usecases/usecases.dart';
import 'package:flutter_clean_architecture_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_architecture_app/features/number_trivia/domain/repositories/number_trivia_repo.dart';

class GetConcreteNumberTrivia implements UseCase<NumberTrivia, Params> {
  const GetConcreteNumberTrivia(this.numberTriviaRepo);
  final NumberTriviaRepo numberTriviaRepo;

  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async {
    return await numberTriviaRepo.getConcreteNumberTrivia(params.number);
  }
}

class Params extends Equatable {
  const Params({required this.number});
  final int number;
  @override
  List<Object?> get props => [number];
}
