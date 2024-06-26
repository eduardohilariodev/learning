import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:tdd_clean_architecture_course/core/error/failures.dart';
import 'package:tdd_clean_architecture_course/core/usecases/usecase.dart';
import 'package:tdd_clean_architecture_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd_clean_architecture_course/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:tdd_clean_architecture_course/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

import 'get_concrete_number_trivia_test.mocks.dart';

@GenerateNiceMocks(
  <MockSpec<NumberTriviaRepository>>[MockSpec<NumberTriviaRepository>()],
)
void main() {
  MockNumberTriviaRepository mockNumberTriviaRepository;
  GetRandomNumberTrivia usecase;

  mockNumberTriviaRepository = MockNumberTriviaRepository();
  usecase = GetRandomNumberTrivia(mockNumberTriviaRepository);

  const NumberTrivia tNumberTrivia = NumberTrivia(number: 1, text: 'test');

  test('SHOULD get trivia for the repository', () async {
    // arrange
    when(mockNumberTriviaRepository.getRandomNumberTrivia()).thenAnswer(
      (Invocation realInvocation) async =>
          const Right<Failure, NumberTrivia>(tNumberTrivia),
    );
    // act
    final Either<Failure, NumberTrivia> result = await usecase(NoParams());
    // assert
    expect(result, const Right<Failure, NumberTrivia>(tNumberTrivia));
    verify(mockNumberTriviaRepository.getRandomNumberTrivia());
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
