import 'package:book_store/features/book/presentation/pages/bottomnav/cart/review_page.dart';
import 'package:book_store/features/book/presentation/providers/route.dart';
import 'package:book_store/features/book/presentation/widgets/app_bar.dart';
import 'package:book_store/features/book/presentation/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailHistoryOrder extends StatefulWidget {
  const DetailHistoryOrder({super.key});

  @override
  State<DetailHistoryOrder> createState() => _DetailHistoryOrderState();
}

class _DetailHistoryOrderState extends State<DetailHistoryOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: "Order Status"),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3))
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.only(left: 15),
                        decoration: const BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15))),
                        width: double.infinity,
                        child: const TextCustom(
                            text: "Confirm", fontSize: 25, color: Colors.white),
                      )),
                  const Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.location_on),
                              FittedBox(
                                child: TextCustom(
                                  text: "Address",
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          FittedBox(
                            child: TextCustom(
                              text: "Pham | 0965323955",
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          FittedBox(
                            child: TextCustom(
                                text: "Tan Tao A, Binh Tan, Tp. HCM",
                                fontSize: 22,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(5),
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey
                        .withOpacity(0.5), // Shadow color with opacity
                    spreadRadius: 2, // Spread radius
                    blurRadius: 5, // Blur radius
                    offset: const Offset(0, 3), // Offset to give depth
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Flexible(
                    flex: 3,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: FittedBox(
                            child: Image.asset(
                              'assets/book_cover/book_cover.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Expanded(
                          flex: 3,
                          child: TextCustom(
                            text: "Venom the last dance",
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              TextCustom(
                                text: "x1",
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                              Spacer(),
                              TextCustom(
                                text: "Total money: \$160",
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(5),
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey
                        .withOpacity(0.5), // Shadow color with opacity
                    spreadRadius: 2, // Spread radius
                    blurRadius: 5, // Blur radius
                    offset: const Offset(0, 3), // Offset to give depth
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        FittedBox(
                          child: TextCustom(
                            text: "Support",
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      color: Colors.grey,
                      height: 2,
                      width: double.infinity,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const FittedBox(
                      child: Row(
                        children: [
                          Icon(Icons.phone),
                          SizedBox(
                            width: 5,
                          ),
                          TextCustom(
                            text: "Support Center",
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    const FittedBox(
                      child: Row(
                        children: [
                          Icon(Icons.chat),
                          SizedBox(
                            width: 5,
                          ),
                          TextCustom(
                              text: "Chat with BookHub",
                              fontSize: 22,
                              color: Colors.black),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _showReviewBookSheet(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 2.0)),
                      child: const SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: Center(
                          // Thêm Center để căn giữa
                          child: TextCustom(
                            text: "Review",
                            fontSize: 25,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      context.pushNamed(AppRoute.cart.name);
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(color: Colors.black, width: 2.0)),
                      child: const SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: Center(
                          // Thêm Center để căn giữa
                          child: TextCustom(
                            text: "Buy Again",
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }

  void _showReviewBookSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ReviewPage();
      },
      isScrollControlled: true,
    );
  }
}
