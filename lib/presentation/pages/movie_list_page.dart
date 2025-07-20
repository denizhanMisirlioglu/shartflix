import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection_container.dart';
import '../blocs/popular_movies_bloc/movie_bloc.dart';
import '../blocs/popular_movies_bloc/movie_event.dart';
import '../blocs/popular_movies_bloc/movie_state.dart';
import '../widgets/movie_card.dart';

class MovieListPage extends StatelessWidget {
  final String token;

  const MovieListPage({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MovieBloc>()..add(FetchMovies(token: token)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Filmler'),
        ),
        body: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state is MovieLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MovieLoaded) {
              final movies = state.movies;
              return ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return MovieCard(
                    title: movie.title,
                    releaseDate: movie.releaseDate,
                    posterUrl: movie.posterUrl, // ✅
                  );

                },
              );
            } else if (state is MovieError) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox(); // boş state fallback
            }
          },
        ),
      ),
    );
  }
}
