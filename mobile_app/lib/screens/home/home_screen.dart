import 'package:flutter/material.dart';
import 'package:mobile_app/config/theme.dart';
import 'package:mobile_app/l10n/app_localizations.dart';
import 'widgets/category_filter.dart';
import 'widgets/favorite_restaurants.dart';
import 'widgets/restaurant_list.dart';
import 'widgets/custom_app_bar.dart';
import 'widgets/home_footer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedCategory = 'Tous';
  int _currentIndex = 0;

  void _resetCategory() {
    setState(() => _selectedCategory = 'Tous');
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: CustomHomeAppBar(onSearchTap: () {  }),
      drawer: const CustomHomeDrawer(),
      bottomNavigationBar: HomeFooter(
        currentIndex: _currentIndex,
        onTabSelected: (index) {
          setState(() => _currentIndex = index);
          // ici tu gères la navigation entre les pages
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle(context, loc.translate('categories')),
                CategoryFilter(
                  selectedCategory: _selectedCategory,
                  onCategorySelected: (category) =>
                      setState(() => _selectedCategory = category),
                  // 🔹 "Nearby" doit être ajouté directement dans CategoryFilter
                ),
                const SizedBox(height: 8),

                _buildSectionTitle(context, loc.translate('favorites')),
                const FavoriteRestaurants(),
              ],
            ),
          ),

          Expanded(
            child: RestaurantList(selectedCategory: _selectedCategory),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
