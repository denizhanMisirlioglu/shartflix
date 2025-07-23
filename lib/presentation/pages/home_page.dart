import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/popular_movies_bloc/movie_bloc.dart';
import '../blocs/popular_movies_bloc/movie_event.dart';
import '../blocs/popular_movies_bloc/movie_state.dart';
import '../widgets/movie_card.dart';

class HomePage extends StatefulWidget {
  final String token;

  const HomePage({super.key, required this.token});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("🚀 FetchMovies (initial) çağrıldı");
      context.read<MovieBloc>().add(FetchMovies(token: widget.token));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MovieLoaded) {
            final movies = state.movies;
            final canLoadMore = state.canLoadMore;

            return RefreshIndicator(
              onRefresh: () async {
                print("🔄 Pull-to-refresh tetiklendi");
                context.read<MovieBloc>().add(FetchMovies(token: widget.token));
              },
              child: NotificationListener<ScrollNotification>(
                onNotification: (scrollInfo) {
                  if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent && canLoadMore) {
                    print("📦 Scroll max'a ulaşıldı, FetchMoreMovies çağrıldı");
                    context.read<MovieBloc>().add(FetchMoreMovies(token: widget.token));
                  }
                  return false;
                },
                child: PageView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: canLoadMore ? movies.length + 1 : movies.length,
                  itemBuilder: (context, index) {
                    if (index >= movies.length) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final movie = movies[index];
                    print("🎬 Film #$index: ${movie.title} - ${movie.posterUrl}");
                    return MovieCard(
                      title: movie.title,
                      description: movie.description,
                      posterUrl: movie.posterUrl,
                      isFavorite: false,
                      onFavoriteToggle: () {},
                    );
                  },
                ),
              ),
            );
          } else if (state is MovieError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
