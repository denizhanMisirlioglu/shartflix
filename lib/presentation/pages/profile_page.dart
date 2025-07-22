import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection_container.dart';
import '../blocs/user_profile_bloc/user_profile_bloc.dart';
import '../blocs/user_profile_bloc/user_profile_event.dart';
import '../blocs/user_profile_bloc/user_profile_state.dart';
import '../blocs/favorite_movie_bloc/favorite_movie_bloc.dart';
import '../blocs/favorite_movie_bloc/favorite_movie_event.dart';
import '../blocs/favorite_movie_bloc/favorite_movie_state.dart';
import '../widgets/compact_favorite_card.dart';

class ProfilePage extends StatelessWidget {
  final String token;

  const ProfilePage({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserProfileBloc>(
          create: (_) => sl<UserProfileBloc>()..add(FetchUserProfile(token)),
        ),
        BlocProvider<FavoriteMovieBloc>(
          create: (_) => sl<FavoriteMovieBloc>()..add(LoadFavoriteMovies(token)),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profil'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<UserProfileBloc, UserProfileState>(
              builder: (context, state) {
                if (state is UserProfileLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is UserProfileLoaded) {
                  final user = state.profile;
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.photoUrl),
                      radius: 24,
                    ),
                    title: Text(user.name),
                    subtitle: Text('ID: ${user.id}'),
                  );
                } else if (state is UserProfileError) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text('Hata: ${state.message}'),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Favori Filmler',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: BlocBuilder<FavoriteMovieBloc, FavoriteMovieState>(
                builder: (context, state) {
                  if (state is FavoriteMovieLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is FavoriteMovieError) {
                    return Center(child: Text('Hata: ${state.message}'));
                  } else if (state is FavoriteMovieLoaded) {
                    final movies = state.movies;
                    if (movies.isEmpty) {
                      return const Center(child: Text("Henüz favori film yok."));
                    }
                    return ListView.builder(
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: CompactFavoriteCard(
                            title: movie.title,
                            posterUrl: movie.posterUrl,
                            onFavoriteToggle: () {
                              context.read<FavoriteMovieBloc>().add(
                                ToggleFavoriteMovie(token, movie.id),
                              );
                            },
                          ),
                        );
                      },
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
