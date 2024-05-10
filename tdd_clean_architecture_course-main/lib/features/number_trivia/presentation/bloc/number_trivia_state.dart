part of 'number_trivia_bloc.dart';

sealed class NumberTriviaState extends Equatable {
  const NumberTriviaState();

  @override
  List<Object> get props => <Object>[];
}

final class NumberTriviaInitial extends NumberTriviaState {}

final class NumberTriviaLoading extends NumberTriviaState {}

final class NumberTriviaSuccess extends NumberTriviaState {
  const NumberTriviaSuccess({required this.trivia});

  final NumberTrivia trivia;

  @override
  List<Object> get props => <Object>[trivia];
}

final class NumberTriviaFailure extends NumberTriviaState {
  const NumberTriviaFailure({required this.message});

  final String message;

  @override
  List<Object> get props => <Object>[message];
}
