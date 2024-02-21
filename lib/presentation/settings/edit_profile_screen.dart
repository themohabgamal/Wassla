import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grad/core/theming/theme.dart';

import '../../core/helpers/constants/fonts/font_helper.dart';

class EditProfileScreen extends StatelessWidget {
  static const String routeName = 'edit_profile';

  final String name = 'ahmed';
  final String username = 'ahmed123';
  final String userId = '1';
  final String email = 'email';
  final String phoneNumber = 'phone number';

  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Profile avatar
            Center(
              child: GestureDetector(
                onTap: () {
                  // Handle avatar editing
                },
                child: Stack(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/auth.png'),
                      radius: 80,
                    ),
                    Positioned(
                        right: 0,
                        bottom: 0,
                        child: Icon(Icons.edit, size: 30.sp)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Profile information
            const Text(
              'Profile Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.h),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Name',
                hintText: 'Enter your name',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: MyTheme.mainColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelStyle: FontHelper.poppins18Bold(color: MyTheme.mainColor),
              ),
              initialValue: name, // Show the current user data
            ),
            SizedBox(height: 16.h), // SizedBox with height 16
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Username',
                hintText: 'Enter your username',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: MyTheme.mainColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelStyle: FontHelper.poppins18Bold(color: MyTheme.mainColor),
              ),
              initialValue: username, // Show the current user data
            ),
            SizedBox(height: 16.h), // SizedBox with height 16
            // Personal information
            const SizedBox(height: 16),
            const Text(
              'Personal Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.h),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'User ID',
                hintText: 'Enter your user ID',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: MyTheme.mainColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelStyle: FontHelper.poppins18Bold(color: MyTheme.mainColor),
              ),
              initialValue: userId, // Show the current user data
            ),
            SizedBox(height: 16.h), // SizedBox with height 16
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: MyTheme.mainColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelStyle: FontHelper.poppins18Bold(color: MyTheme.mainColor),
              ),
              initialValue: email, // Show the current user data
            ),
            SizedBox(height: 16.h), // SizedBox with height 16
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Phone Number',
                hintText: 'Enter your phone number',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: MyTheme.mainColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelStyle: FontHelper.poppins18Bold(color: MyTheme.mainColor),
              ),
              initialValue: phoneNumber, // Show the current user data
            ),
            // Delete account button
            SizedBox(height: 18.h),
            ElevatedButton(
              onPressed: () {
                // Add logic to delete the account
              },
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: MyTheme.mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  )),
              child: Text(
                'Delete Account',
                style: FontHelper.poppins18Regular(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
