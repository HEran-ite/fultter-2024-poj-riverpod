// presentation/providers/feedback_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_booking/domain/entities/feedback.dart';
import 'package:hotel_booking/infrastructure/api/feedback_api_provider.dart';
import 'package:hotel_booking/infrastructure/repositories/feedback_repository_impl.dart';

// Feedback repository provider
final feedbackRepositoryProvider = Provider<FeedbackRepositoryImpl>((ref) {
  final feedbackRemoteDataSource = ref.watch(feedbackRemoteDataSourceProvider);
  return FeedbackRepositoryImpl(feedbackRemoteDataSource);
});

final feedbackRemoteDataSourceProvider = Provider<FeedbackRemoteDataSource>((ref) {
  return FeedbackRemoteDataSource('http://localhost:3000'); // Change to your backend URL
});

final feedbackListProvider = FutureProvider<List<AppFeedback>>((ref) async {
  final feedbackRepository = ref.watch(feedbackRepositoryProvider);
  return feedbackRepository.fetchFeedback();
});

class RatingNotifier extends StateNotifier<int> {
  RatingNotifier() : super(0);

  void setRating(int newRating) {
    state = newRating;
  }
}

final feedbackRatingProvider = StateNotifierProvider<RatingNotifier, int>((ref) {
  return RatingNotifier();
});

class PostFeedbackNotifier extends StateNotifier<AsyncValue<void>> {
  final FeedbackRepositoryImpl feedbackRepository;

  PostFeedbackNotifier(this.feedbackRepository) : super(const AsyncData(null));

  Future<void> postFeedback(AppFeedback feedback) async {
    state = const AsyncLoading();
    try {
      await feedbackRepository.postFeedback(feedback);
      state = const AsyncData(null);
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }
}

final postFeedbackProvider = StateNotifierProvider<PostFeedbackNotifier, AsyncValue<void>>((ref) {
  final feedbackRepository = ref.watch(feedbackRepositoryProvider);
  return PostFeedbackNotifier(feedbackRepository);
});

class UpdateFeedbackNotifier extends StateNotifier<AsyncValue<void>> {
  final FeedbackRepositoryImpl feedbackRepository;

  UpdateFeedbackNotifier(this.feedbackRepository) : super(const AsyncData(null));

  Future<void> updateFeedback(AppFeedback feedback) async {
    state = const AsyncLoading();
    try {
      await feedbackRepository.updateFeedback(feedback);
      state = const AsyncData(null);
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }
}

final updateFeedbackProvider = StateNotifierProvider<UpdateFeedbackNotifier, AsyncValue<void>>((ref) {
  final feedbackRepository = ref.watch(feedbackRepositoryProvider);
  return UpdateFeedbackNotifier(feedbackRepository);
});

class DeleteFeedbackNotifier extends StateNotifier<AsyncValue<void>> {
  final FeedbackRepositoryImpl feedbackRepository;

  DeleteFeedbackNotifier(this.feedbackRepository) : super(const AsyncData(null));

  Future<void> deleteFeedback(String feedbackId) async {
    state = const AsyncLoading();
    try {
      await feedbackRepository.deleteFeedback(feedbackId);
      state = const AsyncData(null);
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }
}

final deleteFeedbackProvider = StateNotifierProvider<DeleteFeedbackNotifier, AsyncValue<void>>((ref) {
  final feedbackRepository = ref.watch(feedbackRepositoryProvider);
  return DeleteFeedbackNotifier(feedbackRepository);
});
