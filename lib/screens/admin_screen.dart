import 'package:aids_feedback_app/data/data.dart';
import 'package:aids_feedback_app/screens/feedback_details_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xff1F1F1F),
        title: const Text(
          'Feedback App',
          style: TextStyle(
            color: Color(0xff97C2EC),
            fontFamily: 'Fredoka',
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(
              Icons.logout,
              color: Color(0xff97C2EC),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Image.asset('assets/images/home_page_image.png'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 9,
                right: 9,
                top: 9,
              ),
              child: ListView(
                children: [
                  Card(
                    color: const Color(0xff97C2EC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => FeedbackDetailsScreen(
                              year: 'second',
                              subjectFaculty: Data().second,
                              sem: 3,
                              class_: 'SY',
                              strength: 39,
                            ),
                          ),
                        );
                      },
                      title: const Text(
                        'Second Year AI&DS',
                        style: TextStyle(
                          fontFamily: 'Fredoka',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: const Color(0xff97C2EC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => FeedbackDetailsScreen(
                              year: 'third',
                              subjectFaculty: Data().third,
                              sem: 5,
                              class_: 'TY',
                              strength: 76,
                            ),
                          ),
                        );
                      },
                      title: const Text(
                        'Third Year AI&DS',
                        style: TextStyle(
                          fontFamily: 'Fredoka',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: const Color(0xff97C2EC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => FeedbackDetailsScreen(
                              year: 'fourth',
                              subjectFaculty: Data().fourth,
                              sem: 7,
                              class_: 'BTech',
                              strength: 74,
                            ),
                          ),
                        );
                      },
                      title: const Text(
                        'BTech AI&DS',
                        style: TextStyle(
                          fontFamily: 'Fredoka',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'OMKAR ',
                style: TextStyle(fontFamily: 'Fredoka'),
              ),
              Text(
                'POL',
                style: TextStyle(
                  fontFamily: 'Fredoka',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
