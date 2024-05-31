
import 'package:hotel_booking/domain/entities/feedback.dart';

abstract class FeedbackRepository {
  Future<List<AppFeedback>> fetchFeedback();
  Future<void> postFeedback(AppFeedback feedback);
}

class FakeFeedbackRepository implements FeedbackRepository {
  @override
  Future<List<AppFeedback>> fetchFeedback() async {
    // Simulate fetching feedback from a backend (dummy data for demonstration)
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    return _fakeFeedbackData;
  }

  @override
  Future<void> postFeedback(AppFeedback feedback) async {
    // Simulate posting feedback to a backend (dummy implementation for demonstration)
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    // In a real implementation, you would send the feedback data to your backend API
    print('Posted feedback: $feedback');
  }
}

// Dummy data for demonstration
final List<AppFeedback> _fakeFeedbackData = [
  AppFeedback(user: 'User1', comment: 'Great app!', rating: 5),
  AppFeedback(user: 'User2', comment: 'Could be better', rating: 3),
  AppFeedback(user: 'User3', comment: 'Needs improvement', rating: 2),
];
