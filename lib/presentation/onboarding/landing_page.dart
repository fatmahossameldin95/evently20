import 'package:evently/app_provider/app_provider.dart';
import 'package:evently/common/widgets/custom_main_button.dart';
import 'package:evently/gen/assets.gen.dart';
import 'package:evently/presentation/home/tabs/home_tab/home_tab_provider/home_tab_provider.dart';
import 'package:evently/presentation/onboarding/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});
  static const String routeName = "/landingPage";
  static const List<String> languages = ["English", "العربية"];
  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    ThemeData theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (context) => EventsProvider(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              Center(
                child: Image.asset(
                  context.watch<AppProvider>().themeMode == ThemeMode.light
                      ? Assets.images.logo.path
                      : Assets.images.eventlyDark.path,
                  width: 140,
                  height: 100,
                ),
              ),

              Image.asset(
                context.watch<AppProvider>().themeMode == ThemeMode.light
                    ? Assets.images.beingCreative.path
                    : Assets.images.beingCreativeDark.path,
              ),

              Text(
                "Personalize Your Experience",

                style: theme.textTheme.displayLarge!.copyWith(
                  color: Theme.of(context).secondaryHeaderColor,
                  fontSize: 24,
                ),
              ),
              Text(
                "Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.",
                style: theme.textTheme.labelSmall!.copyWith(
                  color: Theme.of(context).hintColor,
                  fontSize: 16,
                ),
              ),
              Row(
                children: [
                  Text(
                    "Language",
                    style: theme.textTheme.displayLarge!.copyWith(
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                  Spacer(),
                  languageChip(context, "English", "en"),
                  const SizedBox(width: 12),
                  languageChip(context, "العربية", "ar"),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Theme",
                    style: theme.textTheme.displayLarge!.copyWith(
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                  Spacer(),
                  ThemeChip(context, Icons.wb_sunny_outlined, ThemeMode.light),
                  const SizedBox(width: 12),
                  ThemeChip(context, Icons.nightlight_round, ThemeMode.dark),
                ],
              ),
              CustomMainButton(
                isLoading: isLoading,
                label: "Let's start",
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    OnboardingPage.routeName,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget languageChip(BuildContext context, String label, String code) {
  final isSelected = context.watch<AppProvider>().local == code;
  return ChoiceChip(
    label: Text(label),
    selected: isSelected,
    onSelected: (_) => context.read<AppProvider>().changeLocalWithCode(code),
    selectedColor: Theme.of(context).cardColor,
    backgroundColor: Theme.of(context).splashColor,
    labelStyle: TextStyle(
      color: isSelected ? Colors.white : Theme.of(context).cardColor,
      fontWeight: FontWeight.w500,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: BorderSide.none,
    ),
    showCheckmark: false,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  );
}

Widget ThemeChip(BuildContext context, IconData icon, ThemeMode mode) {
  final isSelected = context.watch<AppProvider>().themeMode == mode;
  return ChoiceChip(
    label: Icon(
      icon,
      size: 22,
      color: isSelected ? Colors.white : Theme.of(context).cardColor,
    ),
    selected: isSelected,
    onSelected: (_) => context.read<AppProvider>().changeThemeWithMode(mode),
    selectedColor: Theme.of(context).cardColor,
    backgroundColor: Theme.of(context).splashColor,
    labelStyle: TextStyle(
      color: isSelected ? Colors.white : Theme.of(context).cardColor,
      fontWeight: FontWeight.w500,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: BorderSide.none,
    ),
    showCheckmark: false,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  );
}
