class AppFeedback {
  final String? id;
  final String user;
  final String message;
  final int rating;

  AppFeedback({
    this.id,
    required this.user,
    required this.message,
    required this.rating,
  });

  factory AppFeedback.fromJson(Map<String, dynamic> json) {
    return AppFeedback(
      id: json['_id'],
      user: json['customerName'],
      message: json['message'],
      rating: json['rating'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'customerName': user,
      'message': message,
      'rating': rating,
    };
  }
}