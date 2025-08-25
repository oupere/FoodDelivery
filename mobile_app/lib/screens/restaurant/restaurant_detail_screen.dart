import 'package:flutter/material.dart';
import 'package:mobile_app/core/providers/cart_provider.dart';
import 'package:mobile_app/l10n/app_localizations.dart';
import 'package:mobile_app/screens/restaurant/menu_detail_page.dart';
import 'package:provider/provider.dart';

class RestaurantDetailScreen extends StatefulWidget {
  final Map<String, dynamic> restaurant;

  const RestaurantDetailScreen({super.key, required this.restaurant});

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  int _selectedCategoryIndex = 0;
  final Map<String, List<Map<String, dynamic>>> _menuItems = {
    'Entrées': [
      {
        'name': 'Salade César',
        'price': 8.99,
        'description': 'Laitue romaine, croûtons, parmesan, sauce césar',
        'image': 'assets/menu/salad.jpg',
        'calories': '320 kcal',
        'preparationTime': '10 min',
        'ingredients': [
          'Laitue romaine',
          'Croûtons maison',
          'Parmesan frais',
          'Sauce césar',
          'Filet de poulet grillé',
        ],
      },
      {
        'name': 'Bruschetta',
        'price': 7.50,
        'description': 'Pain grillé, tomates fraîches, basilic, huile d\'olive',
        'image': 'assets/menu/bruschetta.jpg',
        'calories': '280 kcal',
        'preparationTime': '8 min',
        'ingredients': [
          'Pain baguette',
          'Tomates fraîches',
          'Basilic',
          'Ail',
          'Huile d\'olive extra vierge',
        ],
      },
      {
        'name': 'Soupe du jour',
        'price': 6.99,
        'description': 'Soupe maison préparée avec des ingrédients frais',
        'image': 'assets/menu/soup.jpg',
        'calories': '250 kcal',
        'preparationTime': '12 min',
        'ingredients': [
          'Légumes de saison',
          'Bouillon de légumes maison',
          'Crème fraîche',
          'Herbes fraîches',
        ],
      },
    ],
    'Plats Principaux': [
      {
        'name': 'Poulet Rôti',
        'price': 15.99,
        'description': 'Poulet rôti aux herbes de Provence, légumes de saison',
        'image': 'assets/menu/chicken.jpg',
        'calories': '650 kcal',
        'preparationTime': '35 min',
        'ingredients': [
          'Poulet fermier',
          'Herbes de Provence',
          'Pommes de terre nouvelles',
          'Carottes',
          'Oignons',
          'Ail',
        ],
      },
      {
        'name': 'Pâtes Carbonara',
        'price': 12.99,
        'description': 'Spaghetti, lardons, œuf, parmesan, poivre noir',
        'image': 'assets/menu/pasta.jpg',
        'calories': '780 kcal',
        'preparationTime': '20 min',
        'ingredients': [
          'Spaghetti frais',
          'Lardons fumés',
          'Œufs bio',
          'Parmigiano Reggiano',
          'Poivre noir moulu',
        ],
      },
      {
        'name': 'Steak Frites',
        'price': 18.50,
        'description': 'Steak de bœuf angus, frites maison, sauce au choix',
        'image': 'assets/menu/steak.jpg',
        'calories': '850 kcal',
        'preparationTime': '25 min',
        'ingredients': [
          'Steak de bœuf Angus 200g',
          'Pommes de terre',
          'Sel de Guérande',
          'Beurre aux herbes',
          'Sauce béarnaise ou poivre',
        ],
      },
    ],
    'Desserts': [
      {
        'name': 'Tiramisu',
        'price': 6.99,
        'description': 'Classique italien au café et mascarpone',
        'image': 'assets/menu/tiramisu.jpg',
        'calories': '420 kcal',
        'preparationTime': '15 min',
        'ingredients': [
          'Mascarpone',
          'Œufs frais',
          'Sucre roux',
          'Biscuits cuillère',
          'Café expresso',
          'Cacao en poudre',
        ],
      },
      {
        'name': 'Fondant au Chocolat',
        'price': 7.50,
        'description': 'Gâteau moelleux avec cœur coulant au chocolat',
        'image': 'assets/menu/chocolate.jpg',
        'calories': '580 kcal',
        'preparationTime': '18 min',
        'ingredients': [
          'Chocolat noir 70%',
          'Beurre',
          'Œufs',
          'Sucre',
          'Farine',
          'Crème anglaise maison',
        ],
      },
      {
        'name': 'Crème Brûlée',
        'price': 6.50,
        'description': 'Crème vanille avec caramel croustillant',
        'image': 'assets/menu/creme_brulee.jpg',
        'calories': '380 kcal',
        'preparationTime': '30 min',
        'ingredients': [
          'Crème fraîche liquide',
          'Gousses de vanille',
          'Jaunes d\'œufs',
          'Sucre de canne',
          'Sucre cassonade pour la croûte',
        ],
      },
    ],
    'Boissons': [
      {
        'name': 'Eau Minérale',
        'price': 2.50,
        'description': 'Bouteille 50cl',
        'image': 'assets/menu/water.jpg',
        'calories': '0 kcal',
        'preparationTime': '0 min',
        'ingredients': ['Eau minérale naturelle'],
      },
      {
        'name': 'Soda',
        'price': 3.00,
        'description': 'Coca, Fanta, Sprite',
        'image': 'assets/menu/soda.jpg',
        'calories': '140 kcal',
        'preparationTime': '0 min',
        'ingredients': [
          'Eau gazéifiée',
          'Sucre',
          'Arômes naturels',
          'Colorant caramel (pour Coca)',
        ],
      },
      {
        'name': 'Vin Rouge',
        'price': 5.50,
        'description': 'Verre de vin de la maison',
        'image': 'assets/menu/wine.jpg',
        'calories': '120 kcal',
        'preparationTime': '0 min',
        'ingredients': [
          'Raisins (cépage Merlot/Cabernet Sauvignon)',
          'Sulfites',
        ],
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final categories = _menuItems.keys.toList();

    // Safe getters for restaurant fields (avoid null crash)
    final restaurantImage = widget.restaurant['image'] as String?;
    final restaurantName = widget.restaurant['name'] as String? ?? '';
    final restaurantRating = widget.restaurant['rating']?.toString() ?? '';
    final restaurantDeliveryTime =
        widget.restaurant['deliveryTime'] as String? ?? '';
    final restaurantDeliveryFee =
        widget.restaurant['deliveryFee']?.toString() ?? '';
    final restaurantDescription =
        widget.restaurant['description'] as String? ?? '';

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          // SliverAppBar avec image du restaurant
          SliverAppBar(
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background:
                  restaurantImage != null && restaurantImage.isNotEmpty
                      ? Image.asset(restaurantImage, fit: BoxFit.cover)
                      : Container(
                        color: Colors.grey,
                      ), // fallback si pas d'image
            ),
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Icon(Icons.favorite_border, color: Colors.white),
                ),
                onPressed: () {},
              ),
            ],
          ),

          // Infos du restaurant (SliverToBoxAdapter)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // titre + note
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          restaurantName,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Row(
                        children: [
                          Icon(Icons.star, color: theme.primaryColor, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            restaurantRating,
                            style: theme.textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // infos livraison
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Colors.grey[600],
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        restaurantDeliveryTime,
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.delivery_dining,
                        color: Colors.grey[600],
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '$restaurantDeliveryFee ${loc.translate('deliveryFee')}',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // description
                  Text(
                    restaurantDescription,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // titre menu
                  Text(
                    loc.translate('menu'),
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),

          // Barre de navigation des catégories -> SliverToBoxAdapter (évite les problèmes de SliverPersistentHeader)
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              color: theme.scaffoldBackgroundColor,
              child: SizedBox(
                height: 56, // hauteur fixe: assure cohérence
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final label = categories[index];
                    final selected = _selectedCategoryIndex == index;
                    return ChoiceChip(
                      label: Text(label),
                      selected: selected,
                      onSelected:
                          (_) => setState(() => _selectedCategoryIndex = index),
                      selectedColor: theme.primaryColor,
                      backgroundColor: Colors.grey[200],
                      labelStyle: TextStyle(
                        color: selected ? Colors.white : Colors.black87,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // Liste des éléments du menu (SliverList)
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final category = categories[_selectedCategoryIndex];
                final items = _menuItems[category]!;
                final item = items[index];
                return _buildMenuItem(item, loc, theme);
              },
              childCount:
                  _menuItems[categories[_selectedCategoryIndex]]!.length,
            ),
          ),
          // petite marge en bas pour ne pas bloquer le FAB
          SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),

      // Floating cart button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: theme.primaryColor,
        label: Text(
          '${cartProvider.itemCount} ${loc.translate('items')} | ${cartProvider.totalPrice.toStringAsFixed(2)} €',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        icon: const Icon(Icons.shopping_cart, color: Colors.white),
      ),
    );
  }

  Widget _buildMenuItem(Map<String, dynamic> item, AppLocalizations loc, ThemeData theme) {
  final cartProvider = Provider.of<CartProvider>(context); // Accès au panier
  final name = (item['name'] as String?) ?? '';
  final image = (item['image'] as String?) ?? '';
  final description = (item['description'] as String?) ?? '';
  final price = (item['price'] as num?)?.toDouble() ?? 0.0;

  // Trouver la quantité actuelle dans le panier
  final cartItem = cartProvider.items.firstWhere(
    (element) => element.name == name,
    orElse: () => CartItem(name: '', price: 0, image: ''),
  );
  final quantity = cartItem.name == name ? cartItem.quantity : 0;

  return InkWell(
    onTap: () {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => MenuDetailModal(item: item, scrollController: ScrollController()),
      );
    },
    child: Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: image.isNotEmpty
                  ? Image.asset(image, width: 80, height: 80, fit: BoxFit.cover)
                  : Container(width: 80, height: 80, color: Colors.grey[300]),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(description, style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[600]), maxLines: 2, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 8),
                  Text('${price.toStringAsFixed(2)} €', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: theme.primaryColor)),
                ],
              ),
            ),
            // Remplace la Column des boutons dans _buildMenuItem par ceci :
Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    IconButton(
      icon: const Icon(Icons.remove_circle, color: Colors.red, size: 28),
      onPressed: () {
        cartProvider.removeItem(name);
      },
    ),
    Text(
      '$quantity',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: theme.primaryColor,
      ),
    ),
    IconButton(
      icon: Icon(Icons.add_circle, color: theme.primaryColor, size: 28),
      onPressed: () {
        cartProvider.addItem(
          name: name,
          price: price,
          image: image,
        );
      },
    ),
  ],
)

          ],
        ),
      ),
    ),
  );
}
}
