import 'package:flutter/material.dart';
import 'package:mobile_app/config/theme.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app/core/providers/cart_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuDetailModal extends StatelessWidget {
  final Map<String, dynamic> item;
  final ScrollController scrollController;

  const MenuDetailModal({
    super.key,
    required this.item,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cartProvider = Provider.of<CartProvider>(context);

    final name = item['name'] ?? '';
    final description = item['description'] ?? '';
    final price = (item['price'] as num?)?.toDouble() ?? 0.0;
    final calories = item['calories'] ?? '450 kcal';
    final ingredients = item['ingredients'] ?? ['Ingrédients non spécifiés'];
    final preparationTime = item['preparationTime'] ?? '15-20 min';
    final image = item['image'] ?? '';

    final cartItem = cartProvider.items.firstWhere(
      (element) => element.name == name,
      orElse: () => CartItem(name: '', price: 0, image: ''),
    );
    final quantity = cartItem.name == name ? cartItem.quantity : 0;

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: SingleChildScrollView(
        controller: scrollController,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Barre de drag
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 12, bottom: 16),
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            // Image
            if (image.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    image,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 200,
                      color: Colors.grey[200],
                      child: Icon(Icons.fastfood, 
                          size: 60, 
                          color: AppColors.primary),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Infos principales
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nom et prix
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text,
                          ),
                        ),
                      ),
                      Text(
                        '${price.toStringAsFixed(2)} €',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Chips info
                  Row(
                    children: [
                      _buildMetricChip(
                        icon: Icons.local_fire_department,
                        value: calories,
                        theme: theme,
                      ),
                      const SizedBox(width: 8),
                      _buildMetricChip(
                        icon: Icons.timer,
                        value: preparationTime,
                        theme: theme,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Description
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Ingrédients avec icône
                  Row(
                    children: [
                      Icon(Icons.restaurant_menu, 
                          color: AppColors.primary, size: 24),
                      const SizedBox(width: 8),
                      Text(
                        'Ingrédients',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.text,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ...ingredients.map<Widget>((ingredient) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Icon(Icons.circle, 
                            size: 8, 
                            color: AppColors.primary),
                        const SizedBox(width: 8),
                        Text(
                          ingredient, 
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: AppColors.text,
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Contrôle quantité
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Quantité',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.grey),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove, 
                              color: quantity > 0 
                                  ? AppColors.primary 
                                  : AppColors.grey),
                          onPressed: quantity > 0
                              ? () => cartProvider.removeItem(name)
                              : null,
                        ),
                        Text('$quantity', 
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.text,
                            ),
                        ),
                        IconButton(
                          icon: Icon(Icons.add, 
                              color: AppColors.primary),
                          onPressed: () => cartProvider.addItem(
                            name: name,
                            price: price,
                            image: image,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Bouton ajouter panier avec icône
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
                label: Text(
                  'Ajouter au panier',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  cartProvider.addItem(
                    name: name,
                    price: price,
                    image: image,
                  );
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricChip({
    required IconData icon,
    required String value,
    required ThemeData theme,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.primary),
          const SizedBox(width: 4),
          Text(
            value, 
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: AppColors.text,
            ),
          ),
        ],
      ),
    );
  }
}