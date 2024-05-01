import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad/business_logic/cart/bloc/bloc/cart_bloc.dart';
import 'package:grad/business_logic/home/bloc/home_bloc.dart';
import 'package:grad/core/DI/dependency_injection.dart';
import 'package:grad/home_or_auth.dart';
import 'package:grad/models/category_response_model.dart';
import 'package:grad/nav_switcher.dart';
import 'package:grad/presentation/settings/about_us.dart';
import 'package:grad/presentation/auth/auth_page.dart';
import 'package:grad/presentation/auth/forgot_password_screen.dart';
import 'package:grad/presentation/boarding/on_boarding_screen.dart';
import 'package:grad/presentation/cart/cart_screen.dart';
import 'package:grad/presentation/home/home_screen.dart';
import 'package:grad/presentation/home/furniture_page.dart';
import 'package:grad/presentation/home/recommended_page.dart';
import 'package:grad/presentation/home_checker.dart';
import 'package:grad/presentation/settings/edit_profile_screen.dart';
import 'package:grad/presentation/settings/my_orders_screen.dart';
import 'package:grad/presentation/wishlist/wish_list_screen.dart';
import 'package:grad/widgets/cart_single_product_args.dart';
import 'package:grad/widgets/cart_single_product_page.dart';
import 'package:grad/widgets/categories_single_product_page.dart';
import 'package:grad/widgets/single_product_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case NavSwitcher.routeName:
        return MaterialPageRoute(builder: (context) => const NavSwitcher());
      case CartScreen.routeName:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => getIt<CartBloc>(),
                  child: const CartScreen(),
                ));
      case AuthPage.routeName:
        return MaterialPageRoute(builder: (context) => const AuthPage());
      case HomeOrAuth.routeName:
        return MaterialPageRoute(builder: (context) => const HomeOrAuth());
      case SingleProductPage.routeName:
        final args = settings.arguments as CategoryResponseModel;
        return MaterialPageRoute(
            builder: (context) => SingleProductPage(
                  categoryResponseModel: args,
                ));
      case CartSingleProductPage.routeName:
        final args = settings.arguments as CartToSingleProductPageArgs;
        return MaterialPageRoute(
            builder: (context) => CartSingleProductPage(
                  args: args,
                ));
      case FurniturePage.routeName:
        final args = settings.arguments as HomeBloc;
        return MaterialPageRoute(
            builder: (context) => FurniturePage(
                  homeBloc: args,
                ));
      case RecommendedPage.routeName:
        final args = settings.arguments as HomeBloc;
        return MaterialPageRoute(
            builder: (context) => RecommendedPage(
                  homeBloc: args,
                ));
      case WishListScreen.routeName:
        return MaterialPageRoute(
            builder: (context) => WishListScreen(
                  userId: FirebaseAuth.instance.currentUser!.uid,
                ));
      case CategoriesSingleProductPage.routeName:
        return MaterialPageRoute(
            builder: (context) => const CategoriesSingleProductPage());
      case OnBoardingScreen.routeName:
        return MaterialPageRoute(
            builder: (context) => const OnBoardingScreen());
      case HomeChecker.routeName:
        return MaterialPageRoute(builder: (context) => const HomeChecker());
      case AboutUsScreen.routeName:
        return MaterialPageRoute(builder: (context) => const AboutUsScreen());
      case ForgotPasswordScreen.routeName:
        return MaterialPageRoute(builder: (context) => ForgotPasswordScreen());
      case EditProfileScreen.routeName:
        return MaterialPageRoute(
            builder: (context) => const EditProfileScreen());
      case MyOrdersScreen.routeName:
        return MaterialPageRoute(builder: (context) => MyOrdersScreen());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
        builder: (context) => const Scaffold(
              body: Center(
                child: Text('Error: Route not found!'),
              ),
            ));
  }
}
