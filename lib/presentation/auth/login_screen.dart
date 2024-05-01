import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grad/core/networking/firebase_helper.dart';
import 'package:grad/core/theming/theme.dart';
import 'package:grad/core/widgets/my_button.dart';
import 'package:grad/presentation/auth/forgot_password_screen.dart';
import 'package:grad/widgets/alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iconly/iconly.dart';
import 'package:timer_count_down/timer_count_down.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';
  final Function() clickedRegister;
  const LoginScreen({super.key, required this.clickedRegister});
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  FirebaseHelper firebaseHelper = FirebaseHelper();
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  int loginAttempts = 0; // Variable to track login attempts

  Timer? _timer;
  int _countdown = 0;

  @override
  void dispose() {
    _timer?.cancel();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding:
            EdgeInsets.only(left: 32.0.w, right: 32.w, bottom: 70.h, top: 10.h),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 80.h),
              const Text(
                'Welcome back !',
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: MyTheme.mainColor),
              ),
              SizedBox(height: 7.h),
              Text(
                'Log in to your account',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 32.h),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  labelText: 'Email',
                  prefixIcon: Icon(IconlyLight.message),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email Can\'t be empty';
                  }
                  final emailRegex =
                      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    labelText: 'Password',
                    prefixIcon: Icon(IconlyLight.lock)),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password can\'t be empty';
                  }

                  // Check if the password is at least 8 characters long
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters long';
                  }

                  // Check if the password contains at least one uppercase letter
                  if (!value.contains(RegExp(r'[A-Z]'))) {
                    return 'Password must contain at least one uppercase letter';
                  }

                  // Check if the password contains at least one lowercase letter
                  if (!value.contains(RegExp(r'[a-z]'))) {
                    return 'Password must contain at least one lowercase letter';
                  }

                  // Check if the password contains at least one digit
                  if (!value.contains(RegExp(r'[0-9]'))) {
                    return 'Password must contain at least one digit';
                  }

                  // If all conditions are met, return null to indicate valid password
                  return null;
                },
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: MyButton(
                      text: 'Log in',
                      onPressed: (loginAttempts >= 3 || _countdown > 0)
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                login();
                              }
                            },
                    ),
                  ),
                ],
              ),
              if (loginAttempts >= 3 || _countdown > 0)
                Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        Text(
                          _countdown > 0 ? '' : 'Try again after ',
                          style: const TextStyle(color: Colors.red),
                        ),
                        Countdown(
                          seconds: 180,
                          build: (BuildContext context, double time) => Text(
                            formatCountdown(time.toInt()),
                            style: const TextStyle(color: Colors.red),
                          ),
                          interval: const Duration(milliseconds: 100),
                          onFinished: () {
                            setState(() {
                              loginAttempts = 0;
                              _countdown = 0;
                            });
                          },
                        )
                      ],
                    )),
              SizedBox(
                height: 10.h,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, ForgotPasswordScreen.routeName);
                    },
                    child: Text('Forgot Password?',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: MyTheme.mainColor))),
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account ?',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontSize: 16)),
                  TextButton(
                    onPressed: () {
                      widget.clickedRegister();
                    },
                    child: Text('Sign up',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 16,
                            color: MyTheme.mainColor,
                            fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatCountdown(int seconds) {
    final minutes = (seconds / 60).floor().toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSeconds';
  }

  void startCooldownTimer() {
    _countdown = 180; // 3 minutes cooldown
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _countdown--;
        if (_countdown <= 0) {
          timer.cancel();
          _timer = null;
        }
      });
    });
  }

  void login() async {
    if (loginAttempts >= 3) {
      print('Blocked'); // Print "Blocked" if login attempts exceed 3
      startCooldownTimer();
      return;
    }

    Alert.showAlert(
      isLoading: true,
      context: context,
      animation: "assets/animations/loading.json",
      text: "Authenticating",
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      loginAttempts = 0; // Reset login attempts upon successful login
      Navigator.pop(context); // Close loading alert
      Alert.showAlert(
        isLoading: false,
        context: context,
        animation: "assets/animations/success.json",
        text: "Logged in successfully",
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        loginAttempts++;
        log(loginAttempts.toString());
      });
      Navigator.pop(context); // Close loading alert
      Alert.showAlert(
        isLoading: false,
        context: context,
        animation: "assets/animations/error.json",
        text: "${e.message}",
      );
    }
  }
}
