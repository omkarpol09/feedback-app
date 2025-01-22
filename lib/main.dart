import 'package:aids_feedback_app/auth/login.dart';
import 'package:aids_feedback_app/firebase_options.dart';
import 'package:aids_feedback_app/screens/admin_screen.dart';
import 'package:aids_feedback_app/screens/no_internet_screen.dart';
import 'package:aids_feedback_app/screens/student_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xff97C2EC),
          ),
        ),
        home: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<ConnectivityResult> connectivityResult = [ConnectivityResult.none];

  Future checkConnectivity() async {
    connectivityResult = await (Connectivity().checkConnectivity());

    Connectivity().onConnectivityChanged.listen(
      (List<ConnectivityResult> result) {
        setState(() {
          connectivityResult = result;
        });
      },
    );
  }

  @override
  void initState() {
    checkConnectivity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (connectivityResult.contains(ConnectivityResult.none)) {
      return const NoInternetScreen();
    } else if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            if (snapshot.data!.email == 'pvpit.admin@gmail.com') {
              return const AdminScreen();
            }
            return StudentScreen(
              email: snapshot.data!.email.toString(),
            );
          }

          return const Login();
        },
      );
    }
    return const Center();
  }
}

class Temp extends StatefulWidget {
  const Temp({super.key});

  @override
  State<Temp> createState() => _TempState();
}

class _TempState extends State<Temp> {
  int num = 0;

  // List lst = Data().tYEmailList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(num.toString()),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // FirebaseAuth.instance
            //     .createUserWithEmailAndPassword(
            //   email: lst[i],
            //   password: 'aids@1',
            // );

            // FirebaseFirestore.instance
            //     .collection('Students')
            //     .doc()
            //     .set({
            //   'Subject1': false,
            //   'Subject2': false,
            //   'Subject3': false,
            //   'Subject4': false,
            //   'Subject5': false,
            //   'email': '',
            //   'year': '',
            //   'count': 0,
            //   'branch': 'AI&DS',
            // });

            // for (int i = 0; i < lst.length; i++) {
            //   FirebaseFirestore.instance
            //       .collection('AI&DS-third')
            //       .doc(lst[i])
            //       .set({}).then((value) {
            //     setState(() {
            //       num += 1;
            //     });
            //   }).catchError((error) {
            //     print('0000000000000000000000000000000000000000000000000');
            //     print(lst[i]);
            //     print(error);
            //   });
            // }

            QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                .collection('AI&DS-third')
                // .where('year', isEqualTo: 'fourth')
                .get();
            print('111111111111111111111111111111111111111111111111111111');
            print(querySnapshot.size);
          },
          child: const Text('Click'),
        ),
      ),
    );
  }
}
