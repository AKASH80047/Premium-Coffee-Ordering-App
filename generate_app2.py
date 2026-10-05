import os

def write_file(path, content):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, 'w') as f:
        f.write(content)

# lib/screens/product_detail_screen.dart
write_file('lib/screens/product_detail_screen.dart', """import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../core/models.dart';
import '../core/data.dart';
import 'cart_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final Coffee coffee;

  const ProductDetailScreen({super.key, required this.coffee});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String _selectedSize = 'Medium';
  int _quantity = 1;
  bool _isFavorite = false;

  final Map<String, double> _sizeWidths = {
    'Small': 190.0,
    'Medium': 235.0,
    'Large': 285.0,
  };

  final Map<String, double> _priceMultipliers = {
    'Small': 1.0,
    'Medium': 1.13, // e.g., 22.40 -> 25.40 approx
    'Large': 1.31, // e.g., 22.40 -> 29.40 approx
  };

  final Map<String, int> _volumes = {
    'Small': 250,
    'Medium': 350,
    'Large': 450,
  };

  double get _currentPrice => widget.coffee.basePrice * _priceMultipliers[_selectedSize]!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
              child: Icon(
                _isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                key: ValueKey<bool>(_isFavorite),
                color: _isFavorite ? Colors.red : AppColors.darkEspresso,
              ),
            ),
            onPressed: () => setState(() => _isFavorite = !_isFavorite),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Hero Section with animated cup
          Expanded(
            flex: 4,
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Background card
                  Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      color: AppColors.caramel.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                  ),
                  // Animated Cup Image
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeOutBack,
                    width: _sizeWidths[_selectedSize],
                    height: _sizeWidths[_selectedSize],
                    child: Hero(
                      tag: 'coffee_${widget.coffee.id}',
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            )
                          ],
                          image: DecorationImage(
                            image: NetworkImage(widget.coffee.imageUrl), // Top down view
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Details Section
          Expanded(
            flex: 6,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.lightBeige,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.star_rounded, color: AppColors.caramel, size: 16),
                                  const SizedBox(width: 4),
                                  Text('${widget.coffee.rating}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(widget.coffee.name, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: AppColors.darkEspresso)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Description
                  Text('About', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(
                    widget.coffee.description,
                    style: TextStyle(color: AppColors.textLight, height: 1.5),
                  ),
                  const SizedBox(height: 24),
                  
                  // Size Selector & Volume
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Coffee size', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: Text(
                          '${_volumes[_selectedSize]} ml',
                          key: ValueKey<String>('vol_$_selectedSize'),
                          style: const TextStyle(color: AppColors.caramel, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: ['Small', 'Medium', 'Large'].map((size) {
                      final isSelected = _selectedSize == size;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedSize = size),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.coffeeBrown : AppColors.lightBeige.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Text(
                                size.toUpperCase(),
                                style: TextStyle(
                                  color: isSelected ? AppColors.white : AppColors.textDark,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  
                  const Spacer(),
                  
                  // Bottom Bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Price', style: TextStyle(color: AppColors.textLight)),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: Text(
                              '\$${_currentPrice.toStringAsFixed(2)}',
                              key: ValueKey<String>('price_$_selectedSize'),
                              style: const TextStyle(color: AppColors.coffeeBrown, fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      
                      // Quantity
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.lightBeige,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (_quantity > 1) setState(() => _quantity--);
                              },
                              child: const Icon(Icons.remove, size: 20),
                            ),
                            const SizedBox(width: 16),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
                              child: Text(
                                '$_quantity',
                                key: ValueKey<int>(_quantity),
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                            const SizedBox(width: 16),
                            GestureDetector(
                              onTap: () => setState(() => _quantity++),
                              child: const Icon(Icons.add, size: 20),
                            ),
                          ],
                        ),
                      ),
                      
                      // Buy Button
                      ElevatedButton(
                        onPressed: () {
                          AppState.cart.add(CartItem(
                            coffee: widget.coffee,
                            size: _selectedSize,
                            volume: _volumes[_selectedSize]!,
                            price: _currentPrice,
                            quantity: _quantity,
                          ));
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        ),
                        child: const Text('Buy Now'),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
""")

# lib/screens/cart_screen.dart
write_file('lib/screens/cart_screen.dart', """import 'package:flutter/material.dart';
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
                              image: DecorationImage(image: NetworkImage(item.coffee.imageUrl), fit: BoxFit.cover),
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
""")

# lib/screens/checkout_screen.dart
write_file('lib/screens/checkout_screen.dart', """import 'package:flutter/material.dart';
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
""")

# lib/screens/order_success_screen.dart
write_file('lib/screens/order_success_screen.dart', """import 'package:flutter/material.dart';
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
""")

print("Batch 2 created.")
