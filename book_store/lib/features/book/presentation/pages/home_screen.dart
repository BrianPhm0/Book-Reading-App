//Ges
//Scrollable
//Safe
//Searching
//Bottom navigation

import 'dart:async';

// import 'package:book_store/features/book/presentation/widgets/app_bar.dart';
import 'package:book_store/features/book/presentation/providers/route.dart';
import 'package:book_store/features/book/presentation/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PageController pageController;
  int pageNo = 0;

  Timer? carasouelTimer;

  //set time for pageNo
  Timer getTimer() {
    return Timer.periodic(const Duration(seconds: 2), (timer) {
      if (pageNo == 7) {
        // Sử dụng jumpToPage để ngay lập tức chuyển về trang đầu
        pageController.jumpToPage(0);
        pageNo = 0; // Đặt lại về trang 1 sau khi nhảy về trang đầu
      } else {
        pageController.animateToPage(pageNo,
            duration: const Duration(seconds: 1), curve: Curves.easeInOut);
        pageNo++;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    carasouelTimer = getTimer();
    pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.85,
    );
  }

  @override
  void dispose() {
    carasouelTimer?.cancel();

    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ///time
    List<String> time = ['This Week', 'This Month', 'This Year'];
    //Separate when get data to file book_liste
    //Best Deal
    Widget buildItem(context, index) {
      return Container(
        margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey,
        ),
        child: Text('$index'),
      );
    }

    //TopBook
    Widget buildItem1(context, index) {
      return Container(
        margin: const EdgeInsets.all(8),
        width: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFE3E8E9),
        ),
        child: Column(children: [
          Expanded(
              flex: 4,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: Image.asset(
                    'assets/book_cover/book_cover.png',
                    fit: BoxFit.fitHeight,
                  ),
                ),
              )),
          Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    color: Color(0xFF171515)),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(),
                      TextCustom(
                          text: 'young adult',
                          fontSize: 12,
                          color: Colors.white),
                      TextCustom(
                          text: 'Sorrow and Starlight',
                          fontSize: 18,
                          maxLines: 2,
                          textOverflow: TextOverflow.ellipsis,
                          color: Colors.white),
                      Spacer(),
                      TextCustom(
                          text: '\$25', fontSize: 20, color: Colors.white),
                    ],
                  ),
                ),
              ))
        ]),
      );
    }

    //Latest Book
    Widget buildItem2(context, index) {
      return Container(
        margin: const EdgeInsets.only(left: 8),
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 2),
          color: Colors.white,
        ),
        child: Center(
          child: TextCustom(
            text: time[index],
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Heading
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextCustom(
                        text: 'Happy Reading!',
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    IconButton(
                        onPressed: () {
                          context.pushNamed(AppRoute.account.name);
                        },
                        icon: const Icon(
                          Icons.account_circle,
                          color: Colors.black,
                          size: 45,
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                alignment: Alignment.topLeft,
                child: const TextCustom(
                    text: 'Best Deals', fontSize: 30, color: Colors.black),
              ),
              // /Best Deals
              // /List Horizontal
              SizedBox(
                height: 180,
                child: PageView.builder(
                    onPageChanged: (index) {
                      pageNo = index;
                      setState(() {});
                    },
                    itemCount: 7,
                    controller: pageController,
                    itemBuilder: (_, index) {
                      return AnimatedBuilder(
                        animation: pageController,
                        builder: (context, index) {
                          return index!;
                        },
                        child: GestureDetector(
                            onTap: () {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('heelo'),
                              ));
                            },
                            onPanDown: (d) {
                              carasouelTimer?.cancel();
                              carasouelTimer = null;
                            },
                            onPanCancel: () {
                              carasouelTimer = getTimer();
                            },
                            child: buildItem(context, index)),
                      );
                    }),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  7,
                  (index) => Container(
                    margin: const EdgeInsets.all(
                        2.0), // Adjust the width of the SizedBox to provide spacing
                    child: Icon(
                      Icons.circle,
                      size: 12.0,
                      color: pageNo == index ? Colors.black : Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                  margin: const EdgeInsets.only(right: 20, left: 20),
                  alignment: Alignment.topLeft,
                  child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextCustom(
                            text: 'Top Books',
                            fontSize: 30,
                            color: Colors.black),
                        TextCustom(
                            text: 'See more', fontSize: 20, color: Colors.black)
                      ])),

              /// time
              Container(
                padding: const EdgeInsets.all(8),
                height: 60,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: buildItem2,
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: time.length),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                height: 300,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: buildItem1,
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: 8),
              ),

              Container(
                  margin: const EdgeInsets.only(right: 20, left: 20),
                  alignment: Alignment.topLeft,
                  child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextCustom(
                            text: 'Latest Books',
                            fontSize: 30,
                            color: Colors.black),
                        TextCustom(
                            text: 'See more', fontSize: 20, color: Colors.black)
                      ])),

              Container(
                padding: const EdgeInsets.all(8),
                height: 300,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: buildItem1,
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: 8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
