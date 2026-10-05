import '../core/app_state.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../core/data.dart';
import '../core/models.dart';
import 'product_detail_screen.dart';
import 'notifications_screen.dart';
import 'search_screen.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'All';
  bool _isGrid = true;
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  final PageController _bannerController = PageController();
  Timer? _bannerTimer;
  int _currentBannerIndex = 0;

  final List<Map<String, String>> _banners = [
    {
      'image': 'assets/images/cappuccino.jpg',
      'title': 'Morning Coffee',
      'subtitle': 'Start your day with\nthe perfect brew.',
    },
    {
      'image': 'assets/images/espresso.jpg',
      'title': 'Strong Espresso',
      'subtitle': 'Need a quick boost?\nTry our classic espresso.',
    },
    {
      'image': 'assets/images/caramel_latte.jpg',
      'title': 'Sweet Caramel',
      'subtitle': 'Indulge in a rich\ncaramel latte today.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _bannerTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_bannerController.hasClients) {
        int nextIndex = _currentBannerIndex + 1;
        if (nextIndex >= _banners.length) {
          nextIndex = 0;
        }
        _bannerController.animateToPage(
          nextIndex,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _bannerController.dispose();
    super.dispose();
  }

  final Map<String, IconData> _categoryIcons = {
    'All': Icons.coffee_rounded,
    'Cappuccino': Icons.local_cafe_rounded,
    'Latte': Icons.emoji_food_beverage_rounded,
    'Espresso': Icons.coffee_maker_outlined,
    'Americano': Icons.local_drink_rounded,
    'Mocha': Icons.blender_rounded,
    'Cold Coffee': Icons.ac_unit_rounded,
    'Tea': Icons.emoji_food_beverage_outlined,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF8F5F0,
      ), // Explicitly required background color
      body: SafeArea(
        child: ListenableBuilder(
          listenable: BreworaState(),
          builder: (context, _) {
            final appState = BreworaState();

            // Filter coffees based on category
            List<Coffee> filteredCoffees = dummyCoffees;
            if (_selectedCategory != 'All') {
              filteredCoffees = dummyCoffees
                  .where(
                    (c) =>
                        c.name.contains(_selectedCategory) ||
                        _selectedCategory.contains(c.name),
                  )
                  .toList();
              // Fallback if strict name matching yields nothing (for dummy data purposes)
              if (filteredCoffees.isEmpty) filteredCoffees = dummyCoffees;
            }

            return ListView(
              // THIS padding enforces the strict 24px gap on BOTH left and right sides of the entire screen
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              children: [
                // 1. Top Header: Search and Profile Picker
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Search Bar
                    Expanded(
                      child: Container(
                        height: 56,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search coffee...',
                            hintStyle: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 15,
                            ),
                            prefixIcon: Icon(
                              Icons.search_rounded,
                              color: Colors.grey.shade600,
                              size: 22,
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: IconButton(
                                icon: Icon(
                                  Icons.tune_rounded,
                                  color: Colors.grey.shade600,
                                  size: 22,
                                ),
                                onPressed: () {},
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 17),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Profile Image Picker
                    GestureDetector(
                      onTap: _pickImage,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.cream,
                              image: DecorationImage(
                                image: _profileImage != null 
                                    ? FileImage(_profileImage!) as ImageProvider
                                    : const NetworkImage('https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=100&q=80'),
                                fit: BoxFit.cover,
                              ),
                              border: Border.all(color: Colors.white, width: 2),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppColors.coffeeBrown,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              color: Colors.white,
                              size: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // 3. Category Section
                SizedBox(
                  height: 44,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    // No horizontal padding, no clipBehavior. It will clip at the ListView parent bounds perfectly.
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final isSelected = category == _selectedCategory;
                      final iconData = _categoryIcons[category] ?? Icons.coffee;

                      return GestureDetector(
                        onTap: () {
                          if (mounted)
                            setState(() => _selectedCategory = category);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeInOut,
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF6B3F20)
                                : const Color(0xFFF1E6D8),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                iconData,
                                size: 18,
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xFF6B3F20),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                category,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : const Color(0xFF211B18),
                                  fontWeight: isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 32),

                // 4. Hero Banner
                SizedBox(
                  height: 220,
                  width: double.infinity,
                  child: PageView.builder(
                    controller: _bannerController,
                    onPageChanged: (index) {
                      if (mounted) {
                        setState(() {
                          _currentBannerIndex = index;
                        });
                      }
                    },
                    itemCount: _banners.length,
                    itemBuilder: (context, index) {
                      final banner = _banners[index];
                      return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            image: DecorationImage(
                              image: AssetImage(banner['image']!),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Paging dots
                                Row(
                                  children: List.generate(_banners.length, (
                                    dotIndex,
                                  ) {
                                    final isActive =
                                        dotIndex == _currentBannerIndex;
                                    return AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      margin: const EdgeInsets.only(right: 6),
                                      width: isActive ? 24 : 12,
                                      height: 4,
                                      decoration: BoxDecoration(
                                        color: isActive
                                            ? Colors.white
                                            : Colors.white.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(2),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withValues(alpha: 0.3),
                                            blurRadius: 2,
                                            offset: const Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                        );
                    },
                  ),
                ),
                const SizedBox(height: 32),

                // 5. Popular Coffee Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Popular Coffee',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF211B18),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: Icon(
                            _isGrid
                                ? Icons.view_list_rounded
                                : Icons.grid_view_rounded,
                            color: const Color(0xFF75451F),
                            size: 20,
                          ),
                          onPressed: () {
                            setState(() {
                              _isGrid = !_isGrid;
                            });
                          },
                        ),
                        const SizedBox(width: 8),
                        TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SearchScreen(),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'See all',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF75451F),
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right_rounded,
                            color: Color(0xFF75451F),
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

                // 6. Vertical Grid Product Cards
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _isGrid ? 2 : 1,
                    mainAxisSpacing: 24,
                    crossAxisSpacing: 16,
                    childAspectRatio: _isGrid ? 0.52 : 1.0,
                  ),
                  itemCount: filteredCoffees.length,
                  padding: const EdgeInsets.only(bottom: 32, top: 4),
                  itemBuilder: (context, index) {
                      final coffee = filteredCoffees[index];
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailScreen(coffee: coffee),
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.zero,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Product Image
                              Stack(
                                children: [
                                  Hero(
                                    tag: 'coffee_${coffee.id}',
                                    child: Container(
                                      height: _isGrid ? 140 : 180,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          image: AssetImage(coffee.imageUrl),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Heart Icon
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: GestureDetector(
                                      onTap: () =>
                                          appState.toggleFavorite(coffee.id),
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                0.1,
                                              ),
                                              blurRadius: 8,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Icon(
                                          appState.isFavorite(coffee.id)
                                              ? Icons.favorite_rounded
                                              : Icons.favorite_border_rounded,
                                          color: appState.isFavorite(coffee.id)
                                              ? const Color(0xFFD6A15F)
                                              : Colors.grey.shade400,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),

                              // Product Details
                              Text(
                                coffee.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18,
                                  color: Color(0xFF211B18),
                                ),
                              ),
                              const SizedBox(height: 4),

                              // Rating
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star_rounded,
                                    color: Color(0xFFF6A429),
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${coffee.rating}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 13,
                                      color: Color(0xFF211B18),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '(320)',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),

                              // Subtitle
                              Text(
                                coffee.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade500,
                                  height: 1.3,
                                ),
                              ),

                              const SizedBox(height: 12),

                              // Price and Add Button
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '\$${coffee.basePrice.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 20,
                                      color: Color(0xFF211B18),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // Optional direct add to cart logic here
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            '${coffee.name} added to cart!',
                                          ),
                                          duration: const Duration(seconds: 1),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF6B3F20),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.add_rounded,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                const SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
    );
  }
}
