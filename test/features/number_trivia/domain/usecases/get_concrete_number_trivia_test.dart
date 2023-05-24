import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_architecture_app/features/number_trivia/domain/repositories/number_trivia_repo.dart';
import 'package:flutter_clean_architecture_app/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNumberTriviaRepo extends Mock implements NumberTriviaRepo {}

void main() {
  late GetConcreteNumberTrivia usecase;
  late MockNumberTriviaRepo mockNumberTriviaRepo;

  setUp(() {
    mockNumberTriviaRepo = MockNumberTriviaRepo();
    usecase = GetConcreteNumberTrivia(mockNumberTriviaRepo);
  });

  const tNumber = 1;
  const tNumberTrivia = NumberTrivia(text: 'text', number: tNumber);

  test('should get trivia for the number in the repo', () async {
    //arrange
    when(() => mockNumberTriviaRepo.getConcreteNumberTrivia(any())).thenAnswer((value) async => const Right(tNumberTrivia));
    //act
    final result = await usecase.execute(number: tNumber);
    //assert
    expect(result, const Right(tNumberTrivia));
    verify(() => mockNumberTriviaRepo.getConcreteNumberTrivia(tNumber));
    verifyNoMoreInteractions(mockNumberTriviaRepo);
  });
}
