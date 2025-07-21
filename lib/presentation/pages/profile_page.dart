import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user_profile_entity.dart';
import '../blocs/user_profile_bloc/user_profile_bloc.dart';
import '../blocs/user_profile_bloc/user_profile_event.dart';
import '../blocs/user_profile_bloc/user_profile_state.dart';

class ProfilePage extends StatelessWidget {
  final String token;

  const ProfilePage({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserProfileBloc(context.read())..add(FetchUserProfile(token)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profil Detayı'),
        ),
        body: BlocBuilder<UserProfileBloc, UserProfileState>(
          builder: (context, state) {
            if (state is UserProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserProfileError) {
              return Center(child: Text("Hata: ${state.message}"));
            } else if (state is UserProfileLoaded) {
              final UserProfileEntity user = state.profile;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: user.photoUrl.isNotEmpty
                          ? NetworkImage(user.photoUrl)
                          : const AssetImage('assets/images/default_avatar.png') as ImageProvider,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      user.name,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '@${user.id}',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 12),
                    const Text(
                      'Beğendiğiniz Filmler',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 6, // Bloc üzerinden alınacaksa daha sonra bağlarız
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Center(child: Text('Film')),
                        );
                      },
                    )
                  ],
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
