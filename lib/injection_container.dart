import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shartflix/domain/use_cases/get_movies.dart';
import 'package:shartflix/presentation/blocs/popular_movies_bloc/movie_bloc.dart';
import 'package:shartflix/presentation/blocs/register_bloc/register_bloc.dart';

import 'core/utils/token_storage.dart';

// Auth (Login & Register)
import 'data/data_sources/auth_remote_data_source.dart';
import 'data/data_sources/favorite_movie_remote_data_source.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'data/repositories/favorite_movie_reposityory_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/use_cases/get_favorite_movies.dart';
import 'domain/use_cases/login_user.dart';
import 'domain/use_cases/register_user.dart';
import 'domain/use_cases/toggle_favorite_movie.dart';
import 'presentation/blocs/login_bloc/login_bloc.dart';

// Movies
import 'data/data_sources/movie_remote_data_source.dart';
import 'data/repositories/movie_repository_impl.dart';
import 'domain/repositories/movie_repository.dart';

// 🔥 Favorite Feature (Yeni)
import 'domain/repositories/favorite_movie_repository.dart';
import 'presentation/blocs/favorite_movie_bloc/favorite_movie_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //  Bloc
  sl.registerFactory(() => MovieBloc(sl()));
  sl.registerFactory(() => LoginBloc(
    loginUser: sl(),
    tokenStorage: sl(),
  ));
  sl.registerFactory(() => RegisterBloc(registerUser: sl()));

  // ⭐️ FavoriteMovieBloc
  sl.registerFactory(() => FavoriteMovieBloc(
    getFavorites: sl(),
    toggleFavorite: sl(),
  ));

  // ⚙ UseCases
  sl.registerLazySingleton(() => GetMovies(sl()));
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => RegisterUser(sl()));

  // ⭐️ FavoriteMovie UseCases
  sl.registerLazySingleton(() => GetFavoriteMoviesUseCase(sl()));
  sl.registerLazySingleton(() => ToggleFavoriteMovieUseCase(sl()));

  //  Repositories
  sl.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(remoteDataSource: sl()));

  // ⭐️ FavoriteMovie Repository
  sl.registerLazySingleton<FavoriteMovieRepository>(
        () => FavoriteMovieRepositoryImpl(remoteDataSource: sl()),
  );

  //  DataSources
  sl.registerLazySingleton<MovieRemoteDataSource>(() => MovieRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(client: sl()));

  // ⭐️ FavoriteMovie DataSource
  sl.registerLazySingleton<FavoriteMovieRemoteDataSource>(
        () => FavoriteMovieRemoteDataSourceImpl(client: sl()),
  );

  //  Core
  sl.registerLazySingleton(() => TokenStorage());

  //  External
  sl.registerLazySingleton(() => http.Client());
}
