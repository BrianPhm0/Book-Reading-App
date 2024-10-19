import 'package:book_store/features/book/presentation/widgets/app_bar.dart';
import 'package:book_store/features/book/presentation/widgets/text_custom.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Widget buildItem(BuildContext context, int index) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(bottom: 20),
      height: 180,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Flexible(
            flex: 4,
            child: Image.asset(
              'assets/book_cover/book_cover.png',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          const Flexible(
            flex: 5,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Spacer(),
                  const TextCustom(
                    text: "Novel",
                    color: Colors.white,
                    fontSize: 10,
                  ),
                  const TextCustom(
                    text: "TuesDay Mooney Talks to Ghost",
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  const TextCustom(
                    text: "Kate Racculia",
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  Spacer(),
                  const TextCustom(
                    text: "Kate Racculia",
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  Spacer(),
                ]),
          ),
          const Flexible(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.close,
                    size: 30,
                    color: Colors.white,
                  ),
                  FittedBox(
                    child: TextCustom(
                      text: "\$105.00",
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: "Cart"),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return buildItem(context, index);
                },
                itemCount: 2)
          ],
        ),
      )),
    );
  }
}
