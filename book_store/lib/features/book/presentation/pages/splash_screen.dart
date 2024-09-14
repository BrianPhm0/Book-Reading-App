import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.white),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Image(image: AssetImage('assets/book_icon.png'))],
            ),
          ),
        ));
  }
}
