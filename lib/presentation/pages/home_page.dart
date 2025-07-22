import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../injection_container.dart';
import '../blocs/popular_movies_bloc/movie_bloc.dart';
import '../blocs/popular_movies_bloc/movie_event.dart';
import '../blocs/popular_movies_bloc/movie_state.dart';
import '../blocs/favorite_movie_bloc/favorite_movie_bloc.dart';
import '../blocs/favorite_movie_bloc/favorite_movie_event.dart';
import '../blocs/favorite_movie_bloc/favorite_movie_state.dart';
import '../widgets/movie_card.dart';

class HomePage extends StatelessWidget {
  final String token;

  const HomePage({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieBloc>(
          create: (_) => sl<MovieBloc>()..add(FetchMovies(token: token)),
        ),
        BlocProvider<FavoriteMovieBloc>(
          create: (_) => sl<FavoriteMovieBloc>()..add(LoadFavoriteMovies(token)),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ana Sayfa'),
        ),
        body: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, movieState) {
            if (movieState is MovieLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (movieState is MovieLoaded) {
              return BlocBuilder<FavoriteMovieBloc, FavoriteMovieState>(
                builder: (context, favState) {
                  final favoriteIds = favState is FavoriteMovieLoaded
                      ? favState.favoriteMovieIds
                      : <String>{};

                  print("🔍 HomePage: Favori ID’ler: $favoriteIds");

                  return ListView.builder(
                    itemCount: movieState.movies.length,
                    itemBuilder: (context, index) {
                      final movie = movieState.movies[index];
                      final isFavorite = favoriteIds.contains(movie.id);

                      print("🎬 Film ID: ${movie.id} → isFavorite: $isFavorite");

                      return MovieCard(
                        title: movie.title,
                        description: movie.description,
                        posterUrl: movie.posterUrl,
                        isFavorite: isFavorite,
                        onFavoriteToggle: () {
                          print("🟢 HomePage: Favori toggle çağrıldı: ${movie.id}");
                          context.read<FavoriteMovieBloc>().add(
                            ToggleFavoriteMovie(token, movie.id),
                          );
                        },
                      );
                    },
                  );
                },
              );
            } else if (movieState is MovieError) {
              return Center(child: Text(movieState.message));
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
