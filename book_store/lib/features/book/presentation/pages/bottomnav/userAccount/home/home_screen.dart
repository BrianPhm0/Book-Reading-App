import 'dart:async';
import 'package:book_store/core/common/widgets/loader.dart';
import 'package:book_store/features/book/business/entities/book_by_category/book_item.dart';
import 'package:book_store/features/book/presentation/bloc/auth/auth_bloc.dart';
import 'package:book_store/features/book/presentation/bloc/book/bloc/home/home_bloc.dart';
import 'package:book_store/features/book/presentation/pages/bottomnav/categories/user_book_args.dart';
import 'package:book_store/features/book/presentation/providers/route.dart';
import 'package:book_store/features/book/presentation/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PageController pageController;
  int pageNo = 0;
  String? token;

  Timer? carouselTimer;

  // Tạo Timer để tự động chuyển trang
  Timer getTimer() {
    return Timer.periodic(const Duration(seconds: 2), (timer) {
      if (pageController.hasClients) {
        // Kiểm tra nếu pageController đã có client
        if (pageNo == 5) {
          pageController.jumpToPage(0); // Quay lại trang đầu tiên
          pageNo = 0;
        } else {
          pageController.animateToPage(
            pageNo,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
          pageNo++;
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // getToken();
    // print(getToken());
    context.read<HomeBloc>().add(GetHomeBookEvent());
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   final state = context.read<HomeBloc>().state;
    //   if (state is! HomeSuccess) {
    //     context.read<HomeBloc>().add(GetHomeBookEvent());
    //   }
    // });

    // Khởi tạo PageController và Timer
    pageController = PageController(initialPage: 0, viewportFraction: 0.85);
    carouselTimer = getTimer();
  }

  @override
  void dispose() {
    carouselTimer?.cancel(); // Hủy Timer khi không còn sử dụng
    pageController.dispose(); // Giải phóng PageController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Widget hiển thị từng mục sách "Best Deal"
    Widget buildItem(
      BuildContext context,
      int index,
      BookItem item,
    ) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        alignment: Alignment.center,
        height: 160,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              Flexible(
                flex: 4,
                child: Image.network(
                  item.image,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                flex: 5,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Spacer(),
                      TextCustom(
                        text: item.authorName,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      TextCustom(
                        text: item.title,
                        color: Colors.white,
                        fontSize: 23,
                      ),
                      const Spacer(),
                      TextCustom(
                        maxLines: 2,
                        text: "${item.price} VND",
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      const Spacer(),
                    ]),
              ),
            ],
          ),
        ),
      );
    }

    // Widget hiển thị từng mục sách "Top Book"
    Widget buildTopBookItem(BuildContext context, int index, BookItem item,
        {required VoidCallback onTap}) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
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
                    child: Image.network(
                      item.image,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextCustom(
                            text: item.authorName,
                            fontSize: 12,
                            color: Colors.white),
                        TextCustom(
                            text: item.title,
                            fontSize: 18,
                            maxLines: 2,
                            textOverflow: TextOverflow.ellipsis,
                            color: Colors.white),
                        const Spacer(),
                        TextCustom(
                            text: '${item.price} VND',
                            fontSize: 20,
                            color: Colors.white),
                      ],
                    ),
                  ),
                ))
          ]),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Tiêu đề và nút tài khoản
              Padding(
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
                          context.read<AuthBloc>().add(AuthGetUser());
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
              const SizedBox(height: 20),
              // Phần tiêu đề "Best Deals"
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return Container(
                      margin: const EdgeInsets.only(top: 200),
                      child: const Center(
                          child: Loader(size: 50.0, color: Colors.black)),
                    );
                  } else if (state is HomeSuccess) {
                    return Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 20),
                          alignment: Alignment.topLeft,
                          child: const TextCustom(
                              text: 'Best Deals',
                              fontSize: 30,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 180,
                          child: PageView.builder(
                              onPageChanged: (index) {
                                pageNo = index;
                                setState(() {});
                              },
                              itemCount: state.bestDeal.length,
                              controller: pageController,
                              itemBuilder: (_, index) {
                                return GestureDetector(
                                  onTap: () {
                                    // print("heheh");
                                    // print(getToken().toString());
                                    context.pushNamed(
                                      AppRoute.detailBook.name,
                                      extra: UserBookArgs(
                                        book: state.bestDeal[index],
                                      ),
                                    );
                                  },
                                  onPanDown: (_) {
                                    carouselTimer?.cancel();
                                    carouselTimer = null;
                                  },
                                  onPanCancel: () {
                                    carouselTimer = getTimer();
                                  },
                                  child: buildItem(
                                    context,
                                    index,
                                    state.bestDeal[index],
                                  ),
                                );
                              }),
                        ),
                        // Chấm đánh dấu trang hiện tại
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            state.bestDeal.length,
                            (index) => Container(
                              margin: const EdgeInsets.all(2.0),
                              child: Icon(
                                Icons.circle,
                                size: 12.0,
                                color: pageNo == index
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Phần tiêu đề "Top Books"
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          alignment: Alignment.topLeft,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextCustom(
                                  text: 'Top Books',
                                  fontSize: 30,
                                  color: Colors.black),
                            ],
                          ),
                        ),
                        // Danh sách ngang "Top book"
                        Container(
                          padding: const EdgeInsets.all(8),
                          height: 300,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return buildTopBookItem(
                                    context, index, state.topBooks[index],
                                    onTap: () {
                                  context.pushNamed(
                                    AppRoute.detailBook.name,
                                    extra: UserBookArgs(
                                      book: state.topBooks[index],
                                    ),
                                  );
                                });
                              },
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemCount: state.topBooks.length),
                        ),
                        // Phần tiêu đề "Latest Books"
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          alignment: Alignment.topLeft,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextCustom(
                                  text: 'Latest Books',
                                  fontSize: 30,
                                  color: Colors.black),
                            ],
                          ),
                        ),
                        // Danh sách ngang "Latest Books"
                        Container(
                          padding: const EdgeInsets.all(8),
                          height: 300,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.latestBooks.length,
                              itemBuilder: (context, index) {
                                final book = state.latestBooks[index];
                                return buildTopBookItem(context, index, book,
                                    onTap: () {
                                  context.pushNamed(
                                    AppRoute.detailBook.name,
                                    extra: UserBookArgs(
                                      book: book,
                                    ),
                                  );
                                });
                              }),
                        ),
                      ],
                    );
                  }
                  return Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        padding: const EdgeInsets.only(top: 50),
                        child: const TextCustom(
                          text:
                              "No content available at the moment. Please check back later!",
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
              // Danh sách ngang "Best Deals"
            ],
          ),
        ),
      ),
    );
  }
}
