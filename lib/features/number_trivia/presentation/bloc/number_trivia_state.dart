part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();

  @override
  List<Object> get props => [];
}

class NumberTriviaInitial extends NumberTriviaState {}

class NumberTriviaLoading extends NumberTriviaState {}

class NumberTriviaLoaded extends NumberTriviaState {
  const NumberTriviaLoaded(this.numberTrivia);
  final NumberTrivia numberTrivia;
  @override
  List<Object> get props => [numberTrivia];
}

class NumberTriviaError extends NumberTriviaState {
  const NumberTriviaError(this.errorMessage);
  final String errorMessage;
  @override
  List<Object> get props => [errorMessage];
}
