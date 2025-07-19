import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Bloc
  // sl.registerFactory(() => YourBloc());

  //! Usecases
  // sl.registerLazySingleton(() => YourUseCase());

  //! Repository
  // sl.registerLazySingleton<YourRepository>(() => YourRepositoryImpl());

  //! Data sources
  // sl.registerLazySingleton<YourRemoteDataSource>(() => YourRemoteDataSourceImpl());

  //! External
  // sl.registerLazySingleton(() => http.Client());
}
