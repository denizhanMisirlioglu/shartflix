import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class FetchMovies extends MovieEvent {
  final int page;
  final String token;

  const FetchMovies({this.page = 1, required this.token});

  @override
  List<Object> get props => [page, token];
}
