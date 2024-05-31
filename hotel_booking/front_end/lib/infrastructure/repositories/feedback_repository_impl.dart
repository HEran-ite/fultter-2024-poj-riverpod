// infrastructure/repositories/feedback_repository_impl.dart

import 'package:hotel_booking/domain/entities/feedback.dart';
import 'package:hotel_booking/infrastructure/api/feedback_api_provider.dart';

class FeedbackRepositoryImpl {
  final FeedbackRemoteDataSource remoteDataSource;

  FeedbackRepositoryImpl(this.remoteDataSource);

  Future<List<AppFeedback>> fetchFeedback() async {
    try {
      return await remoteDataSource.fetchFeedback();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> postFeedback(AppFeedback feedback) async {
    try {
      await remoteDataSource.postFeedback(feedback);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateFeedback(AppFeedback feedback) async {
    try {
      await remoteDataSource.updateFeedback(feedback);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteFeedback(String feedbackId) async {
    try {
      await remoteDataSource.deleteFeedback(feedbackId);
    } catch (e) {
      rethrow;
    }
  }
}
