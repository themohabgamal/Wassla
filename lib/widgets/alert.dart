import 'package:grad/core/theming/theme.dart';
import 'package:flutter/material.dart';
import 'package:grad/main.dart';
import 'package:lottie/lottie.dart';

class Alert {
  static showAlert(
      {required bool isLoading,
      void Function()? onContinue,
      required BuildContext context,
      required String animation,
      required String text}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            contentPadding: const EdgeInsets.all(16.0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                    height: 150,
                    child: Lottie.asset(animation,
                        fit: BoxFit.cover, repeat: false)),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    isLoading
                        ? const SizedBox.shrink()
                        : TextButton(
                            onPressed: onContinue ??
                                () {
                                  navigatorKey.currentState!.pop();
                                },
                            child: Text(
                              "Continue",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                      color: MyTheme.mainColor,
                                      fontWeight: FontWeight.w600),
                            )),
                  ],
                )
              ],
            ),
          );
        });
  }
}
