import 'package:evently/app_provider/app_provider.dart';
import 'package:evently/common/widgets/custom_main_button.dart';
import 'package:evently/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});
  static const String routeName = "/forgotPassword";
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    bool isLoading = false;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Forgot Password",
          style: theme.textTheme.displayLarge!.copyWith(
            color: Theme.of(context).secondaryHeaderColor,
            fontSize: 18,
          ),
        ),

        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            SizedBox(height: 15),
            Center(
              child: Image.asset(
                context.watch<AppProvider>().themeMode == ThemeMode.light
                    ? Assets.images.changeSetting.path
                    : Assets.images.changeSettingDark.path,
              ),
            ),
            SizedBox(height: 20),
            CustomMainButton(
              isLoading: isLoading,
              label: "Reset password",
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
