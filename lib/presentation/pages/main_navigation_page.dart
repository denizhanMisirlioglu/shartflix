import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../data/data_sources/movie_remote_data_source.dart';
import '../../data/repositories/movie_repository_impl.dart';
import '../../domain/use_cases/get_movies.dart';
import '../blocs/popular_movies_bloc/movie_bloc.dart';
import 'home_page.dart';
import 'profile_page.dart';
import '../widgets/custom_bottom_nav_bar.dart';

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
    return BlocProvider(
      create: (_) => MovieBloc(
        GetMovies(
          MovieRepositoryImpl(
            remoteDataSource: MovieRemoteDataSourceImpl(client: http.Client()),
          ),
        ),
      ),
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            HomePage(token: widget.token),
            ProfilePage(token: widget.token),
          ],
        ),
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: _currentIndex,
          onTap: _onTap,
        ),
      ),
    );
  }
}
