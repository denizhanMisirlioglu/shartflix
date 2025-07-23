import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/constants/app_padding.dart';
import 'package:shartflix/constants/colors.dart';
import 'package:shartflix/constants/text_styles.dart';
import 'package:shartflix/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:shartflix/presentation/blocs/login_bloc/login_state.dart';
import 'package:shartflix/presentation/pages/main_navigation_page.dart';
import 'package:shartflix/presentation/pages/register_page.dart';
import '../../injection_container.dart';
import '../blocs/login_bloc/login_evet.dart';
import '../blocs/register_bloc/register_bloc.dart';
import '../widgets/auth/custom_input_field.dart';
import '../widgets/auth/social_icon_group.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppPadding.horizontal),
                    child: BlocConsumer<LoginBloc, LoginState>(
                      listener: (context, state) {
                        if (state is LoginSuccess) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MainNavigationPage(token: state.token),
                            ),
                          );
                        } else if (state is LoginFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Hata: ${state.message}")),
                          );
                        }
                      },
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 100),
                            Text("Merhabalar", style: AppTextStyles.heading, textAlign: TextAlign.center),
                            const SizedBox(height: 8),
                            Text(
                              "Tempus varius a vitae interdum id\ntortor elementum tristique eleifend at.",
                              style: AppTextStyles.subtitle,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 40),
                            CustomInputField(
                              controller: emailController,
                              icon: Icons.email,
                              hintText: "E-Posta",
                            ),
                            const SizedBox(height: 13.63),
                            CustomInputField(
                              controller: passwordController,
                              icon: Icons.lock,
                              hintText: "Şifre",
                              obscureText: isPasswordHidden,
                              suffixIcon: isPasswordHidden ? Icons.visibility_off : Icons.visibility,
                              onSuffixTap: () {
                                setState(() {
                                  isPasswordHidden = !isPasswordHidden;
                                });
                              },
                            ),
                            const SizedBox(height: 29.63),
                            Align(
                              alignment: Alignment.centerLeft,
                              child:Text(
                                "Şifremi unuttum",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.white,
                                  decorationThickness: 1,
                                  height: 1.4, //  en kritik değer
                                ),
                              ),

                            ),
                            const SizedBox(height: 36.92),
                            SizedBox(
                              height: AppPadding.buttonHeight,
                              child: ElevatedButton(
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
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.brandRed,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(AppPadding.inputRadius),
                                  ),
                                ),
                                child: state is LoginLoading
                                    ? const CircularProgressIndicator(color: Colors.white)
                                    : Text("Giriş Yap", style: AppTextStyles.buttonText),
                              ),
                            ),
                            const SizedBox(height: 36.92),
                            const SocialIconGroup(),
                            const SizedBox(height: 39),
                            Center(
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Text("Bir hesabın yok mu? ", style: AppTextStyles.registerText),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4), // 🔧 boşluk eklendi
                                    child: GestureDetector(
                                      onTap: () { /* yönlendirme */ },
                                      child: Text("Kayıt Ol!", style: AppTextStyles.registerBold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 39),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
