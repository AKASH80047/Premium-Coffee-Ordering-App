import os

def write_file(path, content):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, 'w') as f:
        f.write(content)

# lib/core/theme.dart
write_file('lib/core/theme.dart', """import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color coffeeBrown = Color(0xFF6B3F20);
  static const Color darkEspresso = Color(0xFF2B1B12);
  static const Color caramel = Color(0xFFD6A15F);
  static const Color cream = Color(0xFFF8F5F0);
  static const Color lightBeige = Color(0xFFF1E6D8);
  static const Color softGray = Color(0xFFE7E7E7);
  static const Color white = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF2B1B12);
  static const Color textLight = Color(0xFF888888);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.coffeeBrown,
      scaffoldBackgroundColor: AppColors.cream,
      colorScheme: ColorScheme.light(
        primary: AppColors.coffeeBrown,
        secondary: AppColors.caramel,
        surface: AppColors.white,
        background: AppColors.cream,
      ),
      textTheme: GoogleFonts.outfitTextTheme().copyWith(
        displayLarge: GoogleFonts.outfit(color: AppColors.textDark, fontWeight: FontWeight.bold),
        displayMedium: GoogleFonts.outfit(color: AppColors.textDark, fontWeight: FontWeight.bold),
        bodyLarge: GoogleFonts.outfit(color: AppColors.textDark),
        bodyMedium: GoogleFonts.outfit(color: AppColors.textDark),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.cream,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textDark),
        titleTextStyle: TextStyle(color: AppColors.textDark, fontSize: 20, fontWeight: FontWeight.w600),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.coffeeBrown,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          padding: const EdgeInsets.symmetric(vertical: 16),
          elevation: 0,
          textStyle: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
""")

# lib/core/models.dart
write_file('lib/core/models.dart', """class Coffee {
  final String id;
  final String name;
  final String description;
  final double basePrice;
  final double rating;
  final String imageUrl;
  final String category;

  Coffee({
    required this.id,
    required this.name,
    required this.description,
    required this.basePrice,
    required this.rating,
    required this.imageUrl,
    required this.category,
  });
}

class CartItem {
  final Coffee coffee;
  final String size; // 'Small', 'Medium', 'Large'
  final int volume; // 250, 350, 450
  int quantity;
  final double price;

  CartItem({
    required this.coffee,
    required this.size,
    required this.volume,
    this.quantity = 1,
    required this.price,
  });
}
""")

# lib/core/data.dart
write_file('lib/core/data.dart', """import 'models.dart';

final List<String> categories = [
  'All', 'Cappuccino', 'Latte', 'Espresso', 'Americano', 'Mocha', 'Cold Coffee', 'Tea'
];

final List<Coffee> dummyCoffees = [
  Coffee(
    id: '1',
    name: 'Cappuccino',
    description: 'In comparison to a café latte, the perfect cappuccino has a more intense coffee flavor, balanced with smooth steamed milk and creamy foam.',
    basePrice: 22.40,
    rating: 4.8,
    imageUrl: 'https://images.unsplash.com/photo-1572442388796-11668a67e53d?q=80&w=600&auto=format&fit=crop', // Looking down into cup
    category: 'Cappuccino',
  ),
  Coffee(
    id: '2',
    name: 'Caramel Latte',
    description: 'A creamy blend of espresso and steamed milk, flavored with sweet caramel syrup.',
    basePrice: 24.00,
    rating: 4.7,
    imageUrl: 'https://images.unsplash.com/photo-1578314675249-a6910f80cc4e?q=80&w=600&auto=format&fit=crop',
    category: 'Latte',
  ),
  Coffee(
    id: '3',
    name: 'Espresso',
    description: 'A concentrated form of coffee served in small, strong shots.',
    basePrice: 15.00,
    rating: 4.9,
    imageUrl: 'https://images.unsplash.com/photo-1510591509098-f4fdc6d0fd24?q=80&w=600&auto=format&fit=crop',
    category: 'Espresso',
  ),
  Coffee(
    id: '4',
    name: 'Mocha',
    description: 'A chocolate-flavored warm beverage that is a variant of a caffè latte.',
    basePrice: 26.50,
    rating: 4.6,
    imageUrl: 'https://images.unsplash.com/photo-1557006021-b85faa2bc5e2?q=80&w=600&auto=format&fit=crop',
    category: 'Mocha',
  ),
];

// App State (Simple Global State for demo)
class AppState {
  static List<CartItem> cart = [];
  static List<Coffee> favorites = [];
}
""")

# lib/main.dart
write_file('lib/main.dart', """import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/theme.dart';
import 'screens/splash_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const BreworaApp());
}

class BreworaApp extends StatelessWidget {
  const BreworaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brewora',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
""")

# lib/screens/splash_screen.dart
write_file('lib/screens/splash_screen.dart', """import 'package:flutter/material.dart';
import '../core/theme.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    
    _controller.forward();
    
    Future.delayed(const Duration(milliseconds: 2500), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OnboardingScreen()));
    });
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
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.coffee_rounded, size: 80, color: AppColors.coffeeBrown),
                const SizedBox(height: 24),
                Text('BREWORA', style: Theme.of(context).textTheme.displayMedium?.copyWith(letterSpacing: 4, color: AppColors.darkEspresso)),
                const SizedBox(height: 8),
                Text('Your Perfect Cup, Your Perfect Size.', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.caramel, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
""")

# lib/screens/onboarding_screen.dart
write_file('lib/screens/onboarding_screen.dart', """import 'package:flutter/material.dart';
import '../core/theme.dart';
import 'main_navigation.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> _pages = [
    {
      'title': 'Discover Your Perfect Coffee',
      'description': 'Explore handcrafted coffees made for every mood.',
      'image': 'https://images.unsplash.com/photo-1497935586351-b67a49e012bf?q=80&w=600&auto=format&fit=crop'
    },
    {
      'title': 'Choose Your Perfect Size',
      'description': 'Small, Medium or Large — watch your cup change instantly.',
      'image': 'https://images.unsplash.com/photo-1511920170033-f8396924c348?q=80&w=600&auto=format&fit=crop'
    },
    {
      'title': 'Fresh Coffee, Delivered',
      'description': 'Order your favorite coffee and enjoy it wherever you are.',
      'image': 'https://images.unsplash.com/photo-1508424757105-b6d5ad9329d0?q=80&w=600&auto=format&fit=crop'
    }
  ];

  void _nextPage() {
    if (_currentIndex < _pages.length - 1) {
      _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainNavigation()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemCount: _pages.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(_pages[index]['image']!),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, AppColors.cream.withOpacity(0.8), AppColors.cream],
                            stops: const [0.4, 0.8, 1.0],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _pages[index]['title']!,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold, color: AppColors.darkEspresso),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _pages[index]['description']!,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textLight, height: 1.5),
                          ),
                          const SizedBox(height: 48),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            bottom: 48,
            left: 24,
            right: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainNavigation())),
                  child: Text('Skip', style: TextStyle(color: AppColors.textLight, fontSize: 16)),
                ),
                Row(
                  children: List.generate(_pages.length, (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentIndex == index ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentIndex == index ? AppColors.coffeeBrown : AppColors.lightBeige,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  )),
                ),
                ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text(_currentIndex == _pages.length - 1 ? 'Get Started' : 'Next'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
""")

# lib/screens/main_navigation.dart
write_file('lib/screens/main_navigation.dart', """import 'package:flutter/material.dart';
import '../core/theme.dart';
import 'home_screen.dart';
import 'search_screen.dart';
import 'favorites_screen.dart';
import 'orders_screen.dart';
import 'profile_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  
  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const FavoritesScreen(),
    const OrdersScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(color: AppColors.darkEspresso.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, -5)),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavItem(0, Icons.home_rounded, 'Home'),
                _buildNavItem(1, Icons.search_rounded, 'Search'),
                _buildNavItem(2, Icons.favorite_border_rounded, 'Favorites'),
                _buildNavItem(3, Icons.receipt_long_rounded, 'Orders'),
                _buildNavItem(4, Icons.person_outline_rounded, 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.coffeeBrown.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          icon,
          color: isSelected ? AppColors.coffeeBrown : AppColors.softGray,
          size: 28,
        ),
      ),
    );
  }
}
""")

# lib/screens/home_screen.dart
write_file('lib/screens/home_screen.dart', """import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../core/data.dart';
import 'product_detail_screen.dart';
import 'notifications_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage('https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=200&auto=format&fit=crop'),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Location', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textLight)),
                        Row(
                          children: [
                            const Icon(Icons.location_on, size: 16, color: AppColors.coffeeBrown),
                            const SizedBox(width: 4),
                            Text('Los Angeles', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.notifications_outlined, color: AppColors.darkEspresso),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen())),
                )
              ],
            ),
            const SizedBox(height: 24),
            
            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))],
              ),
              child: const TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search coffee, drinks or cafés',
                  hintStyle: TextStyle(color: AppColors.textLight),
                  icon: Icon(Icons.search, color: AppColors.textLight),
                ),
              ),
            ),
            const SizedBox(height: 32),
            
            // Categories
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = category == _selectedCategory;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCategory = category),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.coffeeBrown : AppColors.lightBeige,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          category,
                          style: TextStyle(
                            color: isSelected ? AppColors.white : AppColors.textDark,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 32),
            
            // Hero Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.caramel,
                borderRadius: BorderRadius.circular(24),
                image: DecorationImage(
                  image: const NetworkImage('https://images.unsplash.com/photo-1600093463592-8e36ae95ef56?q=80&w=800&auto=format&fit=crop'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Morning Coffee', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.white, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Start your day with the perfect brew.', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.white.withOpacity(0.9))),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.white,
                      foregroundColor: AppColors.coffeeBrown,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: const Text('Explore Now'),
                  )
                ],
              ),
            ),
            const SizedBox(height: 32),
            
            // Popular Coffees
            Text('Popular Coffee', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SizedBox(
              height: 280,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dummyCoffees.length,
                clipBehavior: Clip.none,
                itemBuilder: (context, index) {
                  final coffee = dummyCoffees[index];
                  return GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(coffee: coffee))),
                    child: Container(
                      width: 180,
                      margin: const EdgeInsets.only(right: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 5))],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Hero(
                            tag: 'coffee_${coffee.id}',
                            child: Container(
                              height: 140,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                  image: NetworkImage(coffee.imageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(coffee.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.star_rounded, color: AppColors.caramel, size: 16),
                              const SizedBox(width: 4),
                              Text('${coffee.rating}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('\$${coffee.basePrice.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.coffeeBrown)),
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: AppColors.coffeeBrown,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.add, color: AppColors.white, size: 20),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
""")

print("Initial files created.")
