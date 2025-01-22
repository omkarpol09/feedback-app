import 'package:aids_feedback_app/providers/selected_options_provider.dart';
import 'package:aids_feedback_app/widgets/feedback_question_and_rating.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeedbackScreen extends ConsumerWidget {
  const FeedbackScreen({
    required this.subject,
    required this.faculty,
    required this.year,
    required this.branch,
    required this.email,
    required this.index,
    required this.count,
    super.key,
  });

  final String subject;
  final String faculty;
  final String year;
  final String branch;
  final String email;
  final int index;
  final int count;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Map<String, String> studentFeedback = ref.watch(selectedOptionsProvider);

    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 2),
            backgroundColor: Color(0xff1F1F1F),
            content: Text(
              'Submit the feedback.',
              style: TextStyle(
                fontFamily: 'Fredoka',
                color: Color(0xff97C2EC),
              ),
            ),
          ),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subject,
                  style: const TextStyle(
                    fontFamily: 'Fredoka',
                    fontSize: 18,
                  ),
                ),
                Text(
                  '- $faculty',
                  style: const TextStyle(
                    fontFamily: 'Fredoka',
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 10),
                const FeedbackQuestionAndRating(index: 1),
                const FeedbackQuestionAndRating(index: 2),
                const FeedbackQuestionAndRating(index: 3),
                const FeedbackQuestionAndRating(index: 4),
                const FeedbackQuestionAndRating(index: 5),
                const FeedbackQuestionAndRating(index: 6),
                const FeedbackQuestionAndRating(index: 7),
                const FeedbackQuestionAndRating(index: 8),
                const FeedbackQuestionAndRating(index: 9),
                const FeedbackQuestionAndRating(index: 10),
                const FeedbackQuestionAndRating(index: 11),
                const FeedbackQuestionAndRating(index: 12),
                const FeedbackQuestionAndRating(index: 13),
                const FeedbackQuestionAndRating(index: 14),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      backgroundColor: const WidgetStatePropertyAll(
                        Color(0xff97C2EC),
                      ),
                    ),
                    onPressed: () {
                      if (studentFeedback.values.toList().contains('')) {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(seconds: 2),
                            backgroundColor: Color(0xff1F1F1F),
                            content: Text(
                              'All fields are required.',
                              style: TextStyle(
                                fontFamily: 'Fredoka',
                                color: Color(0xff97C2EC),
                              ),
                            ),
                          ),
                        );
                        return;
                      }

                      FirebaseFirestore.instance
                          .collection('Students')
                          .doc(email)
                          .update({
                        'Subject${index + 1}': true,
                        'count': count + 1,
                      });

                      FirebaseFirestore.instance
                          .collection('$branch-$year')
                          .doc(email)
                          .update({
                        'Subject${index + 1}': studentFeedback,
                      });

                      Navigator.of(context).pop();

                      ref
                          .read(selectedOptionsProvider.notifier)
                          .initializeList();
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontFamily: 'Fredoka'),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
