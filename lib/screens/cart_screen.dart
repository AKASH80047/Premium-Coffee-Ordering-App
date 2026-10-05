import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../core/data.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double get subtotal => AppState.cart.fold(0, (sum, item) => sum + (item.price * item.quantity));
  double get delivery => 4.50;
  double get tax => subtotal * 0.08;
  double get total => subtotal + delivery + tax;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded), onPressed: () => Navigator.pop(context)),
        title: const Text('My Cart'),
        centerTitle: true,
      ),
      body: AppState.cart.isEmpty 
        ? const Center(child: Text('Your cart is empty', style: TextStyle(color: AppColors.textLight)))
        : Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(24),
                  itemCount: AppState.cart.length,
                  itemBuilder: (context, index) {
                    final item = AppState.cart[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(image: AssetImage(item.coffee.imageUrl), fit: BoxFit.cover),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.coffee.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                const SizedBox(height: 4),
                                Text('${item.size} • ${item.volume}ml', style: const TextStyle(color: AppColors.textLight, fontSize: 12)),
                                const SizedBox(height: 8),
                                Text('\$${item.price.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.coffeeBrown)),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.close, size: 16, color: AppColors.textLight),
                                onPressed: () => setState(() => AppState.cart.removeAt(index)),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.lightBeige,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (item.quantity > 1) setState(() => item.quantity--);
                                      },
                                      child: const Icon(Icons.remove, size: 16),
                                    ),
                                    const SizedBox(width: 12),
                                    Text('${item.quantity}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                    const SizedBox(width: 12),
                                    GestureDetector(
                                      onTap: () => setState(() => item.quantity++),
                                      child: const Icon(Icons.add, size: 16),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, -5))],
                ),
                child: Column(
                  children: [
                    _buildSummaryRow('Subtotal', subtotal),
                    const SizedBox(height: 8),
                    _buildSummaryRow('Delivery', delivery),
                    const SizedBox(height: 8),
                    _buildSummaryRow('Tax', tax),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(color: AppColors.lightBeige),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        Text('\$${total.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: AppColors.coffeeBrown)),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CheckoutScreen())),
                        child: const Text('Proceed to Checkout'),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
    );
  }

  Widget _buildSummaryRow(String label, double amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textLight)),
        Text('\$${amount.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.darkEspresso)),
      ],
    );
  }
}
