import 'package:aids_feedback_app/data/data.dart';
import 'package:aids_feedback_app/screens/feedback_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StudentScreen extends StatelessWidget {
  const StudentScreen({required this.email, super.key});

  final String email;

  @override
  Widget build(BuildContext context) {
    late dynamic facultyData;
    late int count;

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
              if (count == 5) {
                FirebaseAuth.instance.signOut();
              } else {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    duration: Duration(seconds: 2),
                    backgroundColor: Color(0xff1F1F1F),
                    content: Text(
                      'Logout after completing feedback.',
                      style: TextStyle(
                        fontFamily: 'Fredoka',
                        color: Color(0xff97C2EC),
                      ),
                    ),
                  ),
                );
              }
            },
            icon: const Icon(
              Icons.logout,
              color: Color(0xff97C2EC),
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Students')
            .doc(email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> userData =
                snapshot.data!.data() as Map<String, dynamic>;

            count = userData['count'];

            if (userData['year'] == 'second') {
              facultyData = Data().second;
            } else if (userData['year'] == 'third') {
              facultyData = Data().third;
            } else if (userData['year'] == 'fourth') {
              facultyData = Data().fourth;
            }

            return Column(
              children: [
                Image.asset('assets/images/home_page_image.png'),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(9),
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        bool feedback = userData['Subject${index + 1}'];
                        return Card(
                          color: const Color(0xff97C2EC),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: ListTile(
                            onTap: () {
                              if (feedback == true) {
                                return;
                              }
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => FeedbackScreen(
                                    subject: facultyData['Subject${index + 1}']
                                        [0],
                                    faculty: facultyData['Subject${index + 1}']
                                        [1],
                                    year: userData['year'],
                                    branch: userData['branch'],
                                    email: email,
                                    index: index,
                                    count: userData['count'],
                                  ),
                                ),
                              );
                            },
                            title: Text(
                              facultyData['Subject${index + 1}'][0],
                              style: const TextStyle(
                                fontFamily: 'Fredoka',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: feedback
                                ? const Icon(
                                    Icons.done_rounded,
                                    color: Color(0xff1F1F1F),
                                  )
                                : const Icon(
                                    Icons.error,
                                    color: Color(0xff1F1F1F),
                                  ),
                          ),
                        );
                      },
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
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
