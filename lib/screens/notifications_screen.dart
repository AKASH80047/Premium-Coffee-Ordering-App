import 'package:flutter/material.dart';
import '../core/theme.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded), onPressed: () => Navigator.pop(context)),
        title: const Text('Notifications'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text('Today', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 16),
          _buildNotificationCard('Your Cappuccino is being prepared.', '10:05 AM', Icons.coffee),
          _buildNotificationCard('Your order is out for delivery.', '10:15 AM', Icons.delivery_dining),
          const SizedBox(height: 24),
          const Text('Earlier', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 16),
          _buildNotificationCard('20% off your favorite coffee today.', 'Yesterday', Icons.local_offer),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(String title, String time, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: AppColors.lightBeige, borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: AppColors.coffeeBrown),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(time, style: const TextStyle(color: AppColors.textLight, fontSize: 12)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
