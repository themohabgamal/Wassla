import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grad/nav_switcher.dart';
import 'package:grad/core/theming/theme.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});
  static const String routeName = 'boardingScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        globalBackgroundColor: MyTheme.mainColor,
        done: Container(
          width: 100,
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: Colors.white),
          child: Text(
            "DONE",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.black),
          ),
        ),
        onDone: () {
          Navigator.pushReplacementNamed(context, NavSwitcher.routeName);
        },
        animationDuration: 10,
        dotsDecorator:
            const DotsDecorator(activeColor: Colors.black, color: Colors.white),
        next: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: Colors.white),
          child: const Icon(
            IconlyLight.arrow_right_2,
            color: Colors.black,
          ),
        ),
        pages: [
          PageViewModel(
              useScrollView: false,
              decoration: PageDecoration(
                titleTextStyle: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontWeight: FontWeight.w700, color: Colors.white),
                bodyAlignment: Alignment.bottomCenter,
                imageFlex: 2,
                bodyTextStyle: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(
                        fontWeight: FontWeight.w100,
                        fontSize: 17.sp,
                        color: Colors.white),
              ),
              body:
                  "Dive into a seamless shopping experience, where each tap opens the door to a universe of quality products and unbeatable deals.",
              image: Container(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SafeArea(
                      child: Image.asset(
                    "assets/images/boarding3.png",
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
                    .copyWith(fontWeight: FontWeight.w700, color: Colors.white),
                bodyAlignment: Alignment.bottomCenter,
                imageFlex: 2,
                bodyTextStyle: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(
                        fontWeight: FontWeight.w100,
                        fontSize: 17,
                        color: Colors.white),
              ),
              body:
                  "Upgrade your style and stay connected with the latest trends effortlessly",
              image: Container(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SafeArea(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/images/boarding2.png",
                      width: 400,
                    ),
                  )),
                ),
              ),
              title: "All Products in One Place"),
          PageViewModel(
              useScrollView: false,
              decoration: PageDecoration(
                titleTextStyle: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontWeight: FontWeight.w700, color: Colors.white),
                bodyAlignment: Alignment.bottomCenter,
                imageFlex: 2,
                bodyTextStyle: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(
                        fontWeight: FontWeight.w100,
                        fontSize: 17,
                        color: Colors.white),
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
                    "assets/images/boarding1.png",
                    width: 400,
                  ),
                ),
              ),
              title: "Tailored Just for You"),
        ],
      ),
    );
  }
}
