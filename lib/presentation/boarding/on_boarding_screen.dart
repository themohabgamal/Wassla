import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grad/core/theming/theme.dart';
import 'package:flutter/material.dart';
import 'package:grad/home_or_auth.dart';
import 'package:iconly/iconly.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});
  static const String routeName = 'boardingScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        globalBackgroundColor: Colors.white,
        done: Container(
          width: 100,
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: MyTheme.mainColor),
          child: Text(
            "DONE",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.white),
          ),
        ),
        onDone: () {
          Navigator.pushNamedAndRemoveUntil(
              context, HomeOrAuth.routeName, (route) => false);
        },
        animationDuration: 10,
        dotsDecorator: const DotsDecorator(
            activeColor: MyTheme.mainColor, color: Colors.black12),
        next: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: MyTheme.mainColor),
          child: const Icon(
            IconlyLight.arrow_right_2,
            color: Colors.white,
          ),
        ),
        pages: [
          PageViewModel(
              useScrollView: false,
              decoration: PageDecoration(
                titleTextStyle: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontWeight: FontWeight.w700, color: Colors.black),
                bodyAlignment: Alignment.bottomCenter,
                imageFlex: 2,
                bodyTextStyle: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(
                        fontWeight: FontWeight.w100,
                        fontSize: 14.sp,
                        color: Colors.black45),
              ),
              body:
                  "Each tap opens the door to a universe of quality products and unbeatable deals.",
              image: Container(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SafeArea(
                      child: Image.asset(
                    "assets/images/1.png",
                    width: 400,
                  )),
                ),
              ),
              title: "Explore Limitless Choices"),
          PageViewModel(
              useScrollView: false,
              decoration: PageDecoration(
                titleTextStyle: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontWeight: FontWeight.w700, color: Colors.black),
                bodyAlignment: Alignment.bottomCenter,
                imageFlex: 2,
                bodyTextStyle: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(
                        fontWeight: FontWeight.w100,
                        fontSize: 14.sp,
                        color: Colors.black45),
              ),
              body:
                  "Upgrade your style and stay connected with the latest trends effortlessly and pay online with our app",
              image: Container(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SafeArea(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/images/2.png",
                      width: 400,
                    ),
                  )),
                ),
              ),
              title: "Easy Payments and Services"),
          PageViewModel(
              useScrollView: false,
              decoration: PageDecoration(
                titleTextStyle: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontWeight: FontWeight.w700, color: Colors.black),
                bodyAlignment: Alignment.bottomCenter,
                imageFlex: 2,
                bodyTextStyle: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(
                        fontWeight: FontWeight.w100,
                        fontSize: 14.sp,
                        color: Colors.black45),
              ),
              body:
                  "Our app understands your preferences and curates a unique selection of products based on your interests.",
              image: Container(
                alignment: Alignment.bottomCenter,
                width: double.infinity,
                padding: const EdgeInsets.all(50),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/images/3.png",
                    width: 400,
                  ),
                ),
              ),
              title: "Orders Made Easily"),
        ],
      ),
    );
  }
}
