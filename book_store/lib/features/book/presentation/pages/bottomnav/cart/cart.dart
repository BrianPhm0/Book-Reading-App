import 'package:book_store/features/book/presentation/providers/route.dart';
import 'package:book_store/features/book/presentation/widgets/app_bar.dart';
import 'package:book_store/features/book/presentation/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartScreenState();
}

class _CartScreenState extends State<Cart> {
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
      appBar: CustomAppBar(
        title: "Cart",
        actions: [
          IconButton(
            onPressed: () {
              context.pushNamed(AppRoute.manageOrder.name);
            },
            icon: const Icon(
              Icons.notifications,
              color: Colors.black, // Set icon color to black
              size: 35, // Set icon size
            ),
          )
        ],
      ),
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
            SizedBox(
              width: double.infinity, // Chiều rộng bằng màn hình
              child: Column(children: [
                Container(
                  color: Colors.grey,
                  height: 1,
                ),
                InkWell(
                  onTap: () {
                    context.pushNamed(AppRoute.voucher.name);
                  },
                  child: const SizedBox(
                    height: 50,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.local_offer),
                              SizedBox(
                                width: 10,
                              ),
                              TextCustom(
                                  text: "Voucher",
                                  fontSize: 20,
                                  color: Colors.black),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.arrow_forward),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.grey,
                  height: 1,
                ),
                InkWell(
                  onTap: () {
                    context.pushNamed(AppRoute.checkout.name);
                  },
                  child: Container(
                    color: Colors.black,
                    child: const SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Center(
                        // Thêm Center để căn giữa
                        child: TextCustom(
                          text: "Check out",
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ]),
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
