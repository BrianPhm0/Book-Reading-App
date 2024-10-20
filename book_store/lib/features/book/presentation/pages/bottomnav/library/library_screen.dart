import 'package:book_store/features/book/presentation/widgets/app_bar.dart';

import 'package:flutter/material.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  Widget buildItem(context, index) {
    return GestureDetector(
      onTap: () {
        print("haha");
      },
      child: Image.asset(
        'assets/book_cover/book_cover.png',
        fit: BoxFit.contain, // Maintains the original aspect ratio
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'Library',
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 280,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15),
          itemBuilder: buildItem,
          itemCount: 20,
        ),
      ),
    );
  }
}
