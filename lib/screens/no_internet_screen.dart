import 'package:flutter/material.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

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
      ),
      body: const Center(
        child: Text(
          'No internet connection.',
          style: TextStyle(
            color: Color(0xff1F1F1F),
            fontFamily: 'Fredoka',
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
