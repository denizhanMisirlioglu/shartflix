import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection_container.dart';
import '../blocs/popular_movies_bloc/movie_bloc.dart';
import '../blocs/popular_movies_bloc/movie_event.dart';
import '../blocs/popular_movies_bloc/movie_state.dart';
import '../widgets/movie_card.dart';

class HomePage extends StatelessWidget {
  final String token;

  const HomePage({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieBloc>(
      create: (_) => sl<MovieBloc>()..add(FetchMovies(token: token)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ana Sayfa'),
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
                    posterUrl: movie.posterUrl,
                  );
                },
              );
            } else if (state is MovieError) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
