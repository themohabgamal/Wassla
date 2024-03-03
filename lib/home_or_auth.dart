import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grad/core/theming/theme.dart';
import 'package:grad/nav_switcher.dart';

import 'presentation/auth/auth_page.dart';

class HomeOrAuth extends StatefulWidget {
  static const String routeName = 'home_or_auth';
  const HomeOrAuth({super.key});

  @override
  State<HomeOrAuth> createState() => _HomeOrAuthState();
}

class _HomeOrAuthState extends State<HomeOrAuth> {
  User? user;
  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          if (user == null) {
            return const AuthPage(); // Show the authentication page
          } else {
            return const NavSwitcher(); // Redirect to home page
          }
        } else {
          return const Scaffold(
            body: Center(
                child: SpinKitChasingDots(
              color: MyTheme.mainColor,
            )),
          );
        }
      },
    );
  }
}
