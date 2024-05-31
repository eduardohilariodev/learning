import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:tdd_clean_architecture_course/core/error/exceptions.dart';
import 'package:tdd_clean_architecture_course/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:tdd_clean_architecture_course/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';

import 'number_trivia_remote_data_source_test.mocks.dart';

@GenerateNiceMocks(<MockSpec<http.Client>>[MockSpec<http.Client>()])
void main() {
  late MockClient mockHttpClient;
  late NumberTriviaRemoteDataSource dataSource;
  setUp(() {
    mockHttpClient = MockClient();
    dataSource = NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (Invocation realInvocation) async =>
          http.Response(fixture('trivia.json'), 200),
    );
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (Invocation realInvocation) async =>
          http.Response('Something went wrong', 404),
    );
  }

  group('getConcreteNumberTrivia', () {
    const int tNumber = 1;
    final NumberTriviaModel tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test(
      '''
SHOULD perform a GET request on a URL with number
         being the endpoint and with application/json''',
      () async {
        // Arrange
        when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (Invocation realInvocation) async =>
              http.Response(fixture('trivia.json'), 200),
        );
        // Act
        await dataSource.getConcreteNumberTrivia(tNumber);
        // Assert
        verify(
          mockHttpClient.get(
            Uri.parse('http://numbersapi.com/$tNumber'),
            headers: <String, String>{'Content-Type': 'application/json'},
          ),
        );
      },
    );

    test(
      'SHOULD return NumberTrivia when the response code is 200',
      () async {
        // Arrange
        setUpMockHttpClientSuccess200();
        // Act
        final NumberTriviaModel result =
            await dataSource.getConcreteNumberTrivia(tNumber);
        // Assert
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      'SHOULD throw a ServerException when the response code is 404 or other',
      () async {
        // Arrange
        setUpMockHttpClientFailure404();
        // Act
        final Future<NumberTriviaModel> Function(int number) call =
            dataSource.getConcreteNumberTrivia;
        // Assert
        expect(
          () => call(tNumber),
          throwsA(isA<ServerException>()),
        );
      },
    );
  });

  group('getRandomNumberTrivia', () {
    final NumberTriviaModel tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test(
      '''
SHOULD perform a GET request on a URL with number
         being the endpoint and with application/json''',
      () async {
        // Arrange
        when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (Invocation realInvocation) async =>
              http.Response(fixture('trivia.json'), 200),
        );
        // Act
        await dataSource.getRandomNumberTrivia();
        // Assert
        verify(
          mockHttpClient.get(
            Uri.parse('http://numbersapi.com/random'),
            headers: <String, String>{'Content-Type': 'application/json'},
          ),
        );
      },
    );

    test(
      'SHOULD return NumberTrivia when the response code is 200',
      () async {
        // Arrange
        setUpMockHttpClientSuccess200();
        // Act
        final NumberTriviaModel result =
            await dataSource.getRandomNumberTrivia();
        // Assert
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      'SHOULD throw a ServerException when the response code is 404 or other',
      () async {
        // Arrange
        setUpMockHttpClientFailure404();
        // Act
        final Future<NumberTriviaModel> Function() call =
            dataSource.getRandomNumberTrivia;
        // Assert

        expect(
          call,
          throwsA(isA<ServerException>()),
        );
      },
    );
  });
}
