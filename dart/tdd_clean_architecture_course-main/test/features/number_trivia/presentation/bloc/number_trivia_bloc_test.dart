import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:tdd_clean_architecture_course/core/error/failures.dart';
import 'package:tdd_clean_architecture_course/core/usecases/usecase.dart';
import 'package:tdd_clean_architecture_course/core/util/input_converter.dart';
import 'package:tdd_clean_architecture_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd_clean_architecture_course/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:tdd_clean_architecture_course/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:tdd_clean_architecture_course/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

import 'number_trivia_bloc_test.mocks.dart';

@GenerateNiceMocks(
  <MockSpec<GetConcreteNumberTrivia>>[MockSpec<GetConcreteNumberTrivia>()],
)
@GenerateNiceMocks(
  <MockSpec<GetRandomNumberTrivia>>[MockSpec<GetRandomNumberTrivia>()],
)
@GenerateNiceMocks(<MockSpec<InputConverter>>[MockSpec<InputConverter>()])
void main() {
  late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockInputConverter mockInputConverter;
  late NumberTriviaBloc numberTriviaBloc;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();
    numberTriviaBloc = NumberTriviaBloc(
      getConcreteNumberTrivia: mockGetConcreteNumberTrivia,
      getRandomNumberTrivia: mockGetRandomNumberTrivia,
      inputConverter: mockInputConverter,
    );
  });

  test(
    'initialState SHOULD be [NumberTriviaInitial]',
    () async {
      // Assert
      expect(numberTriviaBloc.state, equals(NumberTriviaInitial()));
    },
  );

  group('GetTriviaForConcreteNumber', () {
    const String tNumberString = '1';
    const int tNumberParsed = 1;
    const NumberTrivia tNumberTrivia =
        NumberTrivia(text: 'test trivia', number: 1);

    void setUpMockInputConverterSuccess() =>
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(const Right<Failure, int>(tNumberParsed));

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      '''
      SHOULD call the [InputConverter] to validate and
      convert the string to an unsigned integer
      ''',
      build: () {
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any)).thenAnswer(
          (_) async => const Right<Failure, NumberTrivia>(tNumberTrivia),
        );
        return numberTriviaBloc;
      },
      act: (NumberTriviaBloc bloc) =>
          bloc.add(const GetTriviaForConcreteNumber(tNumberString)),
      verify: (_) =>
          verify(mockInputConverter.stringToUnsignedInteger(tNumberString)),
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'SHOULD emit [NumberTriviaFailure] when the input is invalid,',
      build: () {
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Left<Failure, int>(InvalidInputFailure()));
        return numberTriviaBloc;
      },
      act: (NumberTriviaBloc bloc) =>
          bloc.add(const GetTriviaForConcreteNumber(tNumberString)),
      expect: () => <NumberTriviaFailure>[
        const NumberTriviaFailure(message: invalidInputFailureMessage),
      ],
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'SHOULD get data from the concrete use case',
      build: () {
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any)).thenAnswer(
          (_) async => const Right<Failure, NumberTrivia>(tNumberTrivia),
        );
        return numberTriviaBloc;
      },
      act: (NumberTriviaBloc bloc) =>
          bloc.add(const GetTriviaForConcreteNumber(tNumberString)),
      verify: (_) => verify(
        mockGetConcreteNumberTrivia(const Params(number: tNumberParsed)),
      ),
    );
    blocTest<NumberTriviaBloc, NumberTriviaState>(
      '''
      SHOULD emit [NumberTriviaLoading, NumberTriviaSuccess]
      when data is gotten successfully
      ''',
      build: () {
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any)).thenAnswer(
          (_) async => const Right<Failure, NumberTrivia>(tNumberTrivia),
        );

        return numberTriviaBloc;
      },
      act: (NumberTriviaBloc bloc) =>
          bloc.add(const GetTriviaForConcreteNumber(tNumberString)),
      expect: () => <dynamic>[
        NumberTriviaLoading(),
        const NumberTriviaSuccess(trivia: tNumberTrivia),
      ],
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      '''
      SHOULD emit [NumberTriviaLoading, NumberTriviaFailure] 
      when getting data fails
      ''',
      build: () {
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any)).thenAnswer(
          (_) async => Left<Failure, NumberTrivia>(ServerFailure()),
        );

        return numberTriviaBloc;
      },
      act: (NumberTriviaBloc bloc) =>
          bloc.add(const GetTriviaForConcreteNumber(tNumberString)),
      expect: () => <dynamic>[
        NumberTriviaLoading(),
        const NumberTriviaFailure(message: serverFailureMessage),
      ],
    );
    blocTest<NumberTriviaBloc, NumberTriviaState>(
      '''
      SHOULD emit [NumberTriviaLoading, NumberTriviaFailure] 
      with a proper message when getting data fails
      ''',
      build: () {
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any)).thenAnswer(
          (_) async => Left<Failure, NumberTrivia>(CacheFailure()),
        );
        return numberTriviaBloc;
      },
      act: (NumberTriviaBloc bloc) =>
          bloc.add(const GetTriviaForConcreteNumber(tNumberString)),
      expect: () => <dynamic>[
        NumberTriviaLoading(),
        const NumberTriviaFailure(message: cacheFailureMessage),
      ],
    );
  });
  group('GetTriviaForRandomNumber', () {
    const NumberTrivia tNumberTrivia =
        NumberTrivia(text: 'test trivia', number: 1);

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'SHOULD get data from the concrete use case',
      build: () {
        when(mockGetRandomNumberTrivia(any)).thenAnswer(
          (_) async => const Right<Failure, NumberTrivia>(tNumberTrivia),
        );
        return numberTriviaBloc;
      },
      act: (NumberTriviaBloc bloc) => bloc.add(GetTriviaForRandomNumber()),
      verify: (_) => verify(
        mockGetRandomNumberTrivia(NoParams()),
      ),
    );
    blocTest<NumberTriviaBloc, NumberTriviaState>(
      '''
      SHOULD emit [NumberTriviaLoading, NumberTriviaSuccess] 
      WHEN getting data 
      IS successful
      ''',
      build: () {
        when(mockGetRandomNumberTrivia(any)).thenAnswer(
          (_) async => const Right<Failure, NumberTrivia>(tNumberTrivia),
        );

        return numberTriviaBloc;
      },
      act: (NumberTriviaBloc bloc) => bloc.add(GetTriviaForRandomNumber()),
      expect: () => <dynamic>[
        NumberTriviaLoading(),
        const NumberTriviaSuccess(trivia: tNumberTrivia),
      ],
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      '''
SHOULD emit [NumberTriviaLoading, NumberTriviaFailure]
 when getting data fails
 ''',
      build: () {
        when(mockGetRandomNumberTrivia(any)).thenAnswer(
          (_) async => Left<Failure, NumberTrivia>(ServerFailure()),
        );

        return numberTriviaBloc;
      },
      act: (NumberTriviaBloc bloc) => bloc.add(GetTriviaForRandomNumber()),
      expect: () => <dynamic>[
        NumberTriviaLoading(),
        const NumberTriviaFailure(message: serverFailureMessage),
      ],
    );
    blocTest<NumberTriviaBloc, NumberTriviaState>(
      '''
      SHOULD emit [NumberTriviaLoading, NumberTriviaFailure] with a proper message
      WHEN getting data
      IS NOT successful
      ''',
      build: () {
        when(mockGetRandomNumberTrivia(any)).thenAnswer(
          (_) async => Left<CacheFailure, NumberTrivia>(CacheFailure()),
        );
        return numberTriviaBloc;
      },
      act: (NumberTriviaBloc bloc) => bloc.add(GetTriviaForRandomNumber()),
      expect: () => <dynamic>[
        NumberTriviaLoading(),
        const NumberTriviaFailure(message: cacheFailureMessage),
      ],
    );
  });
}
