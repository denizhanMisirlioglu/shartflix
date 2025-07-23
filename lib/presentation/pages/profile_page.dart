// ⬇️ Güncellenmiş ProfilePage (Figma ile birebir uyumlu + Bottom Sheet entegrasyonu)

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection_container.dart';
import '../blocs/user_profile_bloc/user_profile_bloc.dart';
import '../blocs/user_profile_bloc/user_profile_event.dart';
import '../blocs/user_profile_bloc/user_profile_state.dart';
import '../blocs/favorite_movie_bloc/favorite_movie_bloc.dart';
import '../blocs/favorite_movie_bloc/favorite_movie_event.dart';
import '../blocs/favorite_movie_bloc/favorite_movie_state.dart';
import '../blocs/upload_photo_bloc/upload_photo_bloc.dart';
import '../pages/upload_photo_page.dart';
import '../widgets/favorite_movie_card.dart';
import '../widgets/limited_offer/limited_offer_bottom_sheet.dart';

class ProfilePage extends StatelessWidget {
  final String token;
  final VoidCallback? onBackToHome;

  const ProfilePage({
    super.key,
    required this.token,
    this.onBackToHome,
  });

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
        backgroundColor: const Color.fromRGBO(9, 9, 9, 1),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (onBackToHome != null) {
                              onBackToHome!();
                            }
                          },
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color.fromRGBO(255, 255, 255, 0.1),
                              border: Border.all(color: const Color.fromRGBO(255, 255, 255, 0.2)),
                            ),
                            child: const Icon(Icons.arrow_back, color: Colors.white),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (_) => const LimitedOfferBottomSheet(),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE50914),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.local_offer, size: 16, color: Colors.white),
                                SizedBox(width: 4),
                                Text(
                                  'Sınırlı Teklif',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const Text(
                      'Profil Detayı',
                      style: TextStyle(
                        fontFamily: 'EuclidCircularA',
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                BlocBuilder<UserProfileBloc, UserProfileState>(
                  builder: (context, state) {
                    if (state is UserProfileLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is UserProfileLoaded) {
                      final user = state.profile;
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 31,
                            backgroundImage: NetworkImage(user.photoUrl),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 9.56),
                              Text(
                                user.name,
                                style: const TextStyle(
                                  fontFamily: 'EuclidCircularA',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'ID: ${user.id.substring(0, 6)}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color.fromRGBO(255, 255, 255, 0.5),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider(
                                    create: (_) => sl<UploadPhotoBloc>(),
                                    child: UploadPhotoPage(token: token),
                                  ),
                                ),
                              );
                              if (!context.mounted) return;
                              if (result == true) {
                                context.read<UserProfileBloc>().add(FetchUserProfile(token));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE50914),
                              padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              minimumSize: const Size(121, 36),
                            ),
                            child: const Text(
                              'Fotoğraf Ekle',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
                const SizedBox(height: 10),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Beğendiğim Filmler',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'EuclidCircularA',
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
                BlocBuilder<FavoriteMovieBloc, FavoriteMovieState>(
                  builder: (context, state) {
                    if (state is FavoriteMovieLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is FavoriteMovieError) {
                      return Center(child: Text('Hata: ${state.message}', style: TextStyle(color: Colors.white)));
                    } else if (state is FavoriteMovieLoaded) {
                      final movies = state.movies;
                      if (movies.isEmpty) {
                        return const Center(
                          child: Text("Henüz favori film yok.", style: TextStyle(color: Colors.white)),
                        );
                      }
                      return GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15.66,
                        mainAxisSpacing: 25,
                        childAspectRatio: 153.13 / 213.82,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: movies.map((movie) {
                          return FavoriteMovieCard(
                            imageUrl: movie.posterUrl,
                            title: movie.title,
                          );
                        }).toList(),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
