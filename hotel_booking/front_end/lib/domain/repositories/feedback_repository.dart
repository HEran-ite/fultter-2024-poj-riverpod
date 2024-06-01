import 'package:hotel_booking/domain/entities/feedback.dart';

abstract class FeedbackRepository {
  Future<List<AppFeedback>> fetchFeedback();
  Future<void> postFeedback(AppFeedback feedback);
  Future<void> updateFeedback(AppFeedback feedback);
  Future<void> deleteFeedback(String feedbackId);
}