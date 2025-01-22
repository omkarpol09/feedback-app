import 'package:aids_feedback_app/data/data.dart';
import 'package:aids_feedback_app/providers/selected_options_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeedbackQuestionAndRating extends ConsumerStatefulWidget {
  const FeedbackQuestionAndRating({required this.index, super.key});

  final int index;

  @override
  ConsumerState<FeedbackQuestionAndRating> createState() =>
      _FeedbackQuestionAndRatingState();
}

class _FeedbackQuestionAndRatingState
    extends ConsumerState<FeedbackQuestionAndRating> {
  List<Color> clr = [
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
  ];

  @override
  Widget build(BuildContext context) {
    Map<String, String> studentFeedback = ref.watch(selectedOptionsProvider);

    return SizedBox(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.index}. ${Data().feedbackQuestions['Question${widget.index}']!}',
                style: const TextStyle(
                  fontFamily: 'Fredoka',
                  fontSize: 17,
                ),
              ),
              Text(
                studentFeedback['Question${widget.index}']!,
                style: const TextStyle(
                  fontFamily: 'Fredoka',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        clr[0] = const Color(0xffFFD700);
                        clr[1] = Colors.grey;
                        clr[2] = Colors.grey;
                        clr[3] = Colors.grey;
                        clr[4] = Colors.grey;
                      });
                      ref
                          .read(selectedOptionsProvider.notifier)
                          .setSelectedOption(widget.index, 'Poor');
                    },
                    icon: Icon(
                      Icons.star,
                      size: 33,
                      color: clr[0],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        clr[0] = const Color(0xffFFD700);
                        clr[1] = const Color(0xffFFD700);
                        clr[2] = Colors.grey;
                        clr[3] = Colors.grey;
                        clr[4] = Colors.grey;
                      });
                      ref
                          .read(selectedOptionsProvider.notifier)
                          .setSelectedOption(widget.index, 'Average');
                    },
                    icon: Icon(
                      Icons.star,
                      size: 33,
                      color: clr[1],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        clr[0] = const Color(0xffFFD700);
                        clr[1] = const Color(0xffFFD700);
                        clr[2] = const Color(0xffFFD700);
                        clr[3] = Colors.grey;
                        clr[4] = Colors.grey;
                      });
                      ref
                          .read(selectedOptionsProvider.notifier)
                          .setSelectedOption(widget.index, 'Good');
                    },
                    icon: Icon(
                      Icons.star,
                      size: 33,
                      color: clr[2],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        clr[0] = const Color(0xffFFD700);
                        clr[1] = const Color(0xffFFD700);
                        clr[2] = const Color(0xffFFD700);
                        clr[3] = const Color(0xffFFD700);
                        clr[4] = Colors.grey;
                      });
                      ref
                          .read(selectedOptionsProvider.notifier)
                          .setSelectedOption(widget.index, 'Very Good');
                    },
                    icon: Icon(
                      Icons.star,
                      size: 33,
                      color: clr[3],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        clr[0] = const Color(0xffFFD700);
                        clr[1] = const Color(0xffFFD700);
                        clr[2] = const Color(0xffFFD700);
                        clr[3] = const Color(0xffFFD700);
                        clr[4] = const Color(0xffFFD700);
                      });
                      ref
                          .read(selectedOptionsProvider.notifier)
                          .setSelectedOption(widget.index, 'Excellent');
                    },
                    icon: Icon(
                      Icons.star,
                      size: 33,
                      color: clr[4],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
