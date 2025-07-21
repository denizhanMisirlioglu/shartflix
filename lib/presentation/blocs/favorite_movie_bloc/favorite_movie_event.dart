import 'package:equatable/equatable.dart';

abstract class FavoriteMovieEvent extends Equatable {
  const FavoriteMovieEvent();

  @override
  List<Object> get props => [];
}

class LoadFavoriteMovies extends FavoriteMovieEvent {
  final String token;

  const LoadFavoriteMovies(this.token);

  @override
  List<Object> get props => [token];
}

class ToggleFavoriteMovie extends FavoriteMovieEvent {
  final String token;
  final String movieId;

  const ToggleFavoriteMovie(this.token, this.movieId);

  @override
  List<Object> get props => [token, movieId];
}
