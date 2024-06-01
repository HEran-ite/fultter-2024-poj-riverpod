import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_booking/presentation/providers/feedback_provider.dart';
import 'package:hotel_booking/presentation/providers/user_provider.dart';
import 'package:hotel_booking/presentation/widgets/appbar.dart';
import 'package:hotel_booking/presentation/widgets/drawer.dart';

class FeedbackPage extends ConsumerStatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends ConsumerState<FeedbackPage> {
  final TextEditingController messageController = TextEditingController();
  int feedbackRating = 0;

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void setRating(int rating) {
    setState(() {
      feedbackRating = rating;
    });
  }

  Widget buildRatingIcon(int rating, IconData icon) {
    return IconButton(
      icon: Icon(
        icon,
        color: feedbackRating == rating ? Colors.red : Colors.grey,
      ),
      onPressed: () => setRating(rating),
    );
  }

  @override
  Widget build(BuildContext context) {
    final feedbackList = ref.watch(feedbackProvider);
    final user = ref.watch(userProvider);

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
              child: ListView.builder(
                itemCount: feedbackList.length,
                itemBuilder: (context, index) {
                  final feedback = feedbackList[index];
                  final isOwner = feedback.user == user.name;

                  return ListTile(
                    title: Text(
                      feedback.user,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(feedback.message),
                        Row(
                          children: List.generate(5, (i) {
                            return Icon(
                              i < feedback.rating ? Icons.star : Icons.star_border,
                              color: Colors.amber,
                            );
                          }),
                        ),
                      ],
                    ),
                    trailing: isOwner
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  messageController.text = feedback.message;
                                  setRating(feedback.rating);
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text('Edit Feedback'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
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
                                          Text('Your Message:'),
                                          TextField(
                                            controller: messageController,
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            messageController.clear();
                                          },
                                          child: Text('Cancel'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            final message = messageController.text;

                                            if (message.isEmpty) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text('Please enter your message')),
                                              );
                                              return;
                                            }

                                            ref.read(feedbackProvider.notifier).updateFeedback(
                                                  feedback.id!,
                                                  user.name,
                                                  message,
                                                  feedbackRating,
                                                );

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
                                  ref.read(feedbackProvider.notifier).deleteFeedback(feedback.id!);
                                },
                              ),
                            ],
                          )
                        : null,
                  );
                },
              ),
            ),
            if (user.role != 'admin') ...[
              Text('Add Feedback'),
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
              TextField(
                controller: messageController,
                decoration: InputDecoration(labelText: 'Your Message'),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  final message = messageController.text;

                  if (message.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please enter your message')),
                    );
                    return;
                  }

                  ref.read(feedbackProvider.notifier).postFeedback(
                        user.name,
                        message,
                        feedbackRating,
                      );

                  messageController.clear();
                  setRating(0);
                },
                child: Text('Submit'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}