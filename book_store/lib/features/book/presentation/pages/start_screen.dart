import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            children: [
              const Row(),
              Expanded(
                flex: 5,
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          color: Colors.black,
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            // Rotated background image
                            Image.asset(
                              'assets/book_background.png',
                              width: double.infinity,
                              height: 300,
                              fit: BoxFit.cover,
                            ),
                            // Positioned book icon on top
                            Positioned(
                              top: 240,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Image.asset(
                                  'assets/book_icon.png',
                                  height: 130,
                                  width: 130,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 4,
                  child: Container(
                    color: Colors.black,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
