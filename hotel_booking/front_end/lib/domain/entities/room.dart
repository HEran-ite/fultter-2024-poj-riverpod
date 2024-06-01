class RoomCategory {
  final String id;
  final String title;
  final String image;
  final String description;
  final int price;
  final String category; // Add this field

  RoomCategory({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.price,
    required this.category, // Add this field
  });

  factory RoomCategory.fromJson(Map<String, dynamic> json) {
    return RoomCategory(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? 0,
      category: json['category'] ?? '', // Add this field
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'image': image,
      'description': description,
      'price': price,
      'category': category, // Add this field
    };
  }
}
