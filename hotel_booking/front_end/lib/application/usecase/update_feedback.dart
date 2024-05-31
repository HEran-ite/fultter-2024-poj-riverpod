import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_booking/domain/entities/feedback.dart';
import 'package:hotel_booking/infrastructure/repositories/feedback_repository_impl.dart';
import 'package:hotel_booking/presentation/providers/feedback_provider.dart';

final updateFeedbackProvider = StateNotifierProvider<UpdateFeedbackNotifier, AsyncValue<void>>((ref) {
  final feedbackRepository = ref.watch(feedbackRepositoryProvider);
  return UpdateFeedbackNotifier(feedbackRepository);
});

class UpdateFeedbackNotifier extends StateNotifier<AsyncValue<void>> {
  final FeedbackRepositoryImpl repository;

  UpdateFeedbackNotifier(this.repository) : super(const AsyncData(null));

  Future<void> updateFeedback(AppFeedback feedback) async {
    state = const AsyncLoading();
    try {
      await repository.updateFeedback(feedback);
      state = const AsyncData(null);
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }
}
