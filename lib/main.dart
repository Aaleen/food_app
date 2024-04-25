import 'package:donut_app/screens/home_screen.dart';
import 'package:donut_app/screens/login_screen.dart';
import 'package:donut_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food App',
      home: SplashScreen(),
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
    );
  }
}
