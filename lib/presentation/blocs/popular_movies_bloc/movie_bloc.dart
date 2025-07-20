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
            (movies) => emit(MovieLoaded(movies)),
      );
    });
  }
}
