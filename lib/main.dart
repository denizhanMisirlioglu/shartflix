import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/core/utils/token_storage.dart';
import 'package:shartflix/presentation/pages/login_page.dart';
import 'package:shartflix/presentation/pages/main_navigation_page.dart';

import 'injection_container.dart' as di;
import 'presentation/blocs/login_bloc/login_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await di.init();


  // final tokenStorage = di.sl<TokenStorage>();
  // final token = await tokenStorage.getToken();
  // runApp(MyApp(initialToken: token));

  runApp(const MyApp()); // 🧪 Şimdilik sadece LoginPage gösteriyoruz
}

class MyApp extends StatelessWidget {
  // final String? initialToken;
  const MyApp({super.key}); // → Giriş ekranı test modu

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (_) => di.sl<LoginBloc>(),
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
