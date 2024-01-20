import 'package:grad/main.dart';
import 'package:grad/nav_switcher.dart';
import 'package:grad/presentation/about_us.dart';
import 'package:grad/core/theming/theme.dart';
import 'package:grad/widgets/alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticatedScreen extends StatefulWidget {
  const AuthenticatedScreen({super.key});

  @override
  State<AuthenticatedScreen> createState() => _AuthenticatedScreenState();
}

class _AuthenticatedScreenState extends State<AuthenticatedScreen> {
  var user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: MyTheme.mainColor),
            currentAccountPicture: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network("${user!.photoURL}")),
            accountName: Text(
              "${user?.displayName}",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: Colors.white),
            ),
            accountEmail: Text(
              "${user?.email}",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.white),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Theme.of(context).textTheme.titleLarge?.color,
            ),
            title: Text(
              'Logout',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            onTap: () {
              logOut();
            },
          ),
          ListTile(
            leading: Icon(
              Icons.info_outline,
              color: Theme.of(context).textTheme.titleLarge?.color,
            ),
            title: Text(
              'About Us',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            onTap: () {
              Navigator.pushNamed(context, AboutUsScreen.routeName);
            },
          ),
        ],
      ),
    );
    // return Column(
    //   children: [
    //     SingleChildScrollView(
    //       child: Padding(
    //         padding: const EdgeInsets.all(16.0),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Text(
    //                     'Signed in as ',
    //                     style: TextStyle(
    //                       fontWeight: FontWeight.bold,
    //                       fontSize: 18,
    //                     ),
    //                   ),
    //                   Text(
    //                     '${user?.displayName}',
    //                     style: TextStyle(
    //                       fontWeight: FontWeight.bold,
    //                       fontSize: 18,
    //                     ),
    //                   ),
    //                 ]),
    //             Text(
    //               'Notifications',
    //               style: TextStyle(
    //                 fontWeight: FontWeight.bold,
    //                 fontSize: 18,
    //               ),
    //             ),
    //             SwitchListTile(
    //               title: Text('Receive notifications'),
    //               value: _receiveNotifications,
    //               onChanged: (value) {
    //                 setState(() {
    //                   _receiveNotifications = value;
    //                 });
    //               },
    //             ),
    //             SizedBox(
    //               height: 16,
    //             ),
    //             Text(
    //               'Appearance',
    //               style: TextStyle(
    //                 fontWeight: FontWeight.bold,
    //                 fontSize: 18,
    //               ),
    //             ),
    //             SwitchListTile(
    //               title: Text('Enable dark mode'),
    //               value: _enableDarkMode,
    //               onChanged: (value) {
    //                 setState(() {
    //                   _enableDarkMode = value;
    //                 });
    //               },
    //             ),
    //             SizedBox(
    //               height: 16,
    //             ),
    //             Text(
    //               'Language',
    //               style: TextStyle(
    //                 fontWeight: FontWeight.bold,
    //                 fontSize: 18,
    //               ),
    //             ),
    //             DropdownButton<String>(
    //               value: _selectedLanguage,
    //               onChanged: (newValue) {
    //                 setState(() {
    //                   _selectedLanguage = newValue!;
    //                 });
    //               },
    //               items: <String>['English', 'Spanish', 'French', 'German']
    //                   .map<DropdownMenuItem<String>>((String value) {
    //                 return DropdownMenuItem<String>(
    //                   value: value,
    //                   child: Text(value),
    //                 );
    //               }).toList(),
    //             ),
    //             SizedBox(height: 10),
    //             GestureDetector(
    //               onTap: () => logOut(),
    //               child: Container(
    //                 child: Row(
    //                   children: [
    //                     Icon(Icons.logout),
    //                     SizedBox(width: 10),
    //                     Text(
    //                       "Logout",
    //                       style: Theme.of(context)
    //                           .textTheme
    //                           .headline6
    //                           ?.copyWith(
    //                               fontSize: 16, fontWeight: FontWeight.w600),
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }

  Future logOut() async {
    Navigator.of(context).pushReplacementNamed(NavSwitcher.routeName);
    Alert.showAlert(context, "assets/animations/loading.json", "Signning Out");
    await Future.delayed(
      const Duration(seconds: 2),
      () {
        FirebaseAuth.instance.signOut();
        navigatorKey.currentState?.maybePop();
      },
    );
  }
}
