import 'package:book_store/features/book/presentation/providers/route.dart';
import 'package:book_store/features/book/presentation/widgets/app_bar.dart';
import 'package:book_store/features/book/presentation/widgets/custom_button.dart';
import 'package:book_store/features/book/presentation/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      height: 160,
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
                  TextCustom(
                    text: "Novel",
                    color: Colors.white,
                    fontSize: 10,
                  ),
                  TextCustom(
                    text: "TuesDay Mooney Talks to Ghost",
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  TextCustom(
                    text: "Kate Racculia",
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  Spacer(),
                  Row(children: [
                    Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    TextCustom(
                      text: "1",
                      color: Colors.white,
                      fontSize: 25,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ]),
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
        child: Column(
          children: [
            Expanded(
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
                      itemCount: 2,
                    ),
                    const SizedBox(height: 15),
                    const TextCustom(
                      text: "Order Summary",
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 10),
                    _buildSummaryRow("Subtotal", "\$50.00"),
                    const SizedBox(height: 10),
                    _buildSummaryRow("Shipping", "\$10.00"),
                    const SizedBox(height: 10),
                    Container(
                      height: 1,
                      color: Colors.black,
                    ),
                    const SizedBox(height: 10),
                    _buildSummaryRow("Total", "\$60.00",
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: SizedBox(
                height: 45,
                width: double.infinity, // Chiều rộng bằng màn hình
                child: CustomButton(
                  rectangle: 5,
                  name: "Proceed to Checkout",
                  onPressed: () {
                    context.pushNamed(AppRoute.checkout.name);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Row _buildSummaryRow(String title, String amount,
    {double fontSize = 20, FontWeight fontWeight = FontWeight.normal}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      TextCustom(
        text: title,
        fontSize: fontSize,
        color: Colors.black,
      ),
      TextCustom(
        text: amount,
        fontSize: fontSize,
        color: Colors.black,
        fontWeight: fontWeight,
      ),
    ],
  );
}
