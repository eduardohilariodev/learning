import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tdd_clean_architecture_course/core/error/failures.dart';
import 'package:tdd_clean_architecture_course/core/util/input_converter.dart';

void main() {
  late InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('setringToUnsignedInt', () {
    test(
      'SHOULD return an integer when the string represents an unsigned integer',
      () async {
        // Arrange
        const String str = '123';
        // Act
        final Either<Failure, int> result =
            inputConverter.stringToUnsignedInteger(str);
        // Assert
        expect(result, const Right<dynamic, int>(123));
      },
    );

    test(
      'SHOULD return a Failure when the string is not an integer',
      () async {
        // Arrange
        const String str = 'abc';
        // Act
        final Either<Failure, int> result =
            inputConverter.stringToUnsignedInteger(str);
        // Assert
        expect(
          result,
          Left<InvalidInputFailure, dynamic>(InvalidInputFailure()),
        );
      },
    );

    test(
      'SHOULD return a Failure when the string is a negative integer',
      () async {
        // Arrange
        const String str = '-123';
        // Act
        final Either<Failure, int> result =
            inputConverter.stringToUnsignedInteger(str);
        // Assert
        expect(
          result,
          Left<InvalidInputFailure, dynamic>(InvalidInputFailure()),
        );
      },
    );
  });
}
