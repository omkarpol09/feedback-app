import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  bool _isLoginIn = false;
  String snackBarMessage = '';
  String incorrectCredentialsMessage = '';

  void login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    setState(() {
      _isLoginIn = true;
    });

    try {
      if (email.isEmpty || password.isEmpty) {
        setState(() {
          snackBarMessage = 'All fields are required.';
          _isLoginIn = false;
        });
        emailController.clear();
        passwordController.clear();
        return;
      }
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        incorrectCredentialsMessage = 'Invalid credentials.';
        _isLoginIn = false;
      });
      emailController.clear();
      passwordController.clear();
      return;
    }

    setState(() {
      _isLoginIn = false;
    });
    emailController.clear();
    passwordController.clear();
    return;
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Login',
              style: TextStyle(
                fontFamily: 'Fredoka',
                fontSize: 55,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            TextField(
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(fontFamily: 'Fredoka'),
              controller: emailController,
              cursorColor: const Color(0xff97C2EC),
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff97C2EC),
                    width: 2,
                  ),
                ),
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            if (incorrectCredentialsMessage != '')
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    incorrectCredentialsMessage,
                    style: const TextStyle(
                      color: Colors.red,
                      fontFamily: 'Fredoka',
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 15),
            TextField(
              keyboardType: TextInputType.visiblePassword,
              style: const TextStyle(fontFamily: 'Fredoka'),
              controller: passwordController,
              obscureText: _obscureText,
              cursorColor: const Color(0xff97C2EC),
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff97C2EC),
                    width: 2,
                  ),
                ),
                hintText: 'Password',
                hintStyle: const TextStyle(color: Colors.grey),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            if (incorrectCredentialsMessage != '')
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    incorrectCredentialsMessage,
                    style: const TextStyle(
                      color: Colors.red,
                      fontFamily: 'Fredoka',
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 20),
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
                  login();

                  if (snackBarMessage != '') {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 2),
                        backgroundColor: const Color(0xff1F1F1F),
                        content: Text(
                          snackBarMessage,
                          style: const TextStyle(
                            fontFamily: 'Fredoka',
                            color: Colors.red,
                          ),
                        ),
                      ),
                    );
                  }

                  setState(() {
                    snackBarMessage = '';
                    incorrectCredentialsMessage = '';
                  });
                },
                child: _isLoginIn == false
                    ? const Text(
                        'Login',
                        style: TextStyle(fontFamily: 'Fredoka'),
                      )
                    : const SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
