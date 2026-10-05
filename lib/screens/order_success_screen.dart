import 'package:flutter/material.dart';
import '../core/theme.dart';
import 'order_tracking_screen.dart';
import 'main_navigation.dart';

class OrderSuccessScreen extends StatefulWidget {
  const OrderSuccessScreen({super.key});

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                    color: AppColors.coffeeBrown,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check_rounded, color: AppColors.white, size: 64),
                ),
              ),
              const SizedBox(height: 32),
              Text('Order Confirmed!', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: AppColors.darkEspresso)),
              const SizedBox(height: 16),
              const Text('Your coffee is being prepared.', style: TextStyle(color: AppColors.textLight, fontSize: 16)),
              const SizedBox(height: 48),
              
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Order ID', style: TextStyle(color: AppColors.textLight)),
                        Text('#BRW-4921', style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 16), child: Divider(color: AppColors.lightBeige)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Estimated delivery', style: TextStyle(color: AppColors.textLight)),
                        Text('20–30 min', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.caramel)),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OrderTrackingScreen())),
                  child: const Text('Track Order'),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const MainNavigation()), (route) => false);
                },
                child: const Text('Back to Home', style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
