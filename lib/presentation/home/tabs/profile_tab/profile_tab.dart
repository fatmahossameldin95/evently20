import 'package:evently/app_provider/app_provider.dart';
import 'package:evently/common/app_text_styles.dart';
import 'package:evently/common/theme/app_colors.dart';
import 'package:evently/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

final User? user = FirebaseAuth.instance.currentUser;

final String email = user?.email ?? 'name@email.com';
final String name = user?.displayName ?? 'Name';

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    bool status = context.watch<AppProvider>().themeMode == ThemeMode.light
        ? false
        : true;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 10,
          children: [
            SizedBox(height: 20),
            Center(
              child: Image.asset(
                Assets.images.route.path,
                width: 110,
                height: 110,
              ),
            ),
            Text(
              name,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                color: Theme.of(context).secondaryHeaderColor,
                fontSize: 24,
              ),
            ),
            Text(
              email,
              style: AppTextStyles.styleS20W500(
                color: Theme.of(context).hintColor,
              ),
            ),
            SizedBox(height: 10),

            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                //border: Border.all(color: Theme.of(context).cardColor),
                color: Theme.of(context).splashColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Dark Mode",
                    style: AppTextStyles.styleS20W500(
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                  ),
                  FlutterSwitch(
                    width: 60.0,
                    height: 30.0,
                    valueFontSize: 0,
                    toggleSize: 30.0,
                    value: status,
                    borderRadius: 20.0,

                    showOnOff: true,
                    onToggle: (val) {
                       context.read<AppProvider>().changeTheme();
                       
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                //border: Border.all(color: Theme.of(context).cardColor),
                color: Theme.of(context).splashColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Language",
                    style: AppTextStyles.styleS20W500(
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                //border: Border.all(color: Theme.of(context).cardColor),
                color: Theme.of(context).splashColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Logout",
                    style: AppTextStyles.styleS20W500(
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Icon(Icons.logout, color: AppColors.errorColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
