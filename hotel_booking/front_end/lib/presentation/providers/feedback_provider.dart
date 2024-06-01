import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_booking/application/use_cases/feedback_service.dart';
import 'package:hotel_booking/domain/entities/feedback.dart';


final feedbackProvider = StateNotifierProvider<FeedbackNotifier, List<AppFeedback>>((ref) {
  return FeedbackNotifier(ref);
});

class FeedbackNotifier extends StateNotifier<List<AppFeedback>> {
  final Ref _ref;

  FeedbackNotifier(this._ref) : super([]) {
    fetchFeedback();
  }

  Future<void> fetchFeedback() async {
    try {
      final feedbackService = _ref.read(feedbackServiceProvider);
      final response = await feedbackService.fetchFeedback();
      state = response;
      print('Feedback list fetched: ${state.length} items');
      print('Fetched feedback IDs: ${state.map((f) => f.id).toList()}');
    } catch (e) {
      print('Failed to fetch feedback: $e');
    }
  }

  Future<void> postFeedback(String customerName, String message, int rating) async {
    final newFeedback = AppFeedback(
      user: customerName,
      message: message,
      rating: rating,
    );

    try {
      final feedbackService = _ref.read(feedbackServiceProvider);
      await feedbackService.postFeedback(newFeedback);
      await fetchFeedback(); // Ensure the feedback list is refreshed
      print('Feedback posted and list refreshed');
    } catch (e) {
      print('Failed to post feedback: $e');
    }
  }

  Future<void> updateFeedback(String id, String customerName, String message, int rating) async {
    final updatedFeedback = AppFeedback(
      id: id,
      user: customerName,
      message: message,
      rating: rating,
    );

    try {
      final feedbackService = _ref.read(feedbackServiceProvider);
      await feedbackService.updateFeedback(updatedFeedback);
      await fetchFeedback(); // Ensure the feedback list is refreshed
      print('Feedback updated and list refreshed');
    } catch (e) {
      print('Failed to update feedback: $e');
    }
  }

  Future<void> deleteFeedback(String id) async {
    try {
      final feedbackService = _ref.read(feedbackServiceProvider);
      await feedbackService.deleteFeedback(id);
      await fetchFeedback(); // Ensure the feedback list is refreshed
      print('Feedback deleted and list refreshed');
    } catch (e) {
      print('Failed to delete feedback: $e');
    }
  }
}



