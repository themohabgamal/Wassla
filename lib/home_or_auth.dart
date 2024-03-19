import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grad/business_logic/cart/bloc/bloc/cart_bloc.dart';
import 'package:grad/core/DI/dependency_injection.dart';
import 'package:grad/core/theming/theme.dart';
import 'package:grad/nav_switcher.dart';
import 'presentation/auth/auth_page.dart';

class HomeOrAuth extends StatefulWidget {
  static const String routeName = 'home_or_auth';
  const HomeOrAuth({super.key});

  @override
  _HomeOrAuthState createState() => _HomeOrAuthState();
}

class _HomeOrAuthState extends State<HomeOrAuth> {
  late User? _user;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (
        BuildContext context,
        ConnectivityResult connectivity,
        Widget child,
      ) {
        final bool connected = connectivity != ConnectivityResult.none;
        return connected ? _buildAuthStateWidget() : _buildNoInternetScreen();
      },
      child: const Text(''), // Placeholder child
    );
  }

  Widget _buildAuthStateWidget() {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          if (user == null) {
            return const AuthPage(); // Show the authentication page
          } else {
            _updateUserAndFetchCart(user.uid);
            return const NavSwitcher(); // Redirect to home page
          }
        } else {
          return const Scaffold(
            body: Center(
              child: SpinKitChasingDots(
                color: MyTheme.mainColor,
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildNoInternetScreen() {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.wifi_off,
                size: 100,
                color: Colors.white,
              ),
              SizedBox(height: 20),
              Text(
                'No Internet Connection',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Please check your connection and try again',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateUserAndFetchCart(String? userId) {
    getIt<CartBloc>().updateUserAndFetchCart(userId);
  }
}
