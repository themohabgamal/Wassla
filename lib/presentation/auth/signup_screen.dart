import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grad/core/networking/firebase_helper.dart';
import 'package:grad/core/widgets/my_text_form_field.dart';
import 'package:grad/main.dart';
import 'package:grad/core/theming/theme.dart';
import 'package:grad/models/user.dart';
import 'package:grad/widgets/alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = 'signup';
  final Function()? clickedLogin;
  const SignupScreen({super.key, this.clickedLogin});
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  FirebaseHelper firebaseHelper = FirebaseHelper();
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordConfirmationController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    passwordConfirmationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding:
            EdgeInsets.only(left: 32.0.w, right: 32.w, bottom: 10.h, top: 90.h),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome To Wassla',
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: MyTheme.mainColor),
                  ),
                  SizedBox(height: 7.h),
                  Text(
                    'Join now and be a member of our family',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: MyTextFormField(
                            controller: firstNameController,
                            labelText: "First Name",
                            prefixIcon: const Icon(IconlyLight.add_user),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your first name';
                              }
                              return null;
                            },
                            obscureText: false),
                      ),
                      SizedBox(
                        width: 7.w,
                      ),
                      Expanded(
                        flex: 1,
                        child: MyTextFormField(
                            controller: lastNameController,
                            labelText: "Last Name",
                            prefixIcon: const Icon(IconlyLight.add_user),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your last name';
                              }
                              return null;
                            },
                            obscureText: false),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  MyTextFormField(
                      controller: emailController,
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
                      keyboardType: TextInputType.emailAddress,
                      labelText: "Email Adress",
                      prefixIcon: const Icon(IconlyLight.message),
                      obscureText: false),
                  SizedBox(height: 16.h),
                  MyTextFormField(
                      controller: phoneController,
                      labelText: "Phone Number",
                      keyboardType: TextInputType.number,
                      prefixIcon: const Icon(IconlyLight.call),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Phone Number Can\'t be empty';
                        } else if (value.length < 11) {
                          return 'Phone Number is too short';
                        } else if (value.length > 11) {
                          return 'Phone Number is too long';
                        }
                        return null;
                      },
                      obscureText: false),
                  SizedBox(
                    height: 16.h,
                  ),
                  MyTextFormField(
                      controller: passwordController,
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
                      labelText: "Password",
                      prefixIcon: const Icon(IconlyLight.lock),
                      obscureText: true),
                  SizedBox(height: 16.h),
                  MyTextFormField(
                      controller: passwordConfirmationController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'This Field Can\'t be empty';
                        } else if (value != passwordController.text) {
                          return 'Passwords do not match';
                        }
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
                        return null;
                      },
                      labelText: "Password Confirmation",
                      prefixIcon: const Icon(IconlyLight.lock),
                      obscureText: true),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  MyTheme.mainColor),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ))),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              signUp();
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already a member?',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontSize: 16)),
                      TextButton(
                        onPressed: () {
                          widget.clickedLogin!();
                        },
                        child: Text('Login',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
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
        ),
      ),
    );
  }

  Future signUp() async {
    Alert.showAlert(
        isLoading: true,
        context: context,
        animation: "assets/animations/loading.json",
        text: "Authenticating");
    try {
      var authResult = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim());
      firebaseHelper.saveUserData(MyUser(
          userId: authResult.user!.uid,
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          email: emailController.text.trim(),
          phone: phoneController.text.trim()));
      navigatorKey.currentState!.pop();
      Alert.showAlert(
        isLoading: false,
        context: context,
        animation: "assets/animations/success.json",
        text: "Signed up successfully",
      );
    } on FirebaseAuthException catch (e) {
      navigatorKey.currentState!.pop();
      Alert.showAlert(
          isLoading: false,
          context: context,
          animation: "assets/animations/error.json",
          text: e.message!);
    }
  }
}
