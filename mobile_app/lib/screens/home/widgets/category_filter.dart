// lib/screens/home/widgets/category_filter.dart
import 'package:flutter/material.dart';
import 'package:mobile_app/l10n/app_localizations.dart';

class CategoryFilter extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategoryFilter({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  // Use keys here — translations defined in .arb
  final List<String> categories = const [
    'all',
    'near by',
    'fast_food',
    'asian',
    'italian',
    'vegetarian',
    'desserts',
  ];

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final key = categories[index];
          final label = loc.translate(key);
          final isSelected = key == selectedCategory || (selectedCategory == 'Tous' && key == 'all');

          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ChoiceChip(
              label: Text(label),
              selected: isSelected,
              onSelected: (_) {
                onCategorySelected(key == 'all' ? 'Tous' : key);
              },
              backgroundColor: Colors.grey[200],
              selectedColor: Theme.of(context).primaryColor,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w500,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          );
        },
      ),
    );
  }
}
