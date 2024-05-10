import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'core/util/input_converter.dart';
import 'features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

// sl = Service Locator
final GetIt sl = GetIt.instance;

Future<void> init() async {
  // Features

  // Bloc
  /// The diference between a [factory] and a [singleton] is that a factory
  /// creates a new instance of the type every time it is called, while
  /// a singleton creates a new instance only the first time it is called
  /// and returns the same instance for subsequent calls (from its cache).
  ///
  /// For Blocs, they are very close to the presentation layer, so we want
  /// to create a new instance of the Bloc every time it is called, because of
  /// streams, state changes and so on.
  ///
  /// Classes requiring cleanup (such as Blocs), shouldn't be registered as
  /// singletons.
  sl
    ..registerFactory(
      () => NumberTriviaBloc(
        /// `sl()` is a shorthand for `sl.call()`, it infers the type
        /// and returns the registered instance of the type automatically.
        getConcreteNumberTrivia: sl(),
        getRandomNumberTrivia: sl(),
        inputConverter: sl(),
      ),
    )

    // Use cases
    /// The diference between a lazy and non-lazy singleton is that a lazy
    /// singleton creates a new instance of the type only when it is
    /// requrest by a depency, while a non-lazy singleton creates
    /// a new instance when the application starts.

    ..registerLazySingleton(() => GetConcreteNumberTrivia(sl()))
    ..registerLazySingleton(() => GetRandomNumberTrivia(sl()))

    // Repository
    ..registerLazySingleton<NumberTriviaRepository>(
      () => NumberTriviaRepositoryImpl(
        localDataSource: sl(),
        networkInfo: sl(),
        remoteDataSource: sl(),
      ),
    )

    // Data sources
    ..registerLazySingleton<NumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSourceImpl(client: sl()),
    )
    ..registerLazySingleton<NumberTriviaLocalDataSource>(
      () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()),
    )

    // Core
    ..registerLazySingleton(InputConverter.new)
    ..registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl
    ..registerLazySingleton(() => sharedPreferences)
    ..registerLazySingleton(http.Client.new)
    ..registerLazySingleton(InternetConnectionChecker.new);
}
