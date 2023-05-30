import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_app/core/error/exceptions.dart';
import 'package:flutter_clean_architecture_app/core/error/faliures.dart';
import 'package:flutter_clean_architecture_app/core/platform/newtwork_info.dart';
import 'package:flutter_clean_architecture_app/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:flutter_clean_architecture_app/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:flutter_clean_architecture_app/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_clean_architecture_app/features/number_trivia/data/repositories/number_trivia_repo_impl.dart';
import 'package:flutter_clean_architecture_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock implements NumberTriviaRemoteDataSource {}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late NumberTriviaRepoImpl repo;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repo = NumberTriviaRepoImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });
  const tNumber = 1;
  const tNumberTriviaModel = NumberTriviaModel(text: 'test trivia', number: tNumber);
  const NumberTrivia tNumberTrivia = tNumberTriviaModel;
  group('get concrete number trivia', () {
    test('check if the device is online', () async {
      //arrange
      when(() => mockNetworkInfo.connected).thenAnswer((_) async => true);
      //act
      await repo.getConcreteNumberTrivia(tNumber);
      //assert
      verify((() => mockNetworkInfo.connected));
    });
  });

  group('device is online', () {
    setUp(() {
      when(() => mockNetworkInfo.connected).thenAnswer((_) async => true);
    });
    test('should return remote data when the call to remote data source is success', () async {
      //arrange
      when(() => mockRemoteDataSource.getConcreteNumberTrivia(any())).thenAnswer((_) async => tNumberTriviaModel);
      //act
      final result = await repo.getConcreteNumberTrivia(tNumber);
      //assert
      verify(() => mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
      expect(result, equals(const Right(tNumberTrivia)));
    });

    test('should cache data locally when the call to remote data source is success', () async {
      //arrange
      when(() => mockRemoteDataSource.getConcreteNumberTrivia(any())).thenAnswer((_) async => tNumberTriviaModel);
      //act
      await repo.getConcreteNumberTrivia(tNumber);
      //assert
      verify(() => mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
      verify(() => mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
    });
    test('should return a server failure when the call to remote data source is unsuccessful', () async {
      //arrange
      when(() => mockRemoteDataSource.getConcreteNumberTrivia(any())).thenThrow(ServerException());
      //act
      final result = await repo.getConcreteNumberTrivia(tNumber);
      //assert
      verify(() => mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
      verifyZeroInteractions(mockLocalDataSource);
      expect(result, equals(Left(ServerFailure())));
    });
  });
  group('device is offline', () {
    setUp(() {
      when(() => mockNetworkInfo.connected).thenAnswer((_) async => false);
    });
    test('should return last locally cached data if any is present', () async {
      //arrange
      when(
        () => mockLocalDataSource.getLastNumberTrivia().then((value) => tNumberTriviaModel),
      );
      //act
      final result = repo.getConcreteNumberTrivia(tNumber);
      //assert
      verifyZeroInteractions(mockRemoteDataSource);
      verify(
        () => mockLocalDataSource.getLastNumberTrivia(),
      );
      expect(result, equals(const Right(tNumberTrivia)));
    });
  });
}
