import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/popular_movies_bloc/popular_movies_bloc.dart';
import '../blocs/popular_movies_bloc/popular_movies_event.dart';
import '../blocs/popular_movies_bloc/popular_movies_state.dart';

class PopularMoviesPage extends StatefulWidget {
  const PopularMoviesPage({Key? key}) : super(key: key);

  @override
  State<PopularMoviesPage> createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    context.read<PopularMoviesBloc>().add(FetchPopularMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Popüler Filmler')),
      body: BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
        builder: (context, state) {
          if (state is PopularMoviesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PopularMoviesLoaded) {
            return ListView.builder(
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                final movie = state.movies[index];
                return ListTile(
                  leading: Image.network(
                    'https://image.tmdb.org/t/p/w185${movie.posterPath}',
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(movie.title),
                  subtitle: Text(movie.releaseDate),
                );
              },
            );
          } else if (state is PopularMoviesError) {
            return Center(child: Text('Hata: ${state.message}'));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
