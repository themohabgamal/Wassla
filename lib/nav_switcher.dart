import 'package:grad/presentation/cart/cart_screen.dart';
import 'package:grad/presentation/home/home_screen.dart';
import 'package:grad/presentation/settings/settings_screen.dart';
import 'package:grad/presentation/categories/categories_screen.dart';
import 'package:flutter/material.dart';
import 'package:grad/presentation/wishlist/wish_list_screen.dart';
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
    const CartScreen(),
    WishListScreen(),
    const SettingsScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(IconlyLight.home),
                label: "Home",
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
              icon: Icon(IconlyLight.category),
              label: "Category",
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyLight.bag),
              label: "cart",
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyLight.heart),
              label: "Wishlist",
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyLight.profile),
              label: "User",
            ),
          ]),
    );
  }
}
