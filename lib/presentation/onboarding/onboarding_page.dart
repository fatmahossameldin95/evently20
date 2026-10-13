import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});
  static const String routeName = "/onboardingPage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Onboarding Page",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
