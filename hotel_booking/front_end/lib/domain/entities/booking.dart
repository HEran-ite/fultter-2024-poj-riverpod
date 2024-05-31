// lib/domain/entities/booking.dart
class Booking {
  final String? id;
  final String title;
  final String image;
  final String description;
  final int price;
  final DateTime? bookingDate;
  final String? user;

  Booking({
    this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.price,
    this.bookingDate,
    this.user,
  });

  Booking copyWith({DateTime? bookingDate}) {
    return Booking(
      id: id,
      title: title,
      image: image,
      description: description,
      price: price,
      bookingDate: bookingDate ?? this.bookingDate,
      user: user,
    );
  }

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['_id'],
      title: json['title'],
      image: json['image'],
      description: json['description'],
      price: json['price'],
      bookingDate: json['bookingDate'] != null ? DateTime.parse(json['bookingDate']) : null,
      user: json['user'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'image': image,
      'description': description,
      'price': price,
      'bookingDate': bookingDate?.toIso8601String(),
      'user': user,
    };
  }
}
