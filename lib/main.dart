import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grad/core/DI/dependency_injection.dart';
import 'package:grad/core/routing/route_generator.dart';
import 'package:grad/core/theming/theme.dart';
import 'package:grad/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:grad/home_or_auth.dart';
import 'package:grad/presentation/boarding/on_boarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? isViewed;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isViewed = prefs.getInt('onBoard');
  await prefs.setInt('onBoard', 1);
  setupDependencyInjection();

  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Wassla',
        theme: MyTheme.lightTheme,
        onGenerateRoute: RouteGenerator.generateRoute,
        // initialRoute: OnBoardingScreen.routeName,
        initialRoute: isViewed == 0 || isViewed == null
            ? OnBoardingScreen.routeName
            : HomeOrAuth.routeName,
      ),
    );
  }
}
