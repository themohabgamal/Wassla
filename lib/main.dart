import 'package:grad/business_logic/theming/cubit/theming_cubit.dart';
import 'package:grad/firebase_options.dart';
import 'package:grad/nav_switcher.dart';
import 'package:grad/presentation/about_us.dart';

import 'package:grad/presentation/boarding/on_boarding_screen.dart';
import 'package:grad/presentation/home/home_screen.dart';
import 'package:grad/presentation/home/hot_deals_page.dart';
import 'package:grad/presentation/home_checker.dart';
import 'package:grad/presentation/map/g_map.dart';
import 'package:grad/presentation/wishlist/wish_list_screen.dart';
import 'package:grad/theming/theme.dart';
import 'package:grad/widgets/cart_single_product_page.dart';
import 'package:grad/widgets/categories_single_product_page.dart';
import 'package:grad/widgets/single_product_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? isViewed;
Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isViewed = prefs.getInt('onBoard');
  await prefs.setInt('onBoard', 1);
  runApp(BlocProvider(
    create: (context) => ThemingCubit(),
    child: const MyApp(),
  ));
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemingCubit themingCubit =
        BlocProvider.of<ThemingCubit>(context, listen: true);
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'MOJO',
      theme: themingCubit.isDark ? MyTheme.darkTheme : MyTheme.lightTheme,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        NavSwitcher.routeName: (context) => const NavSwitcher(),
        SingleProductPage.routeName: (context) => SingleProductPage(),
        CartSingleProductPage.routeName: (context) => CartSingleProductPage(),
        HotDealsPage.routeName: (context) => const HotDealsPage(),
        WishListScreen.routeName: (context) => WishListScreen(),
        CategoriesSingleProductPage.routeName: (context) =>
            CategoriesSingleProductPage(),
        OnBoardingScreen.routeName: (context) => const OnBoardingScreen(),
        HomeChecker.routeName: (context) => const HomeChecker(),
        AboutUsScreen.routeName: (context) => AboutUsScreen(),
        MapSample.routeName: (context) => const MapSample(),
      },
      // initialRoute: OnBoardingScreen.routeName,
      initialRoute: isViewed == 0 || isViewed == null
          ? OnBoardingScreen.routeName
          : NavSwitcher.routeName,
    );
  }
}
