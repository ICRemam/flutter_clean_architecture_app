import 'package:flutter_clean_architecture_app/core/error/exceptions.dart';
import 'package:flutter_clean_architecture_app/core/platform/newtwork_info.dart';
import 'package:flutter_clean_architecture_app/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:flutter_clean_architecture_app/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:flutter_clean_architecture_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_architecture_app/core/error/faliures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_app/features/number_trivia/domain/repositories/number_trivia_repo.dart';

class NumberTriviaRepoImpl implements NumberTriviaRepo {
  const NumberTriviaRepoImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number) async {
    return getNumberTrivia(random: false, number: number);
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return getNumberTrivia(random: true);
  }

  Future<Either<Failure, NumberTrivia>> getNumberTrivia({required bool random, int? number}) async {
    final bool connected = await networkInfo.connected;
    if (connected) {
      try {
        final response = random ? await remoteDataSource.getRandomNumberTrivia() : await remoteDataSource.getConcreteNumberTrivia(number!);
        localDataSource.cacheNumberTrivia(response);
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheExecption {
        return Left(CacheFailure());
      }
    }
  }
}
