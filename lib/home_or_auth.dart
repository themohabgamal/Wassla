import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad/business_logic/cart/bloc/bloc/cart_bloc.dart';
import 'package:grad/core/DI/dependency_injection.dart';
import 'package:grad/nav_switcher.dart';
import 'package:lottie/lottie.dart';
import 'presentation/auth/auth_page.dart';

class HomeOrAuth extends StatelessWidget {
  static const String routeName = 'home_or_auth';
  const HomeOrAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: Lottie.asset('assets/animations/loading.json'),
            ),
          );
        }
        if (snapshot.hasData && snapshot.data != null) {
          // User is authenticated, proceed with authenticated flow
          getIt<CartBloc>().updateUserAndFetchCart(snapshot.data!.uid);
          return const NavSwitcher();
        } else {
          // User is not authenticated, show authentication page
          return const AuthPage();
        }
      },
    );
  }
}
