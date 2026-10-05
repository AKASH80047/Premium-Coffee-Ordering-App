import 'package:flutter/material.dart';
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
      'image': 'assets/images/cappuccino.jpg'
    },
    {
      'title': 'Choose Your Perfect Size',
      'description': 'Small, Medium or Large — watch your cup change instantly.',
      'image': 'assets/images/mocha.jpg'
    },
    {
      'title': 'Fresh Coffee, Delivered',
      'description': 'Order your favorite coffee and enjoy it wherever you are.',
      'image': 'assets/images/caramel_latte.jpg'
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
                          image: AssetImage(_pages[index]['image']!),
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
