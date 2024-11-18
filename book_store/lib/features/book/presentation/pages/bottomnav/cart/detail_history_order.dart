import 'package:book_store/core/common/widgets/loader.dart';
import 'package:book_store/features/book/business/entities/book_by_category/book_item.dart';
import 'package:book_store/features/book/business/entities/order/order_id.dart';
import 'package:book_store/features/book/presentation/bloc/order/order_bloc.dart';
import 'package:book_store/features/book/presentation/pages/bottomnav/cart/review_page.dart';
import 'package:book_store/features/book/presentation/pages/bottomnav/categories/user_book_args.dart';
import 'package:book_store/features/book/presentation/providers/route.dart';
import 'package:book_store/features/book/presentation/widgets/app_bar.dart';
import 'package:book_store/features/book/presentation/widgets/custom_button.dart';
import 'package:book_store/features/book/presentation/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DetailHistoryOrder extends StatefulWidget {
  final String? id;
  const DetailHistoryOrder({super.key, this.id});

  @override
  State<DetailHistoryOrder> createState() => _DetailHistoryOrderState();
}

class _DetailHistoryOrderState extends State<DetailHistoryOrder> {
  final bool _hasReviewed = false;

  @override
  void initState() {
    context.read<OrderBloc>().add(GetOrderByIdEvent(widget.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderBloc, OrderState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is OrderLoading) {
          return const Center(child: Loader(size: 50.0, color: Colors.black));
        } else if (state is GetOrderIdSuccess) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: CustomAppBar(
              title: "Order History",
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  context.read<OrderBloc>().add(GetOrderEvent());
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return buildStatus(
                              context, index, state.order[index]);
                        },
                        itemCount: state.order.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const Center(child: Loader(size: 50.0, color: Colors.black));
      },
    );
  }
}

Widget buildStatus(
  BuildContext context,
  int index,
  OrderId orderId,
) {
  return GestureDetector(
    onTap: () {
      // context.pushNamed(AppRoute.detailHistory.name);
    },
    child: SizedBox(
      width: double.infinity,
      height: 150,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 4,
              child: Image.network(
                orderId.book!.image,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              flex: 11,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextCustom(
                    text: orderId.book!.title,
                    color: Colors.black,
                    maxLines: 2,
                    fontSize: 22,
                  ),
                  TextCustom(
                    maxLines: 1,
                    text: orderId.book!.authorName,
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  Row(
                    children: [
                      CustomButton(
                        name: 'Review',
                        borderColor: Colors.black,
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        rectangle: 5,
                        onPressed: () {
                          _showReviewBookSheet(context, orderId.book!);
                        },
                      ),
                      const SizedBox(width: 5),
                      CustomButton(
                        name: 'Buy Again',
                        borderColor: Colors.black,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        rectangle: 5,
                        onPressed: () {
                          context.pushNamed(
                            AppRoute.detailBook.name,
                            extra: UserBookArgs(book: orderId.book!),
                          );
                        },
                      ),
                    ],
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

void _showReviewBookSheet(BuildContext context, BookItem item) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return ReviewPage(
        bookId: item.bookId,
      );
    },
    isScrollControlled: true,
  );
}
