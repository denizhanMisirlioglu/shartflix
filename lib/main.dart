import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/presentation/blocs/popular_movies_bloc/movie_bloc.dart';
import 'injection_container.dart' as di;

import 'presentation/blocs/login_bloc/login_bloc.dart';
import 'presentation/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (_) => di.sl<LoginBloc>(),
        ),
        BlocProvider<MovieBloc>(
          create: (_) => di.sl<MovieBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Shartflix',
        debugShowCheckedModeBanner: false,
        home: const LoginPage(),
      ),
    );
  }
}
