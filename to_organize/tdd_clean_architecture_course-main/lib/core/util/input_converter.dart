import 'package:dartz/dartz.dart';

import '../error/failures.dart';

/// This will "shield" the domain layer from the influence of input convertion
/// As the `model` is a `data` layer class, the `input_converter`
/// is a `presentation`
/// layer class.
class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String str) {
    try {
 final int integer = int.parse(str);
      if (integer < 0) {
        throw const FormatException();
      }
      return Right<Failure, int>(int.parse(str));
    } on FormatException {
      return Left<Failure, int>(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}
