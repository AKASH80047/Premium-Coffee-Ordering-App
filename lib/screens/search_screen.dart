import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../core/data.dart';
import 'product_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final results = dummyCoffees.where((c) => c.name.toLowerCase().contains(_query.toLowerCase())).toList();

    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        title: const Text('Search'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))],
              ),
              child: TextField(
                onChanged: (val) => setState(() => _query = val),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search coffee, drinks or cafés',
                  hintStyle: TextStyle(color: AppColors.textLight),
                  icon: Icon(Icons.search, color: AppColors.textLight),
                ),
              ),
            ),
          ),
          
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: results.length,
              itemBuilder: (context, index) {
                final coffee = results[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(image: AssetImage(coffee.imageUrl), fit: BoxFit.cover),
                    ),
                  ),
                  title: Text(coffee.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(coffee.category, style: const TextStyle(color: AppColors.textLight)),
                  trailing: Text('\$${coffee.basePrice.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.coffeeBrown)),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(coffee: coffee))),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
