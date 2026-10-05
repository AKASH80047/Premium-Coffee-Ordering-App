import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../core/models.dart';
import '../core/data.dart';
import '../core/app_state.dart';
import 'cart_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final Coffee? coffee;

  const ProductDetailScreen({super.key, this.coffee});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String _selectedSize = 'M';
  int _quantity = 1;

  final Map<String, double> _sizeWidths = {
    'S': 180.0,
    'M': 220.0,
    'L': 260.0,
  };

  final Map<String, int> _volumes = {
    'S': 250,
    'M': 350,
    'L': 450,
  };

  double get _currentPrice {
    if (_selectedSize == 'S') return widget.coffee!.basePrice * 0.85;
    if (_selectedSize == 'M') return widget.coffee!.basePrice;
    return widget.coffee!.basePrice * 1.25;
  }
  
  double get _originalPrice => _currentPrice * 1.15; // Fake a discount

  @override
  Widget build(BuildContext context) {
    final textColor = AppColors.darkEspresso;

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Curved Top Header with Dynamic Cup
                SizedBox(
                  height: 380,
                  child: Stack(
                    children: [
                      // The brown background with bottom curve
                      ClipPath(
                        clipper: TopCurveClipper(),
                        child: Container(
                          width: double.infinity,
                          height: 340,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColors.darkEspresso,
                                AppColors.coffeeBrown,
                              ],
                            ),
                          ),
                        ),
                      ),
                      
                      // Top Action Buttons
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              _buildFavoriteButton(widget.coffee!.id),
                            ],
                          ),
                        ),
                      ),
                      
                      // The dynamically resizing cup!
                      Positioned(
                        top: 100,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 350),
                            curve: Curves.easeOutBack,
                            width: _sizeWidths[_selectedSize],
                            height: _sizeWidths[_selectedSize],
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(widget.coffee!.imageUrl),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(1000), // Perfect circle
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.15),
                                  blurRadius: 30,
                                  spreadRadius: 5,
                                  offset: const Offset(0, 15),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      
                      // Rating Pill
                      Positioned(
                        left: 24,
                        bottom: 30,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 15, offset: const Offset(0, 5)),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.star_rounded, color: AppColors.caramel, size: 18),
                              const SizedBox(width: 6),
                              Text('4.3', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: textColor)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Details Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and Price
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.coffee!.name,
                                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: textColor, letterSpacing: -0.5),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  '\$${_originalPrice.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: AppColors.textLight.withOpacity(0.6),
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: AppColors.textLight.withOpacity(0.6),
                                    decorationThickness: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '\$${_currentPrice.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: textColor, letterSpacing: -0.5),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 12),
                      
                      // Subtitle
                      Text(
                        widget.coffee!.description,
                        style: TextStyle(fontSize: 16, color: AppColors.textLight, height: 1.6, fontWeight: FontWeight.w400),
                      ),
                      
                      const SizedBox(height: 36),
                      
                      // Coffee Size Header
                      Text('Coffee size', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: textColor)),
                      const SizedBox(height: 16),
                      
                      // Coffee Size Blocks
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: ['S', 'M', 'L'].map((size) {
                          final isSelected = _selectedSize == size;
                          final price = size == 'S' ? widget.coffee!.basePrice * 0.85 : size == 'M' ? widget.coffee!.basePrice : widget.coffee!.basePrice * 1.25;
                          
                          return Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _selectedSize = size),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOutCubic,
                                margin: EdgeInsets.only(right: size == 'L' ? 0 : 16),
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                decoration: BoxDecoration(
                                  color: isSelected ? AppColors.coffeeBrown : AppColors.white,
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(color: isSelected ? Colors.transparent : AppColors.softGray, width: 1.5),
                                  boxShadow: isSelected
                                      ? [BoxShadow(color: AppColors.coffeeBrown.withValues(alpha: 0.3), blurRadius: 15, offset: const Offset(0, 8))]
                                      : [],
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      size == 'S' ? 'Small' : size == 'M' ? 'Medium' : 'Large',
                                      style: TextStyle(
                                        color: isSelected ? Colors.white : textColor,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${_volumes[size]} ml',
                                      style: TextStyle(
                                        color: isSelected ? Colors.white.withOpacity(0.8) : AppColors.textLight,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      '\$${price.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        color: isSelected ? Colors.white : textColor,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // About Header
                      Text('About', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: textColor)),
                      const SizedBox(height: 12),
                      
                      // About Text
                      RichText(
                        text: TextSpan(
                          style: TextStyle(fontSize: 16, color: AppColors.textLight, height: 1.6, fontFamily: 'Outfit'),
                          children: [
                            const TextSpan(text: 'In comparison to a café latte, the perfect cappuccino has a more intense coffee flavor, balanced with smooth steamed milk... '),
                            TextSpan(
                              text: 'Read more',
                              style: TextStyle(color: AppColors.coffeeBrown, fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 40),
                      
                      // Quantity Selector (Ultra Premium)
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (_quantity > 1) setState(() => _quantity--);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(color: AppColors.lightBeige, shape: BoxShape.circle),
                                child: Icon(Icons.remove, size: 28, color: textColor),
                              ),
                            ),
                            const SizedBox(width: 32),
                            Text(
                              '$_quantity',
                              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24, color: textColor),
                            ),
                            const SizedBox(width: 32),
                            GestureDetector(
                              onTap: () => setState(() => _quantity++),
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(color: AppColors.lightBeige, shape: BoxShape.circle),
                                child: Icon(Icons.add, size: 28, color: textColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Bottom Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
              decoration: BoxDecoration(
                color: AppColors.cream,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.cream.withOpacity(0.8), AppColors.cream],
                  stops: const [0.0, 0.4],
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (widget.coffee != null) {
                      AppState.cart.add(CartItem(
                        coffee: widget.coffee!,
                        size: _selectedSize == 'S' ? 'Small' : _selectedSize == 'M' ? 'Medium' : 'Large',
                        volume: _volumes[_selectedSize]!,
                        price: _currentPrice,
                        quantity: _quantity,
                      ));
                    }
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.coffeeBrown,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 22),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 10,
                    shadowColor: AppColors.coffeeBrown.withValues(alpha: 0.5),
                  ),
                  child: const Text(
                    'Buy Now',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, letterSpacing: 0.5),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopIcon(IconData icon, VoidCallback onTap) {
    // If it's the back arrow, use a more modern chevron
    final displayIcon = icon == Icons.arrow_back ? Icons.arrow_back_ios_new_rounded : icon;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 1),
        ),
        child: Icon(displayIcon, color: Colors.white, size: 22),
      ),
    );
  }

  Widget _buildFavoriteButton(String coffeeId) {
    return ListenableBuilder(
      listenable: BreworaState(),
      builder: (context, _) {
        final isFav = BreworaState().isFavorite(coffeeId);
        return GestureDetector(
          onTap: () {
            BreworaState().toggleFavorite(coffeeId);
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 1),
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Icon(
                isFav ? Icons.favorite : Icons.favorite_border_rounded,
                key: ValueKey<bool>(isFav),
                color: isFav ? AppColors.caramel : Colors.white,
                size: 22,
              ),
            ),
          ),
        );
      },
    );
  }
}

class TopCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(size.width / 2, size.height + 40, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
