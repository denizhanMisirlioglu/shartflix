import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/entities/movie_entity.dart';
import '../blocs/popular_movies_bloc/movie_bloc.dart';
import '../blocs/popular_movies_bloc/movie_event.dart';
import '../blocs/popular_movies_bloc/movie_state.dart';


class MovieListPage extends StatefulWidget {
  const MovieListPage({Key? key}) : super(key: key);

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  @override
  void initState() {
    super.initState();
    _loadTokenAndFetchMovies();
  }

  void _loadTokenAndFetchMovies() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');

    if (!mounted) return;

    if (token != null) {
      context.read<MovieBloc>().add(FetchMovies(token: token));
    } else {
      debugPrint("❌ Token bulunamadı.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filmler"),
      ),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MovieLoaded) {
            return ListView.builder(
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                final MovieEntity movie = state.movies[index];
                return ListTile(
                  leading: Image.network(movie.posterUrl),
                  title: Text(movie.title),
                  subtitle: Text(movie.description),
                );
              },
            );
          } else if (state is MovieError) {
            return Center(child: Text('Hata: ${state.message}'));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
