import 'package:evently/common/app_text_styles.dart';
import 'package:evently/common/widgets/custom_text_form_field.dart';
import 'package:evently/gen/assets.gen.dart';
import 'package:evently/models/user_model.dart';
import 'package:evently/presentation/auth/login/login_screen.dart';
import 'package:evently/services/firebase_auth_service.dart';
import 'package:evently/common/theme/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String routeName = "/registerScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")), //TODO:localization
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formState,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Assets.images.logo.path, width: 136, height: 186),
                  CustomTextFormField(
                    controller: nameController,
                    label: "Name", //TODO:localization
                    prefixIcon: Assets.icons.nameIcon,
                    validator: (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return "name is required!!"; //TODO:localization
                      }
                    },
                  ),
                  CustomTextFormField(
                    controller: emailController,
                    label: "Email", //TODO:localization
                    prefixIcon: Assets.icons.emailIcon,
                    validator: (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return "email is required!!"; //TODO:localization
                      }
                    },
                  ),
                  CustomTextFormField(
                    controller: passwordController,
                    label: "Password", //TODO:localization
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
                  CustomTextFormField(
                    controller: rePasswordController,
                    label: "Re Password", //TODO:localization
                    prefixIcon: Assets.icons.passwordIcon,
                    isPassword: true,
                    validator: (p0) {
                      if (p0 != passwordController.text) {
                        return "password doesnot match";
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {},
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
                    child: FilledButton(
                      onPressed: isLoading
                          ? null
                          : () async {
                              bool isValid = _formState.currentState!
                                  .validate();
                              if (isValid) {
                                setState(() {
                                  isLoading = true;
                                });
                                UserModel user = UserModel(
                                  email: emailController.text.trim(),
                                  password: passwordController.text,
                                  name: nameController.text,
                                );
                                try {
                                  await FirebaseAuthService.register(user);
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "success,start login!",
                                          style: AppTextStyles.styleS16W600(
                                            color: Colors.white,
                                          ),
                                        ),
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withValues(alpha: .6),
                                      ),
                                    );
                                    Navigator.of(context).pop();
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
                                //
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            },
                      style: FilledButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: isLoading
                          ? CircularProgressIndicator()
                          : Text("Create account"),
                    ),
                  ),
                  //Don’t Have Account ? Create Account
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: "Already Have Account ? "),
                        TextSpan(
                          text: "Login",
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
                              ).pushReplacementNamed(LoginScreen.routeName);
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
                      icon: Image.asset(
                        Assets.icons.google.path,
                        width: 25,
                        height: 25,
                      ),
                      onPressed: () {},
                      label: Text(
                        "Sign up With Google",
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
}
