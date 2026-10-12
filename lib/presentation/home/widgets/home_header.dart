import 'package:evently/app_provider/app_provider.dart';
import 'package:evently/common/app_text_styles.dart';
import 'package:evently/common/enums/categories_enum.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/presentation/home/widgets/category_card.dart';
import 'package:evently/common/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatefulWidget implements PreferredSizeWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();

  @override
  Size get preferredSize => Size(AppBar().preferredSize.width, 174);
}

class _HomeHeaderState extends State<HomeHeader> {
  CategoriesEnum? selectedCategory;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  spacing: 4,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      AppLocalizations.of(context)!.welcome_back,
                      style: theme.textTheme.labelSmall!.copyWith(color: Theme.of(context).hintColor),
                    ),
                    Text(
                      "name",
                      style: theme.textTheme.displayLarge!.copyWith(
                        color: Theme.of(context).hintColor,
                        fontSize: 24,
                      ),
                    ),
                    Row(
                      spacing: 5,
                      children: [
                        Icon(Icons.location_on_outlined, color: Theme.of(context).hintColor, size: 20),
                        Text(
                          "address",
                          style: theme.textTheme.titleMedium!.copyWith(
                            color: Theme.of(context).hintColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                SizedBox(
                  width: 35,
                  height: 35,
                  child: IconButton(
                    onPressed: () {
                      context.read<AppProvider>().changeTheme();
                    },
                    icon: Icon(
                      // Theme.of(context).colorScheme.brightness == Brightness.light
                      context.watch<AppProvider>().themeMode == ThemeMode.light
                          ? Icons.nightlight_outlined
                          : Icons.wb_sunny_outlined,
                      color: AppColors.lightBgColor,
                    ),
                  ),
                ),
                SizedBox(width: 5),
                SizedBox(
                  width: 35,
                  height: 35,
                  child: FilledButton(
                    onPressed: () {
                      context.read<AppProvider>().changeLocal();
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.lightBgColor,
                      padding: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text(
                      context.watch<AppProvider>().local,
                      style: AppTextStyles.styleS14W700(color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              // height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  CategoryCard(
                    isSelected: selectedCategory == null,
                    categoriesEnum: null,
                    isAllCategories: true,
                    onSelect: (p0) {
                      selectedCategory = null;
                      setState(() {});
                    },
                  ),
                  ...CategoriesEnum.values.map(
                    (e) => CategoryCard(
                      categoriesEnum: e,
                      isSelected: selectedCategory == e,
                      onSelect: (p0) {
                        selectedCategory = p0;
                        setState(() {});
                      },
                    ),
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
//