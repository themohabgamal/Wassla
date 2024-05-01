import 'package:flutter/material.dart';
import 'package:grad/core/helpers/constants/fonts/font_helper.dart';
import 'package:grad/core/networking/firebase_helper.dart';
import 'package:grad/presentation/settings/about_us.dart';
import 'package:grad/presentation/settings/edit_profile_screen.dart';
import 'package:grad/presentation/settings/my_orders_screen.dart';
import 'package:iconly/iconly.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final FirebaseHelper firebaseHelper = FirebaseHelper();
  String firstName = '';
  String lastName = '';
  String email = '';
  @override
  void initState() {
    super.initState();
    firebaseHelper.getCurrentUserData().then((user) {
      if (user != null) {
        setState(() {
          firstName = user.firstName;
          lastName = user.lastName;
          email = user.email;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          'Account',
          style: FontHelper.poppins24Bold(),
        ),
        centerTitle:
            false, // Set centerTitle to false to align the title to the left
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header with user avatar, name, and email
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            color: Colors.grey[100],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              firstName == ''
                                  ? ''
                                  : "${firstName[0].toUpperCase() + firstName.substring(1)} $lastName",
                              style: FontHelper.poppins18Bold(),
                            ),
                            Text(email == '' ? '' : email),
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, EditProfileScreen.routeName);
                      },
                      child: const Icon(
                        Icons.edit,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Account settings
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: const Icon(
                    IconlyBold.discount,
                    size: 28,
                  ),
                  title: const Text('My Orders'),
                  onTap: () {
                    Navigator.pushNamed(context, MyOrdersScreen.routeName);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.info,
                    size: 28,
                  ),
                  title: const Text('About Us'),
                  onTap: () {
                    Navigator.pushNamed(context, AboutUsScreen.routeName);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    IconlyBold.logout,
                    size: 28,
                  ),
                  title: const Text('Logout'),
                  onTap: () {
                    firebaseHelper.logout();
                  },
                ),
              ],
            ),
          ),
          // App settings
        ],
      ),
    );
  }
}
