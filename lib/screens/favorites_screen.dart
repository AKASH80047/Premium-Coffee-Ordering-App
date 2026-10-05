import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../core/app_state.dart';
import 'product_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Favorites'),
        centerTitle: true,
      ),
      body: ListenableBuilder(
        listenable: BreworaState(),
        builder: (context, _) {
          final favs = BreworaState().favoriteCoffees;
          
          if (favs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border_rounded, size: 80, color: AppColors.textLight.withOpacity(0.5)),
                  const SizedBox(height: 24),
                  const Text('No favorites yet', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'Save your favorite coffees here and order them anytime.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.textLight, height: 1.5),
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      // We can just switch tab by returning to home, or use Navigator pop if pushed
                      // In this app, Favorites is usually a tab, so maybe just show the message.
                      // If it's a tab, we shouldn't pop. We can't easily change tab from here without access to MainNavigation state.
                      // Let's just provide the button and pop to first route.
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
                    child: const Text('Explore Coffee'),
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(24),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: favs.length,
            itemBuilder: (context, index) {
              final coffee = favs[index];
              return GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(coffee: coffee))),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 5))],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(image: AssetImage(coffee.imageUrl), fit: BoxFit.cover),
                          ),
                          alignment: Alignment.topRight,
                          padding: const EdgeInsets.all(8),
                          child: GestureDetector(
                            onTap: () => BreworaState().toggleFavorite(coffee.id),
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(color: AppColors.white.withOpacity(0.9), shape: BoxShape.circle),
                              child: const Icon(Icons.favorite_rounded, color: AppColors.caramel, size: 18),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(coffee.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.darkEspresso), maxLines: 1, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('\$${coffee.basePrice.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.coffeeBrown)),
                          Row(
                            children: [
                              const Icon(Icons.star_rounded, color: AppColors.caramel, size: 12),
                              const SizedBox(width: 2),
                              Text('${coffee.rating}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: AppColors.textLight)),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
