import 'package:book_store/features/book/presentation/widgets/app_bar.dart';
import 'package:book_store/features/book/presentation/widgets/text_custom.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<String> categories = [
    'Non-fiction',
    'Classics',
    'Fantastic',
    'Young Adult',
    'Crime',
    'Hornor',
    'Sci-fi',
    'Drama'
  ];
  Widget buildItem(context, index) {
    return Container(
      // padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey,
      ),
      width: 50,
      height: 150,
      child: Stack(children: [
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: TextCustom(
              text: categories[index],
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'Categories',
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 140,
              crossAxisSpacing: 20,
              mainAxisSpacing: 30),
          itemBuilder: buildItem,
          itemCount: 8,
        ),
      ),
    );
  }
}
