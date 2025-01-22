import 'package:flutter_riverpod/flutter_riverpod.dart';

Map<String, String> studentFeedback = {
  'Question1': '',
  'Question2': '',
  'Question3': '',
  'Question4': '',
  'Question5': '',
  'Question6': '',
  'Question7': '',
  'Question8': '',
  'Question9': '',
  'Question10': '',
  'Question11': '',
  'Question12': '',
  'Question13': '',
  'Question14': '',
};

class SelectedOptionsNotifier extends StateNotifier<Map<String, String>> {
  SelectedOptionsNotifier()
      : super({
          'Question1': '',
          'Question2': '',
          'Question3': '',
          'Question4': '',
          'Question5': '',
          'Question6': '',
          'Question7': '',
          'Question8': '',
          'Question9': '',
          'Question10': '',
          'Question11': '',
          'Question12': '',
          'Question13': '',
          'Question14': '',
        });

  void setSelectedOption(int index, String option) {
    studentFeedback['Question$index'] = option;
    state = studentFeedback;
  }

  void initializeList() {
    studentFeedback = {
      'Question1': '',
      'Question2': '',
      'Question3': '',
      'Question4': '',
      'Question5': '',
      'Question6': '',
      'Question7': '',
      'Question8': '',
      'Question9': '',
      'Question10': '',
      'Question11': '',
      'Question12': '',
      'Question13': '',
      'Question14': '',
    };
    state = studentFeedback;
  }
}

final selectedOptionsProvider =
    StateNotifierProvider<SelectedOptionsNotifier, Map<String, String>>(
  (ref) {
    return SelectedOptionsNotifier();
  },
);
