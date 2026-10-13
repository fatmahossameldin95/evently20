import 'package:evently/common/widgets/custom_main_button.dart';
import 'package:evently/presentation/auth/login/forgot_password.dart';
import 'package:evently/presentation/auth/register/register_screen.dart';
import 'package:evently/common/app_text_styles.dart';
import 'package:evently/common/widgets/custom_text_form_field.dart';
import 'package:evently/gen/assets.gen.dart';
import 'package:evently/models/user_model.dart';
import 'package:evently/presentation/home/home_screen.dart';
import 'package:evently/services/firebase_auth_service.dart';
import 'package:evently/common/theme/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = "/loginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool isGoogleLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formState,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                spacing: 8,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Assets.images.logo.path, width: 136, height: 186),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Login to your account",
                        style: AppTextStyles.styleS22W600(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  CustomTextFormField(
                    controller: emailController,
                    label: "Enter your Email", //TODO:localization
                    prefixIcon: Assets.icons.emailIcon,
                    validator: (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return "email is required!!"; //TODO:localization
                      }
                    },
                  ),
                  CustomTextFormField(
                    controller: passwordController,
                    label: "Enter your password", //TODO:localization
                    prefixIcon: Assets.icons.passwordIcon,
                    isPassword: true,
                    validator: (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return "password is required!!"; //TODO:localization
                      } else if (p0.length < 4) {
                        return "password must be atleast 6 characters";
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(
                            context,
                          ).pushNamed(ForgotPassword.routeName);
                        },
                        child: Text(
                          "Forget Password?",
                          style:
                              AppTextStyles.styleS16W700(
                                color: Theme.of(context).colorScheme.primary,
                              ).copyWith(
                                decoration: TextDecoration.underline,

                                decorationColor: Theme.of(
                                  context,
                                ).colorScheme.primary,
                              ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 24),
                    width: double.infinity,
                    height: 56,
                  ),
                  CustomMainButton(
                    isLoading: isLoading,
                    label: "login",
                    onPressed: () async {
                      bool isValid = _formState.currentState!.validate();
                      if (isValid) {
                        UserModel user = UserModel(
                          email: emailController.text.trim(),
                          password: passwordController.text,
                        );
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          UserModel? userData = await FirebaseAuthService.login(
                            user,
                          );

                          if (userData != null) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "success,you are logged in!",
                                    style: AppTextStyles.styleS16W600(
                                      color: Colors.white,
                                    ),
                                  ),
                                  backgroundColor: Theme.of(
                                    context,
                                  ).colorScheme.primary.withValues(alpha: .6),
                                ),
                              );
                              Navigator.of(
                                context,
                              ).pushReplacementNamed(HomeScreen.routeName);
                            }
                          }
                        } on String catch (errorMessage) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  errorMessage,
                                  style: AppTextStyles.styleS16W600(
                                    color: Colors.white,
                                  ),
                                ),
                                backgroundColor: AppColors.errorColor,
                              ),
                            );
                          }
                        }
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                  ), //Don’t Have Account ? Create Account
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: "Don’t Have Account ? "),
                        TextSpan(
                          text: "Create Account",
                          style: Theme.of(context).textTheme.titleSmall!
                              .copyWith(
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.primary,
                                decoration: TextDecoration.underline,
                                decorationColor: Theme.of(
                                  context,
                                ).colorScheme.primary,
                              ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(
                                context,
                              ).pushNamed(RegisterScreen.routeName);
                            },
                          //TODO:ontap
                        ),
                      ],
                      style: Theme.of(
                        context,
                      ).textTheme.titleSmall!.copyWith(fontSize: 16),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Row(
                      spacing: 16,
                      children: [
                        Expanded(
                          child: Divider(color: Theme.of(context).dividerColor),
                        ),
                        Text(
                          "OR",
                          style: AppTextStyles.styleS16W500(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        Expanded(
                          child: Divider(color: Theme.of(context).dividerColor),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: OutlinedButton.icon(
                      icon: isGoogleLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Image.asset(
                              Assets.icons.google.path,
                              width: 25,
                              height: 25,
                            ),
                      onPressed: isGoogleLoading ? null : _loginWithGoogle,
                      label: Text(
                        isGoogleLoading
                            ? "Please wait..."
                            : "Login With Google",

                        style: AppTextStyles.styleS20W500(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        backgroundColor: Theme.of(context).splashColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _loginWithGoogle() async {
    setState(() {
      isGoogleLoading = true;
    });

    try {
      final userCredential = await FirebaseAuthService.loginWithGoogle();

      if (!mounted) return;

      if (userCredential != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Successfully logged in with Google!')),
        );

        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      }
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'Google login failed.'),
          backgroundColor: AppColors.errorColor,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Google login failed: $e'),
          backgroundColor: AppColors.errorColor,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isGoogleLoading = false;
        });
      }
    }
  }
}
