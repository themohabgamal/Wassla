import 'package:flutter/material.dart';
import 'package:grad/core/helpers/constants/fonts/font_helper.dart';

class AboutUsScreen extends StatelessWidget {
  static const String routeName = 'about';

  const AboutUsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'About Us',
          style: FontHelper.poppins24Bold(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/wassla.png',
              width: 100,
            ),
            const SizedBox(height: 16),
            const Text(
              'Wassla',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Version 1.0.0',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'This app was crafted by ',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[700],
                      ),
                    ),
                    TextSpan(
                      text: 'Mohab Gamal',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[900],
                      ),
                    ),
                    TextSpan(
                      text:
                          ',\n a passionate developer dedicated to bringing innovation and seamless experiences to users worldwide. ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                    TextSpan(
                      text:
                          'We are committed to delivering excellence and user satisfaction. ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                    TextSpan(
                      text:
                          'Our goal is to provide not just functionality but an enriching experience that exceeds expectations. ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                    TextSpan(
                      text:
                          'Thank you for choosing our app and being a part of our journey towards innovation and excellence.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
