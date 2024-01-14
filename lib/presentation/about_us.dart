import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  static const String routeName = 'about';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('About Us'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 100,
            ),
            SizedBox(height: 16),
            Text(
              'MOJO',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Version 1.0.0',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'This app was created by Mohab Gamal. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla faucibus, sapien sed condimentum lacinia, nulla odio varius magna, vitae placerat eros mauris vel ipsum. Sednec ipsum risus. Fusce in blandit nisl. Donec dapibus quam sit amet dui ullamcorper, eu lacinia risus semper. Vestibulum id porta magna. Nulla facilisi. Nam sit amet leo vel magna egestas ultricies. Sed tristique massa in congue tincidunt. Sed euismod, urna ac euismod tempor, nulla lorem ultricies velit, id facilisis lorem nibh vel metus.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
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
