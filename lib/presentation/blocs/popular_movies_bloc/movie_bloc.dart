import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/use_cases/get_movies.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovies getMovies;

  MovieBloc(this.getMovies) : super(MovieInitial()) {
    on<FetchMovies>((event, emit) async {
      print('🚀 FetchMovies called → page: ${event.page}');
      emit(MovieLoading());

      final result = await getMovies(page: event.page, token: event.token);

      result.fold(
            (failure) {
          print('❌ FetchMovies failed: $failure');
          emit(MovieError("Failed to load movies"));
        },
            (moviePageResult) {
          print('✅ FetchMovies success → currentPage: ${moviePageResult.currentPage}, totalPages: ${moviePageResult.totalPages}, movies: ${moviePageResult.movies.length}');
          emit(MovieLoaded(
            movies: moviePageResult.movies,
            currentPage: moviePageResult.currentPage,
            totalPages: moviePageResult.totalPages,
          ));
        },
      );
    });

    on<FetchMoreMovies>((event, emit) async {
      print('🔄 FetchMoreMovies called');

      if (state is! MovieLoaded) {
        print('⚠️ FetchMoreMovies skipped - state is not MovieLoaded');
        return;
      }

      final currentState = state as MovieLoaded;

      if (!currentState.canLoadMore) {
        print('⛔ No more pages to load → currentPage: ${currentState.currentPage}, totalPages: ${currentState.totalPages}');
        return;
      }

      final nextPage = currentState.currentPage + 1;
      print('📤 Fetching next page: $nextPage');

      final result = await getMovies(page: nextPage, token: event.token);

      result.fold(
            (failure) {
          print('❌ FetchMoreMovies failed: $failure');
          emit(MovieError("Failed to load more movies"));
        },
            (moviePageResult) {
          print('✅ FetchMoreMovies success → new page: ${moviePageResult.currentPage}, movies added: ${moviePageResult.movies.length}');
          emit(MovieLoaded(
            movies: [...currentState.movies, ...moviePageResult.movies],
            currentPage: moviePageResult.currentPage,
            totalPages: moviePageResult.totalPages,
          ));
        },
      );
    });
  }
}
