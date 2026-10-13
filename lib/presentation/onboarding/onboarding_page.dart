import 'package:evently/app_provider/app_provider.dart';
import 'package:evently/common/app_text_styles.dart';
import 'package:evently/common/enums/onboarding_enum.dart';
import 'package:evently/common/widgets/custom_main_button.dart';
import 'package:evently/gen/assets.gen.dart';
import 'package:evently/presentation/auth/login/login_screen.dart';
import 'package:evently/presentation/home/widgets/home_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});
  static const String routeName = "/onboardingPage";

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController pgController = PageController();

  final onboardingPages = OnboardingEnum.values;
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: PreferredSize( preferredSize: const Size.fromHeight(120),
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child:
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                currentPage > 0
                    ? IconButton(
                        onPressed: () {
                          pgController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Theme.of(context).cardColor,
                        ),
                      )
                    : const SizedBox(width: 40,),
                Image.asset(
                    context.watch<AppProvider>().themeMode == ThemeMode.light
                        ? Assets.images.logo.path
                        : Assets.images.eventlyDark.path,
                    width: 140,
                    height: 200,
                  ),
                
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(LoginScreen.routeName);
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    backgroundColor: Theme.of(context).splashColor,
                  ),
                  child: Text(
                    "Skip",
                    style: AppTextStyles.styleS20W500(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
        body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                controller: pgController,
                itemCount: onboardingPages.length,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final onboarding = onboardingPages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Expanded(
                          child: Image.asset(
                            onboarding.getImage(
                              context.watch<AppProvider>().themeMode,
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            onboardingPages.length,
                            (index) => Center(
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 3,
                                ),
                                width: currentPage == index ? 12 : 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: currentPage == index
                                      ? Theme.of(context).cardColor
                                      : Colors.grey,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          onboarding.getHeader(),
                          style: theme.textTheme.displayLarge!.copyWith(
                            color: Theme.of(context).secondaryHeaderColor,
                            fontSize: 24,
                          ),
                        ),
      
                        const SizedBox(height: 15),
      
                        // Description
                        Text(
                          onboarding.getDescription(),
      
                          style: theme.textTheme.labelSmall!.copyWith(
                            color: Theme.of(context).hintColor,
                            fontSize: 16,
                          ),
                        ),
      
                        const SizedBox(height: 20),
                      ],
                    ),
                  );
                },
              ),
            ),
      
            CustomMainButton(
              isLoading: isLoading,
              label: currentPage == onboardingPages.length - 1
                  ? "Get Started"
                  : "Next",
              onPressed: () {
                if (currentPage < onboardingPages.length - 1) {
                  pgController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                } else {
                  Navigator.of(
                    context,
                  ).pushReplacementNamed(LoginScreen.routeName);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
