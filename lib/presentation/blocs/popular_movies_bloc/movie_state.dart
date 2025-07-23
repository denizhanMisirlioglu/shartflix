import 'package:equatable/equatable.dart';
import '../../../domain/entities/movie_entity.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<MovieEntity> movies;
  final int currentPage;
  final int totalPages;

  const MovieLoaded({
    required this.movies,
    required this.currentPage,
    required this.totalPages,
  });

  bool get canLoadMore => currentPage < totalPages;

  @override
  List<Object> get props => [movies, currentPage, totalPages];
}

class MovieError extends MovieState {
  final String message;

  const MovieError(this.message);

  @override
  List<Object> get props => [message];
}
