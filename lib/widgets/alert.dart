import 'package:grad/theming/theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Alert {
  static showAlert(BuildContext context, String animation, String text) {
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
                        ?.copyWith(color: Colors.grey[800]),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
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
