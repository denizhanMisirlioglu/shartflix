import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shartflix/presentation/pages/profile_page.dart';

import '../../data/data_sources/movie_remote_data_source.dart';
import '../../data/repositories/movie_repository_impl.dart';
import '../../domain/use_cases/get_movies.dart';
import '../../presentation/blocs/popular_movies_bloc/movie_bloc.dart';

import '../../data/data_sources/favorite_movie_remote_data_source.dart';
import '../../data/repositories/favorite_movie_reposityory_impl.dart';
import '../../domain/use_cases/get_favorite_movies.dart';
import '../../domain/use_cases/toggle_favorite_movie.dart';
import '../../presentation/blocs/favorite_movie_bloc/favorite_movie_bloc.dart';
import '../../presentation/blocs/favorite_movie_bloc/favorite_movie_event.dart';

import 'home_page.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../../constants/colors.dart';

class MainNavigationPage extends StatefulWidget {
  final String token;
  const MainNavigationPage({super.key, required this.token});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTap(int index) {
    setState(() => _currentIndex = index);
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    final movieRepository = MovieRepositoryImpl(
      remoteDataSource: MovieRemoteDataSourceImpl(client: http.Client()),
    );

    final favoriteRepository = FavoriteMovieRepositoryImpl(
      remoteDataSource: FavoriteMovieRemoteDataSourceImpl(client: http.Client()),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieBloc>(
          create: (_) => MovieBloc(
            GetMovies(movieRepository),
          ),
        ),
        BlocProvider<FavoriteMovieBloc>(
          create: (_) => FavoriteMovieBloc(
            getFavorites: GetFavoriteMoviesUseCase(favoriteRepository),
            toggleFavorite: ToggleFavoriteMovieUseCase(favoriteRepository),
          )..add(LoadFavoriteMovies(widget.token)),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              HomePage(token: widget.token),
              ProfilePage(
                token: widget.token,
                onBackToHome: () => _onTap(0),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: _currentIndex,
          onTap: _onTap,
        ),
      ),
    );
  }
}
