import 'package:evently/app_provider/app_provider.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/presentation/auth/login/forgot_password.dart';
import 'package:evently/presentation/auth/login/login_screen.dart';
import 'package:evently/presentation/auth/register/register_screen.dart';
import 'package:evently/firebase_options.dart';
import 'package:evently/presentation/home/home_screen.dart';
import 'package:evently/presentation/new_event/new_event_screen.dart';
import 'package:evently/common/theme/app_theme.dart';
import 'package:evently/presentation/onboarding/landing_page.dart';
import 'package:evently/presentation/onboarding/onboarding_page.dart';
import 'package:evently/presentation/view_event/view_event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (!kIsWeb) {
    await GoogleSignIn.instance.initialize();
    
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  bool isLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return AppProvider();
      },
      child: Builder(
        builder: (ctx) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Evently App',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ctx.watch<AppProvider>().themeMode,
            localizationsDelegates: [
              AppLocalizations.delegate,
              ...GlobalMaterialLocalizations.delegates,
            ],
            locale: Locale(ctx.watch<AppProvider>().local),
            supportedLocales: AppLocalizations.supportedLocales,
            routes: {
              LoginScreen.routeName: (_) => LoginScreen(),
              RegisterScreen.routeName: (_) => RegisterScreen(),
              HomeScreen.routeName: (_) => HomeScreen(),
              NewEventScreen.routeName: (_) => NewEventScreen(),
              LandingPage.routeName: (_) => LandingPage(),
              OnboardingPage.routeName: (_) => OnboardingPage(),
              ForgotPassword.routeName: (_) => ForgotPassword(),
             
            },
            // initialRoute: isLoggedIn()
            //     ? HomeScreen.routeName
            //     : LoginScreen.routeName,
            home:LandingPage()
          );
        },
      ),
    );
  }
}
