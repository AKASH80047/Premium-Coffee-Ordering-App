import 'package:flutter/material.dart';
import '../core/theme.dart';
import 'order_success_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded), onPressed: () => Navigator.pop(context)),
        title: const Text('Checkout'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text('Delivery Address', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(16)),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: AppColors.lightBeige, borderRadius: BorderRadius.circular(12)),
                  child: const Icon(Icons.location_on, color: AppColors.coffeeBrown),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Home', style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text('123 Coffee Street', style: TextStyle(color: AppColors.textLight, fontSize: 12)),
                    ],
                  ),
                ),
                TextButton(onPressed: () {}, child: const Text('Change', style: TextStyle(color: AppColors.caramel))),
              ],
            ),
          ),
          const SizedBox(height: 32),
          const Text('Payment Method', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(16)),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: AppColors.lightBeige, borderRadius: BorderRadius.circular(12)),
                  child: const Icon(Icons.credit_card, color: AppColors.coffeeBrown),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Visa **** 4821', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                TextButton(onPressed: () {}, child: const Text('Change', style: TextStyle(color: AppColors.caramel))),
              ],
            ),
          ),
          const SizedBox(height: 48),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OrderSuccessScreen())),
              child: const Text('Place Order'),
            ),
          )
        ],
      ),
    );
  }
}
