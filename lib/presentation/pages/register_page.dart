import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:shartflix/constants/app_padding.dart';
import 'package:shartflix/constants/colors.dart';
import 'package:shartflix/constants/text_styles.dart';
import 'package:shartflix/presentation/blocs/register_bloc/register_bloc.dart';
import 'package:shartflix/presentation/blocs/register_bloc/register_event.dart';
import 'package:shartflix/presentation/blocs/register_bloc/register_state.dart';
import 'package:shartflix/presentation/pages/login_page.dart';
import '../widgets/auth/custom_input_field.dart';
import '../widgets/auth/social_icon_group.dart';
import '../widgets/auth/form_header.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;
  bool registerButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    fullNameController.addListener(_updateButtonState);
    emailController.addListener(_updateButtonState);
    passwordController.addListener(_updateButtonState);
    confirmPasswordController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    final isEnabled = fullNameController.text.trim().isNotEmpty &&
        emailController.text.trim().isNotEmpty &&
        passwordController.text.trim().isNotEmpty &&
        confirmPasswordController.text.trim().isNotEmpty;

    if (registerButtonEnabled != isEnabled) {
      setState(() {
        registerButtonEnabled = isEnabled;
      });
    }
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    child: BlocConsumer<RegisterBloc, RegisterState>(
                      listener: (context, state) {
                        if (state is RegisterSuccess) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => Dialog(
                              backgroundColor: Colors.transparent,
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: Lottie.asset(
                                  'assets/lottie/success.json',
                                  repeat: false,
                                  fit: BoxFit.contain,
                                  onLoaded: (composition) {
                                    Future.delayed(composition.duration, () {
                                      Navigator.of(context).pop();
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (_) => const LoginPage()),
                                      );
                                    });
                                  },
                                ),
                              ),
                            ),
                          );
                        } else if (state is RegisterFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Hata: ${state.message}")),
                          );
                        }
                      },
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 60),
                            const FormHeader(
                              title: "Hoşgeldiniz",
                              subtitle: "Tempus varius a vitae interdum id tortor\n"
                                  "elementum tristique eleifend at.",
                            ),
                            const SizedBox(height: 36),
                            CustomInputField(
                              controller: fullNameController,
                              icon: Icons.person,
                              hintText: "Ad Soyad",
                            ),
                            const SizedBox(height: 13.63),
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
                            const SizedBox(height: 13.63),
                            CustomInputField(
                              controller: confirmPasswordController,
                              icon: Icons.lock,
                              hintText: "Şifre Tekrar",
                              obscureText: isConfirmPasswordHidden,
                              suffixIcon: isConfirmPasswordHidden ? Icons.visibility_off : Icons.visibility,
                              onSuffixTap: () {
                                setState(() {
                                  isConfirmPasswordHidden = !isConfirmPasswordHidden;
                                });
                              },
                            ),
                            const SizedBox(height: 20),
                            RichText(
                              text: TextSpan(
                                text: "Kullanıcı sözleşmesini ",
                                style: AppTextStyles.registerText,
                                children: const [
                                  TextSpan(
                                    text: "okudum ve kabul ediyorum.",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " Bu sözleşmeyi okuyarak devam ediniz lütfen.",
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              height: AppPadding.buttonHeight,
                              child: ElevatedButton(
                                onPressed: registerButtonEnabled
                                    ? () {
                                  final password = passwordController.text.trim();
                                  final confirmPassword = confirmPasswordController.text.trim();

                                  if (password != confirmPassword) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Şifreler eşleşmiyor"),
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                    return;
                                  }

                                  context.read<RegisterBloc>().add(
                                    RegisterButtonPressed(
                                      fullName: fullNameController.text.trim(),
                                      email: emailController.text.trim(),
                                      password: password,
                                    ),
                                  );
                                }
                                    : () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Lütfen tüm alanları doldurun."),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.brandRed,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(AppPadding.inputRadius),
                                  ),
                                ),
                                child: state is RegisterLoading
                                    ? const CircularProgressIndicator(color: Colors.white)
                                    : Text("Şimdi Kaydol", style: AppTextStyles.buttonText),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const SocialIconGroup(),
                            const SizedBox(height: 39),
                            Center(
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Text("Zaten bir hesabın var mı? ", style: AppTextStyles.registerText),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (_) => const LoginPage()),
                                        );
                                      },
                                      child: Text("Giriş Yap!", style: AppTextStyles.registerBold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
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
