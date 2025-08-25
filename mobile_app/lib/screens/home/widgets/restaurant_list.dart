import 'package:flutter/material.dart';
import 'package:mobile_app/config/theme.dart';
import 'package:mobile_app/l10n/app_localizations.dart';
import 'package:mobile_app/screens/restaurant/restaurant_detail_screen.dart';

class RestaurantList extends StatelessWidget {
  final String selectedCategory;

  const RestaurantList({super.key, required this.selectedCategory});

  final List<Map<String, dynamic>> restaurants = const [
    {
      'name': 'McDonald\'s',
      'image': 'assets/restaurants/mcdonalds.jpg',
      'rating': 4.6,
      'deliveryTime': '20-30 min',
      'deliveryFee': 1.99,
      'description': 'Restaurant de fast-food spécialisé dans les hamburgers, frites et milkshakes.',
      'category': 'fast_food',
      'menu': {
        'Entrées': [
          {'name': 'Salade César', 'price': 8.99, 'description': 'Laitue romaine, croûtons, parmesan, sauce césar', 'image': 'assets/menu/salad.jpg'},
          {'name': 'Nuggets', 'price': 5.99, 'description': 'Bouchées de poulet croustillantes', 'image': 'assets/menu/nuggets.jpg'},
        ],
        'Plats Principaux': [
          {'name': 'Big Mac', 'price': 7.99, 'description': 'Le classique avec deux steaks hachés', 'image': 'assets/menu/big_mac.jpg'},
          {'name': 'Cheeseburger', 'price': 4.99, 'description': 'Simple et savoureux', 'image': 'assets/menu/cheeseburger.jpg'},
        ],
        'Desserts': [
          {'name': 'Sundae', 'price': 3.50, 'description': 'Glace vanille avec sauce au choix', 'image': 'assets/menu/sundae.jpg'},
          {'name': 'Apple Pie', 'price': 2.99, 'description': 'Tartelette aux pommes', 'image': 'assets/menu/apple_pie.jpg'},
        ],
        'Boissons': [
          {'name': 'Coca-Cola', 'price': 2.50, 'description': 'Canette 33cl', 'image': 'assets/menu/coca.jpg'},
          {'name': 'Milkshake', 'price': 4.50, 'description': 'Fraise, chocolat ou vanille', 'image': 'assets/menu/milkshake.jpg'},
        ],
      }
    },
    {
      'name': 'KFC',
      'image': 'assets/restaurants/kfc.jpg',
      'rating': 4.5,
      'deliveryTime': '25-35 min',
      'deliveryFee': 2.50,
      'description': 'Spécialiste du poulet frit et des burgers croustillants.',
      'category': 'fast_food',
      'menu': {
        'Entrées': [
          {'name': 'Wings', 'price': 9.99, 'description': 'Ailes de poulet épicées', 'image': 'assets/menu/wings.jpg'},
          {'name': 'Tenders', 'price': 7.50, 'description': 'Lanières de poulet croustillantes', 'image': 'assets/menu/tenders.jpg'},
        ],
        'Plats Principaux': [
          {'name': 'Bucket', 'price': 19.99, 'description': '16 pièces de poulet', 'image': 'assets/menu/bucket.jpg'},
          {'name': 'Zinger Burger', 'price': 8.99, 'description': 'Burger épicé au poulet croustillant', 'image': 'assets/menu/zinger.jpg'},
        ],
        'Desserts': [
          {'name': 'Cookie', 'price': 3.99, 'description': 'Cookie aux pépites de chocolat', 'image': 'assets/menu/cookie.jpg'},
        ],
        'Boissons': [
          {'name': 'Pepsi', 'price': 2.50, 'description': 'Canette 33cl', 'image': 'assets/menu/pepsi.jpg'},
        ],
      }
    },
    {
      'name': 'Sushi Master',
      'image': 'assets/restaurants/sushi_master.jpg',
      'rating': 4.8,
      'deliveryTime': '30-40 min',
      'deliveryFee': 2.99,
      'description': 'Sushi frais préparés à la commande avec des ingrédients de qualité supérieure.',
      'category': 'asian',
      'menu': {
        'Entrées': [
          {'name': 'Edamame', 'price': 5.50, 'description': 'Fèves de soja salées', 'image': 'assets/menu/edamame.jpg'},
          {'name': 'Soupe Miso', 'price': 4.50, 'description': 'Soupe traditionnelle japonaise', 'image': 'assets/menu/miso.jpg'},
        ],
        'Plats Principaux': [
          {'name': 'Assortiment Sushi', 'price': 22.99, 'description': '12 pièces de sushi variés', 'image': 'assets/menu/sushi_platter.jpg'},
          {'name': 'Ramen', 'price': 14.99, 'description': 'Nouilles dans un bouillon riche', 'image': 'assets/menu/ramen.jpg'},
        ],
        'Desserts': [
          {'name': 'Mochi', 'price': 6.99, 'description': 'Pâtisserie japonaise glacée', 'image': 'assets/menu/mochi.jpg'},
        ],
        'Boissons': [
          {'name': 'Thé vert', 'price': 3.50, 'description': 'Thé vert japonais', 'image': 'assets/menu/green_tea.jpg'},
          {'name': 'Sake', 'price': 8.50, 'description': 'Alcool de riz japonais', 'image': 'assets/menu/sake.jpg'},
        ],
      }
    },
    {
      'name': 'Pasta Paradise',
      'image': 'assets/restaurants/pasta_paradise.jpg',
      'rating': 4.7,
      'deliveryTime': '35-45 min',
      'deliveryFee': 1.99,
      'description': 'Pâtes fraîches et sauces maison dans une ambiance italienne authentique.',
      'category': 'italian',
      'menu': {
        'Entrées': [
          {'name': 'Bruschetta', 'price': 7.99, 'description': 'Pain grillé aux tomates fraîches', 'image': 'assets/menu/bruschetta.jpg'},
          {'name': 'Antipasti', 'price': 12.99, 'description': 'Assortiment de charcuteries et fromages', 'image': 'assets/menu/antipasti.jpg'},
        ],
        'Plats Principaux': [
          {'name': 'Spaghetti Carbonara', 'price': 14.99, 'description': 'Pâtes avec sauce crémeuse au lard', 'image': 'assets/menu/carbonara.jpg'},
          {'name': 'Lasagne', 'price': 16.50, 'description': 'Feuilles de pâtes, bolognaise, béchamel', 'image': 'assets/menu/lasagne.jpg'},
        ],
        'Desserts': [
          {'name': 'Tiramisu', 'price': 7.50, 'description': 'Dessert italien au café et mascarpone', 'image': 'assets/menu/tiramisu.jpg'},
          {'name': 'Panna Cotta', 'price': 6.99, 'description': 'Crème dessert aux fruits rouges', 'image': 'assets/menu/panna_cotta.jpg'},
        ],
        'Boissons': [
          {'name': 'Vin rouge', 'price': 6.50, 'description': 'Verre de Chianti', 'image': 'assets/menu/red_wine.jpg'},
          {'name': 'Limonade', 'price': 4.00, 'description': 'Maison, fraîchement pressée', 'image': 'assets/menu/lemonade.jpg'},
        ],
      }
    },
    {
      'name': 'Sweet Dreams',
      'image': 'assets/restaurants/sweet_dreams.jpg',
      'rating': 4.9,
      'deliveryTime': '20-25 min',
      'deliveryFee': 0.99,
      'description': 'Pâtisseries fines et desserts gourmands pour satisfaire vos envies sucrées.',
      'category': 'desserts',
      'menu': {
        'Gâteaux': [
          {'name': 'Fondant au chocolat', 'price': 8.99, 'description': 'Gâteau moelleux avec cœur coulant', 'image': 'assets/menu/chocolate_cake.jpg'},
          {'name': 'Cheesecake', 'price': 7.50, 'description': 'Classique new-yorkais', 'image': 'assets/menu/cheesecake.jpg'},
        ],
        'Glaces': [
          {'name': 'Coupe glacée', 'price': 9.99, 'description': '3 boules avec garniture au choix', 'image': 'assets/menu/ice_cream.jpg'},
          {'name': 'Sundae', 'price': 8.50, 'description': 'Glace vanille, chocolat, noisettes', 'image': 'assets/menu/sundae.jpg'},
        ],
        'Pâtisseries': [
          {'name': 'Éclair', 'price': 4.50, 'description': 'Éclair au chocolat ou café', 'image': 'assets/menu/eclair.jpg'},
          {'name': 'Macarons', 'price': 12.99, 'description': 'Assortiment de 6 macarons', 'image': 'assets/menu/macarons.jpg'},
        ],
        'Boissons': [
          {'name': 'Café', 'price': 2.50, 'description': 'Expresso, allongé ou cappuccino', 'image': 'assets/menu/coffee.jpg'},
          {'name': 'Thé', 'price': 3.00, 'description': 'Sélection de thés fins', 'image': 'assets/menu/tea.jpg'},
        ],
      }
    },
  ];

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    final filteredRestaurants = (selectedCategory == 'Tous' || selectedCategory == 'all')
        ? restaurants
        : restaurants.where((r) => r['category'] == selectedCategory).toList();

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 3 / 4,
      ),
      itemCount: filteredRestaurants.length,
      itemBuilder: (context, index) {
        final r = filteredRestaurants[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RestaurantDetailScreen(restaurant: r),
              ),
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.asset(
                      r['image'],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        r['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.star, color: AppTheme.lightTheme.primaryColor, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            r['rating'].toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            r['deliveryTime'],
                            style: TextStyle(color: Colors.grey[600], fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}