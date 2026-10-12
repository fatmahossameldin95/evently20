import 'package:evently/common/app_text_styles.dart';
import 'package:evently/common/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SnackBarHelper {
  static void successSnackBar(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(title, style: AppTextStyles.styleS16W600(color: Colors.white)),
        backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: .6),
      ),
    );
  }

  static void errorSnackBar(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(title, style: AppTextStyles.styleS16W600(color: Colors.white)),
        backgroundColor: AppColors.errorColor.withValues(alpha: .6),
      ),
    );
  }
}
