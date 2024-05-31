import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:tdd_clean_architecture_course/core/network/network_info.dart';

import 'network_info_test.mocks.dart';

@GenerateNiceMocks(<MockSpec<InternetConnectionChecker>>[
  MockSpec<InternetConnectionChecker>(),
])
void main() {
  late MockInternetConnectionChecker mockInternetConnectionChecker;
  late NetworkInfoImpl networkInfo;

  setUp(() async {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImpl(mockInternetConnectionChecker);
  });

  group('isConnected', () {
    test(
      'SHOULD forward the call to InternetConnectionChecker.hasConnection',
      () async {
        // Arrange
        final Future<bool> tHasConnectionFuture = Future<bool>.value(true);
        when(mockInternetConnectionChecker.hasConnection)
            .thenAnswer((_) => tHasConnectionFuture);
        // Act
        final Future<bool> result = networkInfo.isConnected;
        // Assert
        verify(mockInternetConnectionChecker.hasConnection);
        expect(result, tHasConnectionFuture);
      },
    );
  });
}
