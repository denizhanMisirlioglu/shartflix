import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shartflix/constants/app_padding.dart';
import 'package:shartflix/constants/colors.dart';
import 'package:shartflix/constants/text_styles.dart';
import 'package:shartflix/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:shartflix/presentation/blocs/login_bloc/login_state.dart';
import 'package:shartflix/presentation/pages/main_navigation_page.dart';
import 'package:shartflix/presentation/pages/register_page.dart';
import '../../injection_container.dart';
import '../blocs/login_bloc/login_event.dart';
import '../blocs/register_bloc/register_bloc.dart';
import '../widgets/auth/custom_input_field.dart';
import '../widgets/auth/social_icon_group.dart';
import '../widgets/auth/form_header.dart';

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
  void initState() {
    super.initState();
    emailController.addListener(() => setState(() {}));
    passwordController.addListener(() => setState(() {}));
  }

  bool get _isLoginButtonEnabled {
    return emailController.text.trim().isNotEmpty &&
        passwordController.text.trim().isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

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
                                      if (context.mounted) {
                                        Navigator.of(context).pop();
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => MainNavigationPage(token: state.token),
                                          ),
                                        );
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                          );
                        } else if (state is LoginFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(loc.loginWrongCredentialsError),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 100),
                            FormHeader(
                              title: loc.loginTitle,
                              subtitle: loc.loginSubtitle,
                            ),
                            const SizedBox(height: 40),
                            CustomInputField(
                              controller: emailController,
                              icon: Icons.email,
                              hintText: loc.emailHint,
                            ),
                            const SizedBox(height: 13.63),
                            CustomInputField(
                              controller: passwordController,
                              icon: Icons.lock,
                              hintText: loc.passwordHint,
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
                              child: Text(
                                loc.forgotPassword,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.white,
                                  decorationThickness: 1,
                                  height: 1.4,
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
                                  final email = emailController.text.trim();
                                  final password = passwordController.text.trim();

                                  if (email.isEmpty || password.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(loc.loginFieldsEmptyError),
                                        backgroundColor: Colors.redAccent,
                                      ),
                                    );
                                    return;
                                  }

                                  context.read<LoginBloc>().add(
                                    LoginButtonPressed(
                                      email: email,
                                      password: password,
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.brandRed,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(AppPadding.inputRadius),
                                  ),
                                ),
                                child: state is LoginLoading
                                    ? const CircularProgressIndicator(color: Colors.white)
                                    : Text(loc.loginButton, style: AppTextStyles.buttonText),
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
                                  Text(loc.noAccountText, style: AppTextStyles.registerText),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: GestureDetector(
                                      onTap: () {
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
                                      child: Text(loc.registerNow, style: AppTextStyles.registerBold),
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
