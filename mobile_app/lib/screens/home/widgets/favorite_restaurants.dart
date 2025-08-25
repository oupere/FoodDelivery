import 'package:flutter/material.dart';
import 'package:mobile_app/config/theme.dart';

class FavoriteRestaurants extends StatelessWidget {
  const FavoriteRestaurants({super.key});

  final List<Map<String, dynamic>> restaurants = const [
    {
      'name': 'Burger King',
      'image': 'assets/restaurants/burger_king.jpg',
      'rating': 4.7,
    },
    {
      'name': 'Sushi Palace',
      'image': 'assets/restaurants/sushi_palace.jpg',
      'rating': 4.9,
    },
    {
      'name': 'Pizza Hut',
      'image': 'assets/restaurants/pizza_hut.jpg',
      'rating': 4.5,
    },
    {
      'name': 'Green Garden',
      'image': 'assets/restaurants/green_garden.jpg',
      'rating': 4.8,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110, // Hauteur réduite
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          final r = restaurants[index];
          return Container(
            width: 95, // largeur réduite
            margin: EdgeInsets.only(
              left: index == 0 ? 12 : 6,
              right: index == restaurants.length - 1 ? 12 : 6,
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    r['image'],
                    height: 65,
                    width: 95,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  r['name'],
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: AppTheme.lightTheme.primaryColor, size: 11),
                    const SizedBox(width: 2),
                    Text(
                      r['rating'].toString(),
                      style: const TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
