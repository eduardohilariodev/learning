import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/repositories/number_trivia_repository.dart';
import '../datasources/number_trivia_local_data_source.dart';
import '../datasources/number_trivia_remote_data_source.dart';
import '../models/number_trivia_model.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  NumberTriviaRepositoryImpl({
    required this.localDataSource,
    required this.networkInfo,
    required this.remoteDataSource,
  });

  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  final NumberTriviaRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
    int? number,
  ) =>
      _getTrivia(
        () => remoteDataSource.getConcreteNumberTrivia(number!),
      );

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() =>
      _getTrivia(remoteDataSource.getRandomNumberTrivia);

  Future<Either<Failure, NumberTrivia>> _getTrivia(
    Future<NumberTriviaModel> Function() getConcreteOrRandom,
  ) async {
    if (await networkInfo.isConnected) {
      try {
   final NumberTriviaModel remoteTrivia = await getConcreteOrRandom();
        await localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right<Failure, NumberTriviaModel>(remoteTrivia);
      } on ServerException {
        return Left<Failure, NumberTriviaModel>(ServerFailure());
      }
    } else {
      try {
   final NumberTriviaModel localTrivia =
            await localDataSource.getLastNumberTrivia();
        return Right<Failure, NumberTriviaModel>(localTrivia);
      } on CacheException {
        return Left<Failure, NumberTriviaModel>(CacheFailure());
      }
    }
  }
}
