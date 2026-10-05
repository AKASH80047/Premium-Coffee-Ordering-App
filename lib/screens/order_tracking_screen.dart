import 'package:flutter/material.dart';
import '../core/theme.dart';
import 'main_navigation.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const MainNavigation()), (route) => false),
        ),
        title: const Text('Track Your Order'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Map Placeholder
          Container(
            height: 200,
            width: double.infinity,
            color: AppColors.lightBeige,
            child: const Center(
              child: Icon(Icons.map_rounded, size: 64, color: AppColors.caramel),
            ),
          ),
          
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Estimated Time', style: TextStyle(color: AppColors.textLight)),
                          SizedBox(height: 4),
                          Text('20–30 min', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: AppColors.darkEspresso)),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.coffeeBrown,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(Icons.delivery_dining, color: AppColors.white),
                      )
                    ],
                  ),
                  const SizedBox(height: 32),
                  const Divider(color: AppColors.lightBeige),
                  const SizedBox(height: 32),
                  
                  // Progress Steps
                  _buildStep(context, 'Order Confirmed', '10:00 AM', true, true),
                  _buildStep(context, 'Preparing', '10:05 AM', true, true),
                  _buildStep(context, 'Out for Delivery', 'Driver is picking up your order', true, false),
                  _buildStep(context, 'Delivered', 'Expected by 10:30 AM', false, false, isLast: true),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(BuildContext context, String title, String subtitle, bool isCompleted, bool isCurrent, {bool isLast = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isCompleted ? AppColors.coffeeBrown : AppColors.lightBeige,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isCurrent && !isCompleted ? AppColors.caramel : Colors.transparent,
                  width: 2,
                )
              ),
              child: isCompleted ? const Icon(Icons.check, size: 14, color: AppColors.white) : null,
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: isCompleted ? AppColors.coffeeBrown : AppColors.lightBeige,
              )
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: isCompleted || isCurrent ? AppColors.darkEspresso : AppColors.textLight)),
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(color: AppColors.textLight, fontSize: 12)),
              const SizedBox(height: 24),
            ],
          ),
        )
      ],
    );
  }
}
