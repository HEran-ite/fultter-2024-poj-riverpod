// domain/entities/feedback.dart
class AppFeedback {
  final String? id;
  final String user;
  final String comment;
  final int rating;

  AppFeedback({
    this.id,
    required this.user,
    required this.comment,
    required this.rating,
  });

  factory AppFeedback.fromJson(Map<String, dynamic> json) {
    return AppFeedback(
      id: json['_id'],
      user: json['user'],
      comment: json['comment'],
      rating: json['rating'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'comment': comment,
      'rating': rating,
    };
  }
}
