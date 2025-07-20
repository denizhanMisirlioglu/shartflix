import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:shartflix/presentation/blocs/login_bloc/login_state.dart';
import 'package:shartflix/presentation/pages/register_page.dart';

import '../../injection_container.dart';
import '../blocs/login_bloc/login_evet.dart';
import '../blocs/register_bloc/register_bloc.dart';
import 'movie_list_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController(text: "kullanici@example.com");
  final passwordController = TextEditingController(text: "123456");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login Test")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              final token = state.token;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => MovieListPage(token: token),
                ),
              );
            }
            else if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Hata: ${state.message}")),
              );
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: "Email"),
                ),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: "Şifre"),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: state is LoginLoading
                      ? null
                      : () {
                    context.read<LoginBloc>().add(
                      LoginButtonPressed(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      ),
                    );
                  },
                  child: state is LoginLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Giriş Yap"),
                ),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider(
                          create: (_) => sl<RegisterBloc>(),
                          child: const RegisterPage(),
                        ),
                      ),
                    );
                  },
                  child: const Text("Hesabın yok mu? Kayıt ol"),
                ),

              ],
            );
          },
        ),
      ),
    );
  }
}
