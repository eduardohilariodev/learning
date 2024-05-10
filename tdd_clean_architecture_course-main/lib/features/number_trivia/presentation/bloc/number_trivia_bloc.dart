import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/util/input_converter.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/usecases/get_concrete_number_trivia.dart';
import '../../domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String serverFailureMessage = 'Server Failure';
const String cacheFailureMessage = 'Cache Failure';
const String invalidInputFailureMessage =
    'Invalid Input - The number must be a positive integer or zero';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  NumberTriviaBloc({
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
    required this.inputConverter,
  }) : super(NumberTriviaInitial()) {
    on<GetTriviaForConcreteNumber>((
      GetTriviaForConcreteNumber event,
      Emitter<NumberTriviaState> emit,
    ) async {
      final Either<Failure, int> inputEither =
          inputConverter.stringToUnsignedInteger(event.numberString);

      await inputEither.fold(
        (Failure failure) async => emit(
          const NumberTriviaFailure(message: invalidInputFailureMessage),
        ),
        (int integer) async {
          emit(NumberTriviaLoading());
          final Either<Failure, NumberTrivia> failureOrTrivia =
              await getConcreteNumberTrivia(Params(number: integer));
          _eitherFailureOrSuccess(emit, failureOrTrivia);
        },
      );
    });
    on<GetTriviaForRandomNumber>((
      GetTriviaForRandomNumber event,
      Emitter<NumberTriviaState> emit,
    ) async {
      emit(NumberTriviaLoading());
      final Either<Failure, NumberTrivia> failureOrTrivia =
          await getRandomNumberTrivia(NoParams());
      _eitherFailureOrSuccess(emit, failureOrTrivia);
    });
  }

  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  void _eitherFailureOrSuccess(
    Emitter<NumberTriviaState> emit,
    Either<Failure, NumberTrivia> failureOrTrivia,
  ) {
    emit(
      failureOrTrivia.fold(
        (Failure failure) => NumberTriviaFailure(
          message: _mapFailureToMessage(failure),
        ),
        (NumberTrivia trivia) => NumberTriviaSuccess(trivia: trivia),
      ),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure) {
      case ServerFailure _:
        return serverFailureMessage;
      case CacheFailure _:
        return cacheFailureMessage;
      default:
        return 'Unexpected error';
    }
  }
}
