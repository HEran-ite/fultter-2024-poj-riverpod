// presentation/pages/feedback_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_booking/domain/entities/feedback.dart';
import 'package:hotel_booking/presentation/providers/feedback_provider.dart';
import 'package:hotel_booking/presentation/widgets/appbar.dart';
import 'package:hotel_booking/presentation/widgets/drawer.dart';


class FeedbackPage extends ConsumerWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedbackListAsyncValue = ref.watch(feedbackListProvider);
    final feedbackRatingNotifier = ref.watch(feedbackRatingProvider.notifier);
    final feedbackRating = ref.watch(feedbackRatingProvider);
    final userController = TextEditingController();
    final commentController = TextEditingController();
    final currentUser = "currentUser"; // Replace with actual current user logic

    Widget buildRatingIcon(int rating, IconData icon) {
      return IconButton(
        icon: Icon(
          icon,
          color: feedbackRating == rating ? Colors.red : Colors.grey,
        ),
        onPressed: () => feedbackRatingNotifier.setRating(rating),
      );
    }

    return Scaffold(
      appBar: AppAppBar(),
      drawer: AppDrawer(),
      backgroundColor: const Color.fromARGB(255, 252, 241, 230),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: feedbackListAsyncValue.when(
                data: (feedbackList) {
                  return ListView.builder(
                    itemCount: feedbackList.length,
                    itemBuilder: (context, index) {
                      final feedback = feedbackList[index];
                      final isOwner = feedback.user == currentUser;

                      return ListTile(
                        title: Text(feedback.comment),
                        subtitle: Text(feedback.user),
                        trailing: isOwner
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      userController.text = feedback.user;
                                      commentController.text = feedback.comment;
                                      feedbackRatingNotifier.setRating(feedback.rating);
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text('Edit Feedback'),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text('Your Name:'),
                                              TextField(
                                                controller: userController,
                                              ),
                                              SizedBox(height: 8),
                                              Text('Your Comment:'),
                                              TextField(
                                                controller: commentController,
                                              ),
                                              SizedBox(height: 8),
                                              Text('Your Rating:'),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  buildRatingIcon(1, Icons.sentiment_very_dissatisfied),
                                                  buildRatingIcon(2, Icons.sentiment_dissatisfied),
                                                  buildRatingIcon(3, Icons.sentiment_neutral),
                                                  buildRatingIcon(4, Icons.sentiment_satisfied),
                                                  buildRatingIcon(5, Icons.sentiment_very_satisfied),
                                                ],
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                userController.clear();
                                                commentController.clear();
                                              },
                                              child: Text('Cancel'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                final user = userController.text;
                                                final comment = commentController.text;

                                                if (user.isEmpty || comment.isEmpty) {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(content: Text('Please enter your name and comment')),
                                                  );
                                                  return;
                                                }

                                                final updatedFeedback = AppFeedback(
                                                  id: feedback.id,
                                                  user: user,
                                                  comment: comment,
                                                  rating: feedbackRating,
                                                );

                                                ref.read(updateFeedbackProvider.notifier).updateFeedback(updatedFeedback).then((_) {
                                                  ref.refresh(feedbackListProvider); // Refresh the feedback list
                                                  userController.clear();
                                                  commentController.clear();
                                                  feedbackRatingNotifier.setRating(0);
                                                });

                                                Navigator.pop(context);
                                              },
                                              child: Text('Update'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      ref.read(deleteFeedbackProvider.notifier).deleteFeedback(feedback.id!).then((_) {
                                        ref.refresh(feedbackListProvider); // Refresh the feedback list
                                      });
                                    },
                                  ),
                                ],
                              )
                            : null,
                      );
                    },
                  );
                },
                loading: () => Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(child: Text('Error: $err')),
              ),
            ),
            Text('Add Feedback'),
            TextField(
              controller: userController,
              decoration: InputDecoration(labelText: 'Your Name'),
            ),
            TextField(
              controller: commentController,
              decoration: InputDecoration(labelText: 'Your Comment'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildRatingIcon(1, Icons.sentiment_very_dissatisfied),
                buildRatingIcon(2, Icons.sentiment_dissatisfied),
                buildRatingIcon(3, Icons.sentiment_neutral),
                buildRatingIcon(4, Icons.sentiment_satisfied),
                buildRatingIcon(5, Icons.sentiment_very_satisfied),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                final user = userController.text;
                final comment = commentController.text;

                if (user.isEmpty || comment.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter your name and comment')),
                  );
                  return;
                }

                final feedback = AppFeedback(
                  user: user,
                  comment: comment,
                  rating: feedbackRating,
                );

                ref.read(postFeedbackProvider.notifier).postFeedback(feedback).then((_) {
                  ref.refresh(feedbackListProvider); // Refresh the feedback list
                  userController.clear();
                  commentController.clear();
                  feedbackRatingNotifier.setRating(0);
                });
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
