import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_app/core/usecases/usecases.dart';
import 'package:flutter_clean_architecture_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_architecture_app/features/number_trivia/domain/repositories/number_trivia_repo.dart';
import 'package:flutter_clean_architecture_app/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:flutter_clean_architecture_app/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNumberTriviaRepo extends Mock implements NumberTriviaRepo {}

void main() {
  late GetRandomNumberTrivia usecase;
  late MockNumberTriviaRepo mockNumberTriviaRepo;

  setUp(() {
    mockNumberTriviaRepo = MockNumberTriviaRepo();
    usecase = GetRandomNumberTrivia(mockNumberTriviaRepo);
  });

  const tNumber = 1;
  const tNumberTrivia = NumberTrivia(text: 'text', number: tNumber);

  test('should get trivia from the repo', () async {
    //arrange
    when(() => mockNumberTriviaRepo.getRandomNumberTrivia()).thenAnswer((value) async => const Right(tNumberTrivia));
    //act
    final result = await usecase(NoParams());
    //assert
    expect(result, const Right(tNumberTrivia));
    verify(() => mockNumberTriviaRepo.getRandomNumberTrivia());
    verifyNoMoreInteractions(mockNumberTriviaRepo);
  });
}
