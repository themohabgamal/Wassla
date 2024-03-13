import 'package:grad/presentation/cart/cart_screen.dart';
import 'package:grad/presentation/home/home_screen.dart';
import 'package:grad/presentation/settings/settings_screen.dart';
import 'package:grad/presentation/categories/categories_screen.dart';
import 'package:flutter/material.dart';
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
    const CategoriesScreen(),
    WishListScreen(),
    const SettingsScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      floatingActionButton: GestureDetector(
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const CartScreen())),
        child: const CircleAvatar(
            radius: 30,
            backgroundColor: MyTheme.mainColor,
            child: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        elevation: 5,
        notchMargin: 8,
        height: 70,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildNavBarItem(0, IconlyBold.home, 'Home'),
            _buildNavBarItem(1, IconlyBold.ticket, 'Special'),
            const SizedBox(
                width: 48.0), // Empty space for the rounded center button
            _buildNavBarItem(2, IconlyBold.heart, 'Wishlist'),
            _buildNavBarItem(3, IconlyBold.profile, 'Profile'),
          ],
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
            color: MyTheme.navBarItemColor,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style:
                const TextStyle(fontSize: 12, color: MyTheme.navBarItemColor),
          ),
        ],
      ),
    );
  }
}
