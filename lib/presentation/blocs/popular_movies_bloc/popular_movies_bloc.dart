import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/use_cases/get_popular_movies.dart';
import 'popular_movies_event.dart';
import 'popular_movies_state.dart';
import '../../../core/error/failure.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies getPopularMovies;

  PopularMoviesBloc(this.getPopularMovies) : super(PopularMoviesInitial()) {
    on<FetchPopularMovies>((event, emit) async {
      emit(PopularMoviesLoading());

      final result = await getPopularMovies();

      result.fold(
            (failure) => emit(PopularMoviesError(_mapFailureToMessage(failure))),
            (movies) => emit(PopularMoviesLoaded(movies)),
      );
    });
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.message;
  }
}
