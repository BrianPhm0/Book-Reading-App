import 'package:book_store/features/book/presentation/pages/bottomnav/cart/review_page.dart';
import 'package:book_store/features/book/presentation/providers/route.dart';
import 'package:book_store/features/book/presentation/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ManageOrder extends StatefulWidget {
  const ManageOrder({super.key});

  @override
  State<ManageOrder> createState() => _ManageOrderState();
}

class _ManageOrderState extends State<ManageOrder> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Manage Order",
            style: TextStyle(
              fontSize: 35,
              fontFamily: 'Schyler',
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
          bottom: const TabBar(
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(
                fontSize: 18,
                fontFamily: 'Schyler',
                fontWeight: FontWeight.bold), // Active tab text style
            unselectedLabelStyle: TextStyle(
              fontSize: 16,
              fontFamily: 'Schyler',
            ), // Inactive tab text style
            tabs: [
              Tab(
                text: "Orders status",
              ),
              Tab(text: "Orders history"),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: TabBarView(
            children: [
              Center(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return buildStatus(context, index);
                  },
                  itemCount: 4,
                ),
              ), // Replace with your Orders widget
              Center(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return buildHistory(context, index);
                  },
                  itemCount: 4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStatus(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(AppRoute.detailStatus.name);
      },
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color:
                    Colors.grey.withOpacity(0.5), // Shadow color with opacity
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
                            text: "Awaiting comfirming",
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextCustom(
                            text: "Total money: \$160",
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHistory(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(AppRoute.detailHistory.name);
      },
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color:
                    Colors.grey.withOpacity(0.5), // Shadow color with opacity
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
                            text: "Completed",
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextCustom(
                            text: "Total money: \$160",
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Spacer(),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              _showReviewBookSheet(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.black, width: 2.0)),
                              child: const SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: Center(
                                  // Thêm Center để căn giữa
                                  child: TextCustom(
                                    text: "Review",
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              // context.pushNamed(AppRoute.cart.name);
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  border: Border.all(
                                      color: Colors.black, width: 2.0)),
                              child: const SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: Center(
                                  // Thêm Center để căn giữa
                                  child: TextCustom(
                                    text: "Buy Again",
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void _showReviewBookSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const ReviewPage();
      },
      isScrollControlled: true,
    );
  }
}
