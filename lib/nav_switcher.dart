import 'package:flutter/material.dart';
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
  List<Widget> screens = [
    const HomeScreen(),
    const CartScreen(),
    WishListScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset:
            false, // Set to false to prevent FAB from moving
        body: screens[selectedIndex],
        floatingActionButton: GestureDetector(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const BotScreen())),
          child: const CircleAvatar(
            radius: 30,
            backgroundColor: MyTheme.mainColor,
            child: Icon(
              IconlyBold.chat,
              color: Colors.white,
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 5,
          height: 70,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildNavBarItem(0, IconlyBold.home, 'Home'),
              _buildNavBarItem(1, IconlyBold.bag, 'Cart'),
              _buildNavBarItem(2, IconlyBold.heart, 'Wishlist'),
              _buildNavBarItem(3, IconlyBold.profile, 'Profile'),
            ],
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget _buildNavBarItem(int index, IconData icon, String label) {
    final isSelected = index == selectedIndex;
    final color = isSelected ? MyTheme.mainColor : MyTheme.navBarItemColor;

    return GestureDetector(
      onTap: () {
        _onItemTapped(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 25,
            color: color,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
