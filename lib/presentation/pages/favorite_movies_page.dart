import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/favorite_movie_entity.dart';
import '../../../injection_container.dart';
import '../blocs/favorite_movie_bloc/favorite_movie_bloc.dart';
import '../blocs/favorite_movie_bloc/favorite_movie_event.dart';
import '../blocs/favorite_movie_bloc/favorite_movie_state.dart';

class FavoriteMoviesPage extends StatelessWidget {
  final String token;
  const FavoriteMoviesPage({Key? key, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<FavoriteMovieBloc>()..add(LoadFavoriteMovies(token)),
      child: Scaffold(
        appBar: AppBar(title: const Text('Favori Filmler')),
        body: BlocBuilder<FavoriteMovieBloc, FavoriteMovieState>(
          builder: (context, state) {
            if (state is FavoriteMovieLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FavoriteMovieLoaded) {
              return ListView.builder(
                itemCount: state.movies.length,
                itemBuilder: (context, index) {
                  final movie = state.movies[index];
                  return _FavoriteMovieItem(
                    movie: movie,
                    token: token,
                  );
                },
              );
            } else if (state is FavoriteMovieError) {
              return Center(child: Text('Hata: ${state.message}'));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}

class _FavoriteMovieItem extends StatelessWidget {
  final FavoriteMovieEntity movie;
  final String token;

  const _FavoriteMovieItem({
    required this.movie,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        movie.posterUrl,
        width: 60,
        errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
      ),
      title: Text(movie.title),
      trailing: IconButton(
        icon: const Icon(Icons.favorite, color: Colors.red),
        onPressed: () {
          context.read<FavoriteMovieBloc>().add(
            ToggleFavoriteMovie(token, movie.id),
          );
        },
      ),
    );
  }
}
