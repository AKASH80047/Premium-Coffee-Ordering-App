class Coffee {
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
