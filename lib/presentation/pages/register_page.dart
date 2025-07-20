import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/presentation/blocs/register_bloc/register_bloc.dart';
import 'package:shartflix/presentation/blocs/register_bloc/register_event.dart';
import 'package:shartflix/presentation/blocs/register_bloc/register_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kayıt Ol")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is RegisterSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Kayıt başarılı ✅")),
              );
              Navigator.pop(context); // Giriş sayfasına geri dön
            } else if (state is RegisterFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Ad Soyad"),
                ),
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
                  onPressed: state is RegisterLoading
                      ? null
                      : () {
                    context.read<RegisterBloc>().add(
                      RegisterButtonPressed(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                        fullName: nameController.text.trim(),
                      ),
                    );
                  },
                  child: state is RegisterLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Kayıt Ol"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
