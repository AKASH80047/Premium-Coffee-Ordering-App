import 'models.dart';

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
    imageUrl: 'assets/images/cappuccino.jpg',
    category: 'Cappuccino',
  ),
  Coffee(
    id: '2',
    name: 'Caramel Latte',
    description: 'A creamy blend of espresso and steamed milk, flavored with sweet caramel syrup.',
    basePrice: 24.00,
    rating: 4.7,
    imageUrl: 'assets/images/caramel_latte.jpg',
    category: 'Latte',
  ),
  Coffee(
    id: '3',
    name: 'Espresso',
    description: 'A concentrated form of coffee served in small, strong shots.',
    basePrice: 15.00,
    rating: 4.9,
    imageUrl: 'assets/images/espresso.jpg',
    category: 'Espresso',
  ),
  Coffee(
    id: '4',
    name: 'Mocha',
    description: 'A chocolate-flavored warm beverage that is a variant of a caffè latte.',
    basePrice: 26.50,
    rating: 4.6,
    imageUrl: 'assets/images/mocha.jpg',
    category: 'Mocha',
  ),
  Coffee(
    id: '5',
    name: 'Americano',
    description: 'A classic Americano consisting of espresso with hot water, giving it a similar strength to, but different flavor from, traditionally brewed coffee.',
    basePrice: 18.00,
    rating: 4.5,
    imageUrl: 'assets/images/americano.jpg',
    category: 'Americano',
  ),
  Coffee(
    id: '6',
    name: 'Iced Latte',
    description: 'Chilled espresso over ice, mixed with milk and lightly sweetened. Perfect for a hot day.',
    basePrice: 25.00,
    rating: 4.8,
    imageUrl: 'assets/images/iced_latte.jpg',
    category: 'Cold Coffee',
  ),
  Coffee(
    id: '7',
    name: 'Matcha Latte',
    description: 'Smooth and creamy matcha sweetened just right and served with steamed milk.',
    basePrice: 28.50,
    rating: 4.9,
    imageUrl: 'assets/images/matcha_latte.jpg',
    category: 'Tea',
  ),
  Coffee(
    id: '8',
    name: 'Flat White',
    description: 'An espresso-based coffee drink accompanied with steamed milk and microfoam.',
    basePrice: 23.50,
    rating: 4.7,
    imageUrl: 'assets/images/flat_white.jpg',
    category: 'Latte',
  ),
  Coffee(
    id: '9',
    name: 'Macchiato',
    description: 'Espresso coffee drink with a small amount of milk, usually foamed.',
    basePrice: 21.00,
    rating: 4.4,
    imageUrl: 'assets/images/macchiato.jpg',
    category: 'Espresso',
  ),
  Coffee(
    id: '10',
    name: 'Frappuccino',
    description: 'A blended iced coffee drink topped with whipped cream and syrup.',
    basePrice: 32.00,
    rating: 4.8,
    imageUrl: 'assets/images/frappuccino.jpg',
    category: 'Cold Coffee',
  ),
  Coffee(
    id: '11',
    name: 'Chai Tea Latte',
    description: 'Black tea infused with cinnamon, clove and other warming spices is combined with steamed milk.',
    basePrice: 24.50,
    rating: 4.6,
    imageUrl: 'assets/images/chai_tea.jpg',
    category: 'Tea',
  ),
  Coffee(
    id: '12',
    name: 'Nitro Cold Brew',
    description: 'Cold brew coffee infused with nitrogen gas for a creamy, stout-like effect.',
    basePrice: 35.00,
    rating: 4.9,
    imageUrl: 'assets/images/nitro_cold_brew.jpg',
    category: 'Cold Coffee',
  ),
];

// App State (Simple Global State for demo)
class AppState {
  static List<CartItem> cart = [];
  static List<Coffee> favorites = [];
}
