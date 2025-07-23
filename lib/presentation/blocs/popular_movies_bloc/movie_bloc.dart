import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/use_cases/get_movies.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovies getMovies;

  MovieBloc(this.getMovies) : super(MovieInitial()) {
    on<FetchMovies>((event, emit) async {
      emit(MovieLoading());

      final result = await getMovies(page: event.page, token: event.token);

      result.fold(
            (failure) => emit(MovieError("Failed to load movies")),
            (moviePageResult) => emit(MovieLoaded(
          movies: moviePageResult.movies,
          currentPage: moviePageResult.currentPage,
          totalPages: moviePageResult.totalPages,
        )),
      );
    });

    on<FetchMoreMovies>((event, emit) async {
      if (state is! MovieLoaded) return;

      final currentState = state as MovieLoaded;

      if (!currentState.canLoadMore) return;

      final nextPage = currentState.currentPage + 1;

      final result = await getMovies(page: nextPage, token: event.token);

      result.fold(
            (failure) => emit(MovieError("Failed to load more movies")),
            (moviePageResult) => emit(MovieLoaded(
          movies: [...currentState.movies, ...moviePageResult.movies],
          currentPage: moviePageResult.currentPage,
          totalPages: moviePageResult.totalPages,
        )),
      );
    });
  }
}
