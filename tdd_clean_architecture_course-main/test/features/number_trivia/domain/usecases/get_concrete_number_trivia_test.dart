import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:tdd_clean_architecture_course/core/error/failures.dart';
import 'package:tdd_clean_architecture_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd_clean_architecture_course/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:tdd_clean_architecture_course/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';

import 'get_concrete_number_trivia_test.mocks.dart';

@GenerateNiceMocks(
  <MockSpec<NumberTriviaRepository>>[MockSpec<NumberTriviaRepository>()],
)
void main() {
  MockNumberTriviaRepository mockNumberTriviaRepository;
  GetConcreteNumberTrivia usecase;

  mockNumberTriviaRepository = MockNumberTriviaRepository();
  usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);

  const int tNumber = 1;
  const NumberTrivia tNumberTrivia = NumberTrivia(number: 1, text: 'test');

  test('SHOULD get trivia for the number from the repository', () async {
    // arrange
    when(mockNumberTriviaRepository.getConcreteNumberTrivia(any)).thenAnswer(
      (Invocation realInvocation) async =>
          const Right<Failure, NumberTrivia>(tNumberTrivia),
    );
    // act
    final Either<Failure, NumberTrivia> result =
        await usecase(const Params(number: tNumber));
    // assert
    expect(result, const Right<Failure, NumberTrivia>(tNumberTrivia));
    verify(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber));
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
