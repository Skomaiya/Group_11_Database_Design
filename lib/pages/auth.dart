import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sustanify/main.dart';
import 'package:sustanify/pages/login_or_register.dart';
//import 'package:sustanify/pages/login_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const MainScreen();
              } else {
                return const LoginOrRegisterPage();
              } // User is signed in
            }));
  }
}
