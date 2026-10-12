import 'package:evently/common/enums/categories_enum.dart';
import 'package:evently/presentation/home/widgets/category_card.dart';
import 'package:evently/presentation/new_event/provider/new_event_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<NewEventProvider, CategoriesEnum>(
      selector: (p0, p1) => p1.selectedCategory,
      builder: (context, value, child) {
        return Column(
          spacing: 16,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                value.getImage,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: CategoriesEnum.values
                    .map(
                      (e) => CategoryCard(
                        isSelected: e == value,
                        categoriesEnum: e,
                        isWhite: false,
                        onSelect: (p0) {
                          if (p0 != null) {
                            context.read<NewEventProvider>().changeCategory(p0);
                          }
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
