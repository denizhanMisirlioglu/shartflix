import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;
import 'presentation/pages/popular_movies_page.dart';
import 'presentation/blocs/popular_movies_bloc/popular_movies_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shartflix',
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => di.sl<PopularMoviesBloc>(),
        child: const PopularMoviesPage(),
      ),
    );
  }
}
