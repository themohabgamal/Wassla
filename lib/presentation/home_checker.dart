import 'package:grad/nav_switcher.dart';
import 'package:grad/presentation/auth/auth_page.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeChecker extends StatelessWidget {
  const HomeChecker({super.key});
  static const String routeName = 'homechecker';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const NavSwitcher();
          } else {
            return const AuthPage();
          }
        },
      ),
    );
  }
}
