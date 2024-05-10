import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tdd_clean_architecture_course/core/error/exceptions.dart';
import 'package:tdd_clean_architecture_course/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:tdd_clean_architecture_course/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';

import 'number_trivia_local_data_source_test.mocks.dart';

@GenerateNiceMocks(<MockSpec<SharedPreferences>>[MockSpec<SharedPreferences>()])
void main() {
  late MockSharedPreferences mockSharedPreferences;
  late NumberTriviaLocalDataSourceImpl dataSource;
  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = NumberTriviaLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });
  group('getLastNumberTrivia', () {
    final NumberTriviaModel tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia_cached.json')));
    test(
      '''
      SHOULD return NumberTrivia from SharePreferences when there is one in the cache
      ''',
      () async {
        // Arrange
        when(mockSharedPreferences.getString(any))
            .thenReturn(fixture('trivia_cached.json'));
        // Act
        final NumberTriviaModel result = await dataSource.getLastNumberTrivia();
        // Assert
        verify(mockSharedPreferences.getString(cachedNumberTrivia));
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      'SHOULD throw a CacheException when there is not a cached value',
      () async {
        // Arrange
        when(mockSharedPreferences.getString(any)).thenReturn(null);
        // Act
        final Future<NumberTriviaModel> Function() call =
            dataSource.getLastNumberTrivia;
        // Assert
        expect(call, throwsA(isA<CacheException>()));
      },
    );

    group('cacheNumberTrivia', () {
      const NumberTriviaModel tNumberTriviaModel =
          NumberTriviaModel(text: 'test trivia', number: 1);
      test(
        'SHOULD call SharedPreferences to cache the data',
        () async {
          // Act
          await dataSource.cacheNumberTrivia(tNumberTriviaModel);
          // Assert
          final String expectedJsonString =
              json.encode(tNumberTriviaModel.toJson());
          verify(
            mockSharedPreferences.setString(
              cachedNumberTrivia,
              expectedJsonString,
            ),
          );
        },
      );
    });
  });
}
