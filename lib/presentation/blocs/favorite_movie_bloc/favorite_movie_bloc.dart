import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/use_cases/get_favorite_movies.dart';
import '../../../domain/use_cases/toggle_favorite_movie.dart';
import 'favorite_movie_event.dart';
import 'favorite_movie_state.dart';

class FavoriteMovieBloc extends Bloc<FavoriteMovieEvent, FavoriteMovieState> {
  final GetFavoriteMoviesUseCase getFavorites;
  final ToggleFavoriteMovieUseCase toggleFavorite;

  FavoriteMovieBloc({
    required this.getFavorites,
    required this.toggleFavorite,
  }) : super(FavoriteMovieInitial()) {
    on<LoadFavoriteMovies>(_onLoadFavorites);
    on<ToggleFavoriteMovie>(_onToggleFavorite);
  }

  Future<void> _onLoadFavorites(
      LoadFavoriteMovies event,
      Emitter<FavoriteMovieState> emit,
      ) async {
    emit(FavoriteMovieLoading());
    try {
      final movies = await getFavorites(event.token);
      print(" Bloc: LoadFavoriteMovies → ${movies.length} favori film bulundu");
      emit(FavoriteMovieLoaded(movies));
    } catch (e) {
      print(" Bloc: Favori listeleme hatası: $e");
      emit(FavoriteMovieError(e.toString()));
    }
  }

  Future<void> _onToggleFavorite(
      ToggleFavoriteMovie event,
      Emitter<FavoriteMovieState> emit,
      ) async {
    print(" Bloc: ToggleFavoriteMovie event alındı → movieId: ${event.movieId}");

    try {
      await toggleFavorite(event.token, event.movieId);
      print(" Bloc: Favori API çağrısı tamamlandı");

      add(LoadFavoriteMovies(event.token));
      print(" Bloc: Favori listesi tekrar yükleniyor");
    } catch (e) {
      print(" Bloc: Favori işlemi hatası: $e");
      emit(FavoriteMovieError(e.toString()));
    }
  }
}
