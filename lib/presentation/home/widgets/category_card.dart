import 'package:evently/common/app_text_styles.dart';
import 'package:evently/common/enums/categories_enum.dart';
import 'package:evently/common/theme/app_colors.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.isSelected,
    required this.categoriesEnum,
    this.isAllCategories = false,
    required this.onSelect,
    this.isWhite = true,
  });
  final CategoriesEnum? categoriesEnum;
  final bool isSelected;
  final bool isAllCategories;
  final Function(CategoriesEnum?) onSelect;
  final bool isWhite;
  // final String? label;
  // final IconData? iconData;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ChoiceChip(
        onSelected: (value) {
          onSelect(categoriesEnum);
        },
        label: Row(
          spacing: 5,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isAllCategories ? Icons.explore_outlined : categoriesEnum?.getIcon,
              color: isSelected
                  ? isWhite
                        ? theme.cardColor
                        : AppColors.lightBgColor
                  : isWhite
                  ? AppColors.lightBgColor
                  : theme.cardColor,
            ),
            Text(
              isAllCategories
                  ? AppLocalizations.of(context)!.all
                  : categoriesEnum?.getTitle(context) ?? "",
              style: AppTextStyles.styleS16W500(
                color: isSelected
                    ? isWhite
                          ? theme.cardColor
                          : AppColors.lightBgColor
                    : isWhite
                    ? AppColors.lightBgColor
                    : theme.cardColor,
              ),
            ),
          ],
        ),
        selected: isSelected,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: isWhite ? theme.shadowColor : theme.cardColor),
          borderRadius: BorderRadius.circular(46),
        ),
        selectedColor: isWhite ? theme.shadowColor : theme.cardColor,
        backgroundColor: isWhite ? theme.cardColor : theme.scaffoldBackgroundColor,
        showCheckmark: false,
      ),
    );
  }
}
