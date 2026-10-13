import 'package:evently/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(child: Image.asset(Assets.images.route.path, width: 110, height: 110)),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
