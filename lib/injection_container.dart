import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shartflix/presentation/blocs/upload_photo_bloc/upload_photo_bloc.dart';

import 'core/utils/token_storage.dart';

// AUTH (Login/Register)
import 'data/data_sources/auth_remote_data_source.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/use_cases/login_user.dart';
import 'domain/use_cases/register_user.dart';
import 'domain/use_cases/upload_photo.dart';
import 'presentation/blocs/login_bloc/login_bloc.dart';
import 'presentation/blocs/register_bloc/register_bloc.dart';

// MOVIES
import 'data/data_sources/movie_remote_data_source.dart';
import 'data/repositories/movie_repository_impl.dart';
import 'domain/repositories/movie_repository.dart';
import 'domain/use_cases/get_movies.dart';
import 'presentation/blocs/popular_movies_bloc/movie_bloc.dart';

// FAVORITES
import 'data/data_sources/favorite_movie_remote_data_source.dart';
import 'data/repositories/favorite_movie_reposityory_impl.dart';
import 'domain/repositories/favorite_movie_repository.dart';
import 'domain/use_cases/get_favorite_movies.dart';
import 'domain/use_cases/toggle_favorite_movie.dart';
import 'presentation/blocs/favorite_movie_bloc/favorite_movie_bloc.dart';

// PROFILE
import 'data/data_sources/user_remote_data_source.dart';
import 'data/repositories/user_repository_impl.dart';
import 'domain/repositories/user_repository.dart';
import 'domain/use_cases/get_user_profile.dart';
import 'presentation/blocs/user_profile_bloc/user_profile_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Blocs
  sl.registerFactory(() => MovieBloc(sl()));
  sl.registerFactory(() => LoginBloc(
    loginUser: sl(),
    tokenStorage: sl(),
  ));
  sl.registerFactory(() => RegisterBloc(registerUser: sl()));
  sl.registerFactory(() => FavoriteMovieBloc(
    getFavorites: sl(),
    toggleFavorite: sl(),
  ));
  sl.registerFactory(() => UserProfileBloc(sl()));
  sl.registerFactory(() => UploadPhotoBloc(sl()));

  // UseCases
  sl.registerLazySingleton(() => GetMovies(sl()));
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => RegisterUser(sl()));
  sl.registerLazySingleton(() => GetFavoriteMoviesUseCase(sl<FavoriteMovieRepository>()));
  sl.registerLazySingleton(() => ToggleFavoriteMovieUseCase(sl<FavoriteMovieRepository>()));
  sl.registerLazySingleton(() => GetUserProfile(sl()));

  // Repositories
  sl.registerLazySingleton<MovieRepository>(
          () => MovieRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<AuthRepository>(
          () => AuthRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<FavoriteMovieRepository>(
          () => FavoriteMovieRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<UserRepository>(
          () => UserRepositoryImpl(remoteDataSource: sl()));

  // DataSources
  sl.registerLazySingleton<MovieRemoteDataSource>(
          () => MovieRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<AuthRemoteDataSource>(
          () => AuthRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<FavoriteMovieRemoteDataSource>(
          () => FavoriteMovieRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<UserRemoteDataSource>(
          () => UserRemoteDataSourceImpl(client: sl()));

  // Core
  sl.registerLazySingleton(() => TokenStorage());

  // External
  sl.registerLazySingleton(() => http.Client());

  sl.registerLazySingleton(() => UploadPhoto(sl()));
}
