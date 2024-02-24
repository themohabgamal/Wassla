import 'package:flutter/material.dart';
import 'package:grad/core/helpers/constants/fonts/font_helper.dart';
import 'package:grad/presentation/settings/edit_profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        toolbarHeight: 100,
        title: Text(
          'Account',
          style: FontHelper.poppins24Bold(),
        ),
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header with user avatar, name, and email
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage: AssetImage('assets/images/auth.png'),
                          radius: 30,
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'User Name',
                              style: FontHelper.poppins18Bold(),
                            ),
                            const Text('user@email.com'),
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
                  leading: const Icon(Icons.home),
                  title: const Text('My Addresses'),
                  onTap: () {
                    // Navigate to my addresses screen
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.shopping_cart),
                  title: const Text('My Cart'),
                  onTap: () {
                    // Navigate to my cart screen
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.assignment),
                  title: const Text('My Orders'),
                  onTap: () {
                    // Navigate to my orders screen
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.account_balance),
                  title: const Text('Bank Account'),
                  onTap: () {
                    // Navigate to bank account screen
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.card_giftcard),
                  title: const Text('My Coupons'),
                  onTap: () {
                    // Navigate to my coupons screen
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.notifications),
                  title: const Text('Notifications'),
                  onTap: () {
                    // Navigate to notifications screen
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.lock),
                  title: const Text('Account Privacy'),
                  onTap: () {
                    // Navigate to account privacy screen
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
