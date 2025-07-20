import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shartflix/domain/use_cases/get_movies.dart';
import 'package:shartflix/presentation/blocs/popular_movies_bloc/movie_bloc.dart';
import 'package:shartflix/presentation/blocs/register_bloc/register_bloc.dart';

import 'core/utils/token_storage.dart';

// Auth (Login & Register)
import 'data/data_sources/auth_remote_data_source.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/use_cases/login_user.dart';
import 'domain/use_cases/register_user.dart';
import 'presentation/blocs/login_bloc/login_bloc.dart';

// Movies
import 'data/data_sources/movie_remote_data_source.dart';
import 'data/repositories/movie_repository_impl.dart';
import 'domain/repositories/movie_repository.dart';


final sl = GetIt.instance;

Future<void> init() async {
  //  Bloc
  sl.registerFactory(() => MovieBloc(sl()));
  sl.registerFactory(() => LoginBloc(
    loginUser: sl(),
    tokenStorage: sl(),
  ));
  sl.registerFactory(() => RegisterBloc(registerUser: sl()));

  // ⚙ UseCases
  sl.registerLazySingleton(() => GetMovies(sl()));
  sl.registerLazySingleton(() => LoginUser(sl())); //
  sl.registerLazySingleton(() => RegisterUser(sl()));


  //  Repositories
  sl.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(remoteDataSource: sl()));

  //  DataSources
  sl.registerLazySingleton<MovieRemoteDataSource>(() => MovieRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(client: sl()));

  //  Core
  sl.registerLazySingleton(() => TokenStorage());

  //  External
  sl.registerLazySingleton(() => http.Client());
}
