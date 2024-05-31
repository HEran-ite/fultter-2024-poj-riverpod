class RoomCategory {
  final String id;
  final String title;
  final List<String> images;
  final List<String> descriptions;
  final List<int> prices;

  RoomCategory({
    required this.id,
    required this.title,
    required this.images,
    required this.descriptions,
    required this.prices,
  });

  RoomCategory copyWith({
    String? id,
    String? title,
    List<String>? images,
    List<String>? descriptions,
    List<int>? prices,
  }) {
    return RoomCategory(
      id: id ?? this.id,
      title: title ?? this.title,
      images: images ?? this.images,
      descriptions: descriptions ?? this.descriptions,
      prices: prices ?? this.prices,
    );
  }

  factory RoomCategory.fromJson(Map<String, dynamic> json) {
    return RoomCategory(
      id: json['_id'],
      title: json['title'],
      images: List<String>.from(json['images']),
      descriptions: List<String>.from(json['descriptions']),
      prices: List<int>.from(json['prices'].map((price) => int.parse(price.toString()))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'images': images,
      'descriptions': descriptions,
      'prices': prices.map((price) => price.toString()).toList(),
    };
  }
}
