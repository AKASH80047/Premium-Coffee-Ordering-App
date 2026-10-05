import 'package:flutter/material.dart';
import '../core/theme.dart';
import 'order_tracking_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.cream,
        appBar: AppBar(
          title: const Text('My Orders'),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: AppColors.coffeeBrown,
            labelColor: AppColors.coffeeBrown,
            unselectedLabelColor: AppColors.textLight,
            tabs: [
              Tab(text: 'Active'),
              Tab(text: 'Past'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildOrderList(context, true),
            _buildOrderList(context, false),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderList(BuildContext context, bool isActive) {
    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: isActive ? 1 : 3,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Order #BRW-${4921 + index}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(isActive ? 'Preparing' : 'Delivered', style: TextStyle(color: isActive ? AppColors.caramel : AppColors.textLight, fontWeight: FontWeight.bold)),
                ],
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Divider(color: AppColors.lightBeige)),
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(image: AssetImage('assets/images/cappuccino.jpg'), fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Cappuccino', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 4),
                        const Text('Medium • 350ml', style: TextStyle(color: AppColors.textLight, fontSize: 12)),
                        const SizedBox(height: 8),
                        Text(isActive ? 'Today, 10:00 AM' : 'Oct 1, 09:30 AM', style: const TextStyle(color: AppColors.textLight, fontSize: 12)),
                      ],
                    ),
                  ),
                  const Text('\$25.40', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.coffeeBrown)),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (isActive) {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const OrderTrackingScreen()));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isActive ? AppColors.coffeeBrown : AppColors.lightBeige,
                    foregroundColor: isActive ? AppColors.white : AppColors.textDark,
                  ),
                  child: Text(isActive ? 'Track Order' : 'Reorder'),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
