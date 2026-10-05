import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models.dart';
import 'data.dart';

class UserProfile {
  String name;
  String email;
  String phone;
  String address;
  String? photoPath;

  UserProfile({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    this.photoPath,
  });
}

class BreworaState extends ChangeNotifier {
  static final BreworaState _instance = BreworaState._internal();
  factory BreworaState() => _instance;
  BreworaState._internal();

  bool _isInitialized = false;
  late SharedPreferences _prefs;

  // State
  Set<String> _favoriteCoffeeIds = {};
  List<CartItem> _cart = [];
  bool _isDarkMode = false;
  
  UserProfile _userProfile = UserProfile(
    name: 'Alex Johnson',
    email: 'alex@example.com',
    phone: '+91 9876543210',
    address: '123 Coffee Street',
  );

  // Getters
  bool get isInitialized => _isInitialized;
  Set<String> get favoriteCoffeeIds => _favoriteCoffeeIds;
  List<CartItem> get cart => _cart;
  bool get isDarkMode => _isDarkMode;
  UserProfile get userProfile => _userProfile;

  List<Coffee> get favoriteCoffees {
    return dummyCoffees.where((c) => _favoriteCoffeeIds.contains(c.id)).toList();
  }

  // Initialization
  Future<void> init() async {
    if (_isInitialized) return;
    _prefs = await SharedPreferences.getInstance();
    
    // Load favorites
    List<String>? favs = _prefs.getStringList('favorites');
    if (favs != null) {
      _favoriteCoffeeIds = favs.toSet();
    }

    // Load profile
    _userProfile.name = _prefs.getString('profile_name') ?? 'Alex Johnson';
    _userProfile.email = _prefs.getString('profile_email') ?? 'alex@example.com';
    _userProfile.phone = _prefs.getString('profile_phone') ?? '+91 9876543210';
    _userProfile.address = _prefs.getString('profile_address') ?? '123 Coffee Street';
    _userProfile.photoPath = _prefs.getString('profile_photo');
    
    // Load theme
    _isDarkMode = _prefs.getBool('is_dark_mode') ?? false;

    _isInitialized = true;
    notifyListeners();
  }

  // Actions - Favorites
  bool isFavorite(String coffeeId) => _favoriteCoffeeIds.contains(coffeeId);

  void toggleFavorite(String coffeeId) {
    if (_favoriteCoffeeIds.contains(coffeeId)) {
      _favoriteCoffeeIds.remove(coffeeId);
    } else {
      _favoriteCoffeeIds.add(coffeeId);
    }
    _prefs.setStringList('favorites', _favoriteCoffeeIds.toList());
    notifyListeners();
  }

  // Actions - Profile
  void updateProfile({
    required String name,
    required String email,
    required String phone,
    required String address,
  }) {
    _userProfile.name = name;
    _userProfile.email = email;
    _userProfile.phone = phone;
    _userProfile.address = address;
    
    _prefs.setString('profile_name', name);
    _prefs.setString('profile_email', email);
    _prefs.setString('profile_phone', phone);
    _prefs.setString('profile_address', address);
    
    notifyListeners();
  }

  void updateProfilePhoto(String? path) {
    _userProfile.photoPath = path;
    if (path == null) {
      _prefs.remove('profile_photo');
    } else {
      _prefs.setString('profile_photo', path);
    }
    notifyListeners();
  }

  // Actions - Cart
  void addToCart(CartItem item) {
    _cart.add(item);
    notifyListeners();
  }

  void removeFromCart(int index) {
    _cart.removeAt(index);
    notifyListeners();
  }

  void updateCartQuantity(int index, int newQuantity) {
    _cart[index].quantity = newQuantity;
    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  // Actions - Theme
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _prefs.setBool('is_dark_mode', _isDarkMode);
    notifyListeners();
  }
}
