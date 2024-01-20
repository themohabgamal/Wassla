import 'package:grad/main.dart';
import 'package:grad/core/theming/theme.dart';
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
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 70),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 18),
                  const Text(
                    'Hi There! ',
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: MyTheme.mainColor),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Join now and be a member of our family',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: usernameController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(IconlyLight.user),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email ID',
                      prefixIcon: Icon(IconlyLight.message),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(IconlyLight.lock)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: passwordConfirmationController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: 'Password Confirmation',
                        prefixIcon: Icon(IconlyLight.password)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password again';
                      }
                      return null;
                    },
                  ),
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
                              ),
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
        context, "assets/animations/loading.json", "Authenticating");
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());

      navigatorKey.currentState!.pop();
      Alert.showAlert(
          context, "assets/animations/success.json", "Signed up successfully");
    } on FirebaseAuthException catch (e) {
      navigatorKey.currentState!.pop();
      Alert.showAlert(context, "assets/animations/error.json", e.message!);
    }
  }
}
