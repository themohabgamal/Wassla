import 'package:grad/presentation/auth/login_screen.dart';
import 'package:grad/presentation/auth/signup_screen.dart';
import 'package:flutter/src/widgets/framework.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});
  static const String routeName = 'auth';

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  void toggle() => setState(() {
        print("toggle");
        isLogin = !isLogin;
      });
  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      return LoginScreen(clickedRegister: toggle);
    } else {
      return SignupScreen(clickedLogin: toggle);
    }
  }
}
