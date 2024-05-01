import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad/core/DI/dependency_injection.dart';
import 'package:grad/core/helpers/constants/fonts/font_helper.dart';
import 'package:grad/core/networking/firebase_helper.dart';
import 'package:grad/core/widgets/my_button.dart';
import 'package:grad/widgets/alert.dart';

class EditProfileScreen extends StatefulWidget {
  static const String routeName = 'edit_profile';

  const EditProfileScreen({super.key});

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  @override
  void initState() {
    getIt<FirebaseHelper>().getCurrentUserData().then((user) {
      if (user != null) {
        setState(() {
          _firstNameController.text = user.firstName;
          _lastNameController.text = user.lastName;
          _emailController.text = user.email;
          _phoneController.text = user.phone;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: FontHelper.poppins20Bold(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
            const SizedBox(height: 16.0),
            MyButton(
              text: 'Update Profile',
              onPressed: () => updateUserProfile(
                firstName: _firstNameController.text,
                lastName: _lastNameController.text,
                email: _emailController.text,
                phoneNumber: _phoneController.text,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateUserProfile(
      {required String firstName,
      required String lastName,
      required String email,
      required String phoneNumber}) async {
    try {
      Alert.showAlert(
          isLoading: true,
          context: context,
          animation: "assets/animations/loading.json",
          text: "Updating...");
      await getIt<FirebaseHelper>().updateUserProfile(
        userId: FirebaseAuth
            .instance.currentUser!.uid, // Replace with the actual user ID
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
      );
      Navigator.pop(context);
      Alert.showAlert(
          isLoading: false,
          context: context,
          animation: "assets/animations/success.json",
          text: "Profile updated successfully");
    } catch (e) {
      AwesomeSnackbarContent(
        title: 'Error',
        message: 'Failed to update user profile',
        contentType: ContentType.failure,
      );
    }
  }
}
