import 'package:equatable/equatable.dart';
import '../../../domain/entities/favorite_movie_entity.dart';

abstract class FavoriteMovieState extends Equatable {
  const FavoriteMovieState();

  @override
  List<Object> get props => [];
}

class FavoriteMovieInitial extends FavoriteMovieState {}

class FavoriteMovieLoading extends FavoriteMovieState {}

class FavoriteMovieLoaded extends FavoriteMovieState {
  final List<FavoriteMovieEntity> movies;

  const FavoriteMovieLoaded(this.movies);


  Set<String> get favoriteMovieIds => movies.map((e) => e.id).toSet();

  @override
  List<Object> get props => [movies];
}

class FavoriteMovieError extends FavoriteMovieState {
  final String message;

  const FavoriteMovieError(this.message);

  @override
  List<Object> get props => [message];
}
