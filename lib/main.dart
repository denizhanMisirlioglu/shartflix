import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shartflix/presentation/pages/login_page.dart';
import 'injection_container.dart' as di;
import 'presentation/blocs/login_bloc/login_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // final String? initialToken;
  const MyApp({super.key});

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
        locale: const Locale('tr'), // Varsayılanı Türkçe olarak belirledik
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: const LoginPage(),
      ),
    );
  }
}
