import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shartflix/constants/colors.dart';
import '../blocs/popular_movies_bloc/movie_bloc.dart';
import '../blocs/popular_movies_bloc/movie_event.dart';
import '../blocs/popular_movies_bloc/movie_state.dart';
import '../blocs/favorite_movie_bloc/favorite_movie_bloc.dart';
import '../blocs/favorite_movie_bloc/favorite_movie_event.dart';
import '../blocs/favorite_movie_bloc/favorite_movie_state.dart';
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
      context.read<MovieBloc>().add(FetchMovies(token: widget.token));
      context.read<FavoriteMovieBloc>().add(LoadFavoriteMovies(widget.token));
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.black, // Koyu arka plan
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, movieState) {
          return BlocBuilder<FavoriteMovieBloc, FavoriteMovieState>(
            builder: (context, favoriteState) {
              if (movieState is MovieLoading) {
                return Container(
                  color: Colors.black, // Yükleme sırasında da koyu arka plan
                  child: const Center(child: CircularProgressIndicator()),
                );
              } else if (movieState is MovieLoaded) {
                final movies = movieState.movies;
                final canLoadMore = movieState.canLoadMore;

                List<String> favoriteIds = [];
                if (favoriteState is FavoriteMovieLoaded) {
                  favoriteIds = favoriteState.movies.map((m) => m.id).toList();
                }

                return RefreshIndicator(
                  color: AppColors.white, // istersen loader rengini de ayarla
                  backgroundColor: AppColors.backgroundDark, // istersen loader arka planı
                  onRefresh: () async {
                    context.read<MovieBloc>().add(FetchMovies(token: widget.token));
                    context.read<FavoriteMovieBloc>().add(LoadFavoriteMovies(widget.token));
                  },
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (scrollInfo) {
                      if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent && canLoadMore) {
                        context.read<MovieBloc>().add(FetchMoreMovies(token: widget.token));
                      }
                      return false;
                    },
                    child: PageView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: canLoadMore ? movies.length + 1 : movies.length,
                      itemBuilder: (context, index) {
                        if (index >= movies.length) {
                          return Container(
                            color: Colors.black, // Yükleme sırasında da koyu arka plan
                            child: const Center(child: CircularProgressIndicator()),
                          );
                        }

                        final movie = movies[index];
                        final isFavorite = favoriteIds.contains(movie.id);

                        return MovieCard(
                          title: movie.title,
                          description: movie.description,
                          posterUrl: movie.posterUrl,
                          isFavorite: isFavorite,
                          onFavoriteToggle: () {
                            context.read<FavoriteMovieBloc>().add(
                              ToggleFavoriteMovie(widget.token, movie.id),
                            );
                          },
                        );
                      },
                    ),
                  ),
                );
              } else if (movieState is MovieError) {
                return Container(
                  color: Colors.black, // Hata ekranı da koyu
                  child: Center(
                    child: Text(
                      '${loc.movieLoadError}\n${movieState.message}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          );
        },
      ),
    );
  }
}
