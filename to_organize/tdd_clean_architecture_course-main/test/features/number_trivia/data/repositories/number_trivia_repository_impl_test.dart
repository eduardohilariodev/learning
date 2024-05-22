import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:tdd_clean_architecture_course/core/error/exceptions.dart';
import 'package:tdd_clean_architecture_course/core/error/failures.dart';
import 'package:tdd_clean_architecture_course/core/network/network_info.dart';
import 'package:tdd_clean_architecture_course/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:tdd_clean_architecture_course/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:tdd_clean_architecture_course/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:tdd_clean_architecture_course/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:tdd_clean_architecture_course/features/number_trivia/domain/entities/number_trivia.dart';

import 'number_trivia_repository_impl_test.mocks.dart';

@GenerateNiceMocks(<MockSpec<NetworkInfo>>[MockSpec<NetworkInfo>()])
@GenerateNiceMocks(<MockSpec<NumberTriviaRemoteDataSource>>[
  MockSpec<NumberTriviaRemoteDataSource>(),
])
@GenerateNiceMocks(<MockSpec<NumberTriviaLocalDataSource>>[
  MockSpec<NumberTriviaLocalDataSource>(),
])
void main() {
  late NumberTriviaRepositoryImpl repository;
  late MockNumberTriviaRemoteDataSource mockRemoteDataSource;
  late MockNumberTriviaLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockNumberTriviaRemoteDataSource();
    mockLocalDataSource = MockNumberTriviaLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = NumberTriviaRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() async {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() async {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group('getConcreteNumberTrivia', () {
    const int tNumber = 1;
    const NumberTriviaModel tNumberTriviaModel =
        NumberTriviaModel(number: tNumber, text: 'test trivia');
    const NumberTrivia tNumberTrivia = tNumberTriviaModel;
    test(
      '''
      SHOULD check
      IF the device
      IS online
      ''',
      () async {
        // Arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // Act
        await repository.getConcreteNumberTrivia(tNumber);
        // Assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        '''
        SHOULD return [remote data]
        WHEN the call to [RemoteDataSource]
        IS successful
        ''',
        () async {
          // Arrange
          when(mockRemoteDataSource.getConcreteNumberTrivia(any)).thenAnswer(
            (Invocation realInvocation) async => tNumberTriviaModel,
          );
          // Act
          final Either<Failure, NumberTrivia> result =
              await repository.getConcreteNumberTrivia(tNumber);
          // Assert
          verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
          expect(
            result,
            equals(const Right<dynamic, NumberTrivia>(tNumberTrivia)),
          );
        },
      );

      test(
        '''
        SHOULD cache locally when the call to remote data 
        source is successful
        ''',
        () async {
          // Arrange
          when(mockRemoteDataSource.getConcreteNumberTrivia(any)).thenAnswer(
            (Invocation realInvocation) async => tNumberTriviaModel,
          );
          // Act
          await repository.getConcreteNumberTrivia(tNumber);
          // Assert
          verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
          verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
        },
      );

      test(
        '''
        SHOULD return server failure when the call to 
        remote data source is unsuccessful
        ''',
        () async {
          // Arrange
          when(mockRemoteDataSource.getConcreteNumberTrivia(any))
              .thenThrow(ServerException());
          // Act
          final Either<Failure, NumberTrivia> result =
              await repository.getConcreteNumberTrivia(tNumber);
          // Assert
          verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Left<Failure, NumberTrivia>(ServerFailure())));
        },
      );
    });
    runTestsOffline(() {
      test(
        '''
        SHOULD return last locally cached data when 
        the cached data is present
        ''',
        () async {
          // Arrange
          when(mockLocalDataSource.getLastNumberTrivia()).thenAnswer(
            (Invocation realInvocation) async => tNumberTriviaModel,
          );
          // Act
          final Either<Failure, NumberTrivia> result =
              await repository.getConcreteNumberTrivia(tNumber);
          // Assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastNumberTrivia());
          expect(result, const Right<Failure, NumberTrivia>(tNumberTrivia));
        },
      );

      test(
        'SHOULD return CacheFailure when there is no cached data present',
        () async {
          // Arrange
          when(mockLocalDataSource.getLastNumberTrivia())
              .thenThrow(CacheException());
          // Act
          final Either<Failure, NumberTrivia> result =
              await repository.getConcreteNumberTrivia(tNumber);
          // Assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastNumberTrivia());
          expect(result, equals(Left<CacheFailure, dynamic>(CacheFailure())));
        },
      );
    });
  });
  group('getRandomNumberTrivia', () {
    const NumberTriviaModel tNumberTriviaModel =
        NumberTriviaModel(number: 123, text: 'test trivia');
    const NumberTrivia tNumberTrivia = tNumberTriviaModel;
    test(
      'SHOULD check if the device is online',
      () async {
        // Arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // Act
        await repository.getRandomNumberTrivia();
        // Assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        '''
        SHOULD return remote data
        WHEN the call to remote data source
        IS successful
        ''',
        () async {
          // Arrange
          when(mockRemoteDataSource.getRandomNumberTrivia()).thenAnswer(
            (Invocation realInvocation) async => tNumberTriviaModel,
          );
          // Act
          final Either<Failure, NumberTrivia> result =
              await repository.getRandomNumberTrivia();
          // Assert
          verify(mockRemoteDataSource.getRandomNumberTrivia());
          expect(
            result,
            equals(const Right<Failure, NumberTrivia>(tNumberTrivia)),
          );
        },
      );

      test(
        '''
        SHOULD cache random number trivia locally
        WHEN the call to remote data source
        IS successful
        ''',
        () async {
          // Arrange
          when(mockRemoteDataSource.getRandomNumberTrivia()).thenAnswer(
            (Invocation realInvocation) async => tNumberTriviaModel,
          );
          // Act
          await repository.getRandomNumberTrivia();
          // Assert
          verify(mockRemoteDataSource.getRandomNumberTrivia());
          verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
        },
      );

      test(
        '''
        SHOULD return server failure
        WHEN the call to remote data source
        IS NOT successful
        ''',
        () async {
          // Arrange
          when(mockRemoteDataSource.getRandomNumberTrivia())
              .thenThrow(ServerException());
          // Act
          final Either<Failure, NumberTrivia> result =
              await repository.getRandomNumberTrivia();
          // Assert
          verify(mockRemoteDataSource.getRandomNumberTrivia());
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Left<Failure, NumberTrivia>(ServerFailure())));
        },
      );
    });
    runTestsOffline(() {
      test(
        '''
        SHOULD return last locally cached data
        when the cached data
        is present
        ''',
        () async {
          // Arrange
          when(mockLocalDataSource.getLastNumberTrivia()).thenAnswer(
            (Invocation realInvocation) async => tNumberTriviaModel,
          );
          // Act
          final Either<Failure, NumberTrivia> result =
              await repository.getRandomNumberTrivia();
          // Assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastNumberTrivia());
          expect(result, const Right<Failure, NumberTrivia>(tNumberTrivia));
        },
      );

      test(
        '''
        SHOULD return CacheFailure
        WHEN cached data
        IN NOT present
        ''',
        () async {
          // Arrange
          when(mockLocalDataSource.getLastNumberTrivia())
              .thenThrow(CacheException());
          // Act
          final Either<Failure, NumberTrivia> result =
              await repository.getRandomNumberTrivia();
          // Assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastNumberTrivia());
          expect(result, equals(Left<CacheFailure, dynamic>(CacheFailure())));
        },
      );
    });
  });
}
