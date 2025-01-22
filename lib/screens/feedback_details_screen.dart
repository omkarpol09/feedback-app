import 'dart:io';

import 'package:aids_feedback_app/data/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class FeedbackDetailsScreen extends StatefulWidget {
  const FeedbackDetailsScreen({
    required this.year,
    required this.subjectFaculty,
    required this.sem,
    required this.class_,
    required this.strength,
    super.key,
  });

  final String year;
  final Map<String, List<String>> subjectFaculty;
  final int sem;
  final String class_;
  final int strength;

  @override
  State<FeedbackDetailsScreen> createState() => _FeedbackDetailsScreenState();
}

class _FeedbackDetailsScreenState extends State<FeedbackDetailsScreen> {
  int sub1 = 0;
  int sub2 = 0;
  int sub3 = 0;
  int sub4 = 0;
  int sub5 = 0;

  Future<void> getCount() async {
    int tempSub1 = 0;
    int tempSub2 = 0;
    int tempSub3 = 0;
    int tempSub4 = 0;
    int tempSub5 = 0;

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('AI&DS-${widget.year}')
        .get();

    for (var doc in querySnapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;

      if (data.containsKey('Subject1') && data['Subject1'] != null) tempSub1++;
      if (data.containsKey('Subject2') && data['Subject2'] != null) tempSub2++;
      if (data.containsKey('Subject3') && data['Subject3'] != null) tempSub3++;
      if (data.containsKey('Subject4') && data['Subject4'] != null) tempSub4++;
      if (data.containsKey('Subject5') && data['Subject5'] != null) tempSub5++;
    }

    setState(() {
      sub1 = tempSub1;
      sub2 = tempSub2;
      sub3 = tempSub3;
      sub4 = tempSub4;
      sub5 = tempSub5;
    });
  }

  @override
  void initState() {
    super.initState();
    getCount();
  }

  @override
  Widget build(BuildContext context) {
    late Map<String, List<String>> facultyData;
    double screenWidth = MediaQuery.of(context).size.width;
    Map<String, int> index = {
      'Excellent': 2,
      'Very Good': 3,
      'Good': 4,
      'Average': 5,
      'Poor': 6,
    };

    Future<File> generateReportPdf(
      List headers,
      List<List> data,
      String sub,
      String fac,
      int strength,
      int totalResponses,
      int pendingFeedbacks,
      String overallPerformance,
    ) async {
      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text(
                      "Dr. Vasantraodada Patil Shetakari Shikshan Mandal's",
                      style: pw.TextStyle(
                        font: pw.Font.times(),
                      ),
                    ),
                  ],
                ),
                pw.Text(
                  "Padmabhooshan Vasantraodada Patil Institute of Technology, Sangli",
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                    fontSize: 24,
                    font: pw.Font.timesBold(),
                  ),
                ),
                pw.SizedBox(height: 5),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text(
                      "Department of Artificial Intelligence & Data Science",
                      style: pw.TextStyle(
                        font: pw.Font.times(),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 3),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text(
                      "Feedback Report 2024-25",
                      style: pw.TextStyle(
                        fontSize: 11,
                        font: pw.Font.timesBold(),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      "Subject: $sub",
                      style: pw.TextStyle(
                        fontSize: 11,
                        font: pw.Font.times(),
                      ),
                    ),
                    pw.Text(
                      "Faculty: $fac",
                      style: pw.TextStyle(
                        fontSize: 11,
                        font: pw.Font.times(),
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      "Semester: ${widget.sem}",
                      style: pw.TextStyle(
                        fontSize: 11,
                        font: pw.Font.times(),
                      ),
                    ),
                    pw.Text(
                      "Division: A",
                      style: pw.TextStyle(
                        fontSize: 11,
                        font: pw.Font.times(),
                      ),
                    ),
                  ],
                ),
                pw.Divider(
                  thickness: 0.5,
                ),
                pw.SizedBox(height: 10),
                pw.TableHelper.fromTextArray(
                  headerStyle: pw.TextStyle(
                    font: pw.Font.timesBold(),
                    fontSize: 11,
                  ),
                  cellStyle: pw.TextStyle(
                    font: pw.Font.times(),
                    fontSize: 11,
                  ),
                  headers: headers,
                  data: data,
                ),
                pw.SizedBox(height: 10),
                pw.Divider(
                  thickness: 0.5,
                ),
                pw.Text(
                  'Class strength: $strength',
                  style: pw.TextStyle(
                    fontSize: 11,
                    font: pw.Font.times(),
                  ),
                ),
                pw.SizedBox(height: 3),
                pw.Text(
                  'Total responses: $totalResponses',
                  style: pw.TextStyle(
                    fontSize: 11,
                    font: pw.Font.times(),
                  ),
                ),
                pw.SizedBox(height: 3),
                pw.Text(
                  'Pending feedbacks: $pendingFeedbacks',
                  style: pw.TextStyle(
                    fontSize: 11,
                    font: pw.Font.times(),
                  ),
                ),
                pw.SizedBox(height: 3),
                pw.Text(
                  'Overall performance: $overallPerformance',
                  style: pw.TextStyle(
                    fontSize: 11,
                    font: pw.Font.times(),
                  ),
                ),
                pw.SizedBox(height: 3),
                pw.Spacer(),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      children: [
                        pw.Text(
                          'Ms. R. R. Jagtap',
                          style: pw.TextStyle(
                            fontSize: 11,
                            font: pw.Font.times(),
                          ),
                        ),
                        pw.Text(
                          'HOD AI&DS',
                          style: pw.TextStyle(
                            fontSize: 11,
                            font: pw.Font.timesBold(),
                          ),
                        ),
                      ],
                    ),
                    pw.Column(
                      children: [
                        pw.Text(
                          'Dr. B. S. Patil',
                          style: pw.TextStyle(
                            fontSize: 11,
                            font: pw.Font.times(),
                          ),
                        ),
                        pw.Text(
                          'Principal',
                          style: pw.TextStyle(
                            fontSize: 11,
                            font: pw.Font.timesBold(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 20),
              ],
            );
          },
        ),
      );

      String fileName =
          '$sub-${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}-${DateTime.now().millisecondsSinceEpoch}';
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$fileName.pdf';

      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      return file;
    }

    void openPdf(File file) {
      OpenFile.open(file.path);
    }

    void generateReport(int num) async {
      String overallPerformance = '';
      int totalResponses = 0;
      int pendingFeedbacks = 0;
      List headers = [
        'No.',
        'Parameters',
        'Excellent',
        'Very good',
        'Good',
        'Average',
        'Poor',
        'Avg.',
      ];

      List<List> data = [
        ['1', 'Coverage of syllabus', 0, 0, 0, 0, 0, 0],
        ['2', 'Organization of course', 0, 0, 0, 0, 0, 0],
        ['3', 'Emphasis of fundamentals', 0, 0, 0, 0, 0, 0],
        ['4', 'Coverage of modern/advanced topics', 0, 0, 0, 0, 0, 0],
        ['5', 'Availability of textbooks/study materials', 0, 0, 0, 0, 0, 0],
        ['6', 'Usefulness of tests and assignments', 0, 0, 0, 0, 0, 0],
        ['7', 'Overall rating of the course', 0, 0, 0, 0, 0, 0],
        ['8', 'Pace of the teaching/lecture', 0, 0, 0, 0, 0, 0],
        ['9', 'Clarity of expression', 0, 0, 0, 0, 0, 0],
        ['10', 'Level of preparation', 0, 0, 0, 0, 0, 0],
        ['11', 'Punctuality of the teacher', 0, 0, 0, 0, 0, 0],
        ['12', 'Level of interaction', 0, 0, 0, 0, 0, 0],
        ['13', 'Accessibility outside the class', 0, 0, 0, 0, 0, 0],
        ['14', 'Overall rating of the teacher', 0, 0, 0, 0, 0, 0],
        ['', '', '', '', '', '', 'Total', 0],
      ];

      CollectionReference collectionRef =
          FirebaseFirestore.instance.collection('AI&DS-${widget.year}');
      QuerySnapshot querySnapshot = await collectionRef.get();
      List<DocumentSnapshot> docs = querySnapshot.docs;

      for (int i = 0; i < docs.length; i++) {
        Map<String, dynamic> feedbackData =
            docs[i].data() as Map<String, dynamic>;

        if (feedbackData.isNotEmpty) {
          totalResponses += 1;
          for (int i = 0; i < 14; i++) {
            String feedback = feedbackData['Subject$num']['Question${i + 1}'];
            data[i][index[feedback]!] = data[i][index[feedback]!] + 1;
          }
        } else {
          pendingFeedbacks += 1;
        }
      }

      for (int i = 0; i < 14; i++) {
        final avg = ((data[i][2] * 5) +
                (data[i][3] * 4) +
                (data[i][4] * 3) +
                (data[i][5] * 2) +
                (data[i][6] * 1)) /
            totalResponses;

        data[i][7] = data[i][7] + double.parse(avg.toStringAsFixed(2));
      }

      double finalAvg = 0;
      for (int i = 0; i < 14; i++) {
        finalAvg = finalAvg + data[i][7];
      }
      finalAvg = finalAvg / 14;
      data[14][7] = data[14][7] + double.parse(finalAvg.toStringAsFixed(2));

      if (finalAvg > 0 && finalAvg <= 1) {
        overallPerformance = 'Poor';
      } else if (finalAvg > 1 && finalAvg <= 2) {
        overallPerformance = 'Average';
      } else if (finalAvg > 2 && finalAvg <= 3) {
        overallPerformance = 'Good';
      } else if (finalAvg > 3 && finalAvg <= 4) {
        overallPerformance = 'Very good';
      } else if (finalAvg > 4 && finalAvg <= 5) {
        overallPerformance = 'Excellent';
      }

      final file = await generateReportPdf(
        headers,
        data,
        widget.subjectFaculty['Subject$num']![0],
        widget.subjectFaculty['Subject$num']![1],
        docs.length,
        totalResponses,
        pendingFeedbacks,
        overallPerformance,
      );

      openPdf(file);
    }

    if (widget.year == 'second') {
      facultyData = Data().second;
    } else if (widget.year == 'third') {
      facultyData = Data().third;
    } else if (widget.year == 'fourth') {
      facultyData = Data().fourth;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    facultyData['Subject1']![0],
                    style: const TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    '- ${facultyData['Subject1']![1]}',
                    style: const TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Total feedback count: $sub1',
                    style: const TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    'Pending feedbacks: ${widget.strength - sub1}',
                    style: const TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: 15,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: screenWidth / 2.5,
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
                            generateReport(1);
                          },
                          child: const Text('Report'),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    facultyData['Subject2']![0],
                    style: const TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    '- ${facultyData['Subject2']![1]}',
                    style: const TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Total feedback count: $sub2',
                    style: const TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    'Pending feedbacks: ${widget.strength - sub2}',
                    style: const TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: 15,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: screenWidth / 2.5,
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
                            generateReport(2);
                          },
                          child: const Text('Report'),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    facultyData['Subject3']![0],
                    style: const TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    '- ${facultyData['Subject3']![1]}',
                    style: const TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Total feedback count: $sub3',
                    style: const TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    'Pending feedbacks: ${widget.strength - sub3}',
                    style: const TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: 15,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: screenWidth / 2.5,
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
                            generateReport(3);
                          },
                          child: const Text('Report'),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    facultyData['Subject4']![0],
                    style: const TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    '- ${facultyData['Subject4']![1]}',
                    style: const TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Total feedback count: $sub4',
                    style: const TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    'Pending feedbacks: ${widget.strength - sub4}',
                    style: const TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: 15,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: screenWidth / 2.5,
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
                            generateReport(4);
                          },
                          child: const Text('Report'),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    facultyData['Subject5']![0],
                    style: const TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    '- ${facultyData['Subject5']![1]}',
                    style: const TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Total feedback count: $sub5',
                    style: const TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    'Pending feedbacks: ${widget.strength - sub5}',
                    style: const TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: 15,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: screenWidth / 2.5,
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
                            generateReport(5);
                          },
                          child: const Text('Report'),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
