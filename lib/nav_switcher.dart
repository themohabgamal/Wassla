import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grad/presentation/cart/cart_screen.dart';
import 'package:grad/presentation/home/home_screen.dart';
import 'package:grad/presentation/settings/settings_screen.dart';
import 'package:grad/presentation/bot/bot_screen.dart';
import 'package:grad/presentation/wishlist/wish_list_screen.dart';
import 'package:grad/core/theming/theme.dart';
import 'package:iconly/iconly.dart';

class NavSwitcher extends StatefulWidget {
  const NavSwitcher({super.key});
  static const String routeName = 'nav';

  @override
  State<NavSwitcher> createState() => _NavSwitcherState();
}

class _NavSwitcherState extends State<NavSwitcher> {
  int selectedIndex = 0;
  final List<Widget> screens = [
    const HomeScreen(),
    const CartScreen(),
    WishListScreen(
      userId: FirebaseAuth.instance.currentUser!.uid,
    ),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BottomNavigationBar(
          elevation: 0,
          showSelectedLabels: true,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          selectedItemColor: MyTheme.mainColor,
          unselectedItemColor: Colors.grey,
          currentIndex: selectedIndex,
          onTap: _onItemTapped,
          iconSize: 20,
          selectedFontSize: 10.sp,
          unselectedFontSize: 10.sp,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                IconlyBold.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                IconlyBold.bag,
              ),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                IconlyBold.heart,
              ),
              label: 'Wishlist',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                IconlyBold.profile,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const BotScreen()));
        },
        backgroundColor: MyTheme.mainColor,
        child: const Icon(
          IconlyBold.chat,
          color: Colors.white,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
