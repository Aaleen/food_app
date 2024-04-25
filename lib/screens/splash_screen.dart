import 'package:donut_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    // Add a delay before navigating to the next screen
    Future.delayed(Duration(seconds: 2), () {
      // Navigate to the next screen and replace the current screen in the stack
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Login()), // Replace NextScreen with your actual next screen widget
      );
    });

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            colors: [Colors.purple[500]!, Colors.black45!],
          ),
          // color: Colors.indigo,
          image: DecorationImage(image: AssetImage('assets/images/splash.png')),
        ),
        // child: Center(
        //   child: Text(
        //     "Food Kitchen",
        //     style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        //   ),
        // ),
      ),
    );
  }
}
