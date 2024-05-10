import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:tdd_clean_architecture_course/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:tdd_clean_architecture_course/features/number_trivia/domain/entities/number_trivia.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const NumberTriviaModel tNumberTriviaModel =
      NumberTriviaModel(number: 1, text: 'Test text');
  test(
    'SHOULD be a subclass of NumberTrivia entity',
    () async {
      // Assert
      expect(tNumberTriviaModel, isA<NumberTrivia>());
    },
  );
  group('fromJson', () {
    test(
      'SHOULD return a valid model when the JSON number is an integer',
      () async {
        // Arrange
   final Map<String, dynamic> jsonMap =
            json.decode(fixture('trivia.json'));
        // Act
   final NumberTriviaModel result = NumberTriviaModel.fromJson(jsonMap);
        // Assert
        expect(result, tNumberTriviaModel);
      },
    );
    test(
      'SHOULD return a valid model when the JSON number is an double',
      () async {
        // Arrange
   final Map<String, dynamic> jsonMap =
            json.decode(fixture('trivia_double.json'));
        // Act
   final NumberTriviaModel result = NumberTriviaModel.fromJson(jsonMap);
        // Assert
        expect(result, tNumberTriviaModel);
      },
    );
  });
  group('toJson', () {
    test(
      'SHOULD return a JSON map containing the proper data',
      () async {
        // Act
   final Map<String, dynamic> result = tNumberTriviaModel.toJson();
        // Assert
   final Map<String, Object> expectedMap = <String, Object>{
          'text': 'Test text',
          'number': 1,
        };
        expect(result, expectedMap);
      },
    );
  });
}
