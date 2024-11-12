import 'package:book_store/features/book/business/entities/book_by_category/book_item.dart';
import 'package:book_store/features/book/business/entities/user/user.dart';
import 'package:book_store/features/book/presentation/bloc/book/bloc/home/home_bloc.dart';
import 'package:book_store/features/book/presentation/bloc/cart/bloc/cart_bloc.dart';
import 'package:book_store/features/book/presentation/providers/route.dart';
import 'package:book_store/features/book/presentation/widgets/app_bar.dart';
import 'package:book_store/features/book/presentation/widgets/custom_button.dart';
import 'package:book_store/features/book/presentation/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';

class DetailBook extends StatefulWidget {
  final BookItem book;
  final User? user;
  final String? brandName;
  // final BookDetail? bookDetail;

  const DetailBook({super.key, required this.book, this.user, this.brandName});

  @override
  State<DetailBook> createState() => _DetailBookState();
}

class _DetailBookState extends State<DetailBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Book Detail",
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.read<HomeBloc>().add(GetHomeBookEvent());
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
          child: DefaultTabController(
        length: 2,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextCustom(
                        text: widget.book.title,
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Flexible(
                            flex: 4,
                            child: Image.network(
                              widget.book.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextCustom(
                                  text: 'Author: ${widget.book.authorName}',
                                  fontSize: 25,
                                  color: Colors.black,
                                ),
                                TextCustom(
                                  text: 'Category: ${widget.brandName ?? ''}',
                                  fontSize: 25,
                                  color: Colors.black,
                                ),
                                TextCustom(
                                  text: 'Rating: ${widget.book.rating}/5',
                                  fontSize: 25,
                                  color: Colors.black,
                                ),
                                FittedBox(
                                  child: TextCustom(
                                    text:
                                        'Pricing: ${widget.book.price.toString()} VND',
                                    fontSize: 25,
                                    color: Colors.black,
                                  ),
                                ),
                                CustomButton(
                                  rectangle: 5,
                                  size: 25,
                                  name: 'Ebook',
                                  onPressed: () {
                                    _showAlertDialog(context);
                                  },
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                CustomButton(
                                  rectangle: 5,
                                  size: 25,
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black,
                                  name: 'HardCover',
                                  onPressed: () {
                                    _showBottomDialog(context, widget.book);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const TabBar(
                          indicatorColor: Colors.black,
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.grey,
                          labelStyle: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Schyler',
                              fontWeight: FontWeight.bold),
                          tabs: [
                            Tab(text: 'Description'),
                            Tab(text: 'Reviews'),
                          ]),
                      SizedBox(
                        height: 600,
                        child: TabBarView(children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: SingleChildScrollView(
                              child: TextCustom(
                                text: widget.book.description,
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          ListView.separated(
                              itemBuilder: (context, index) {
                                return ListTile(
                                    leading: const Icon(
                                      Icons.account_circle,
                                      size: 55,
                                    ),
                                    title: const TextCustom(
                                        text: "PhamDuc",
                                        fontSize: 20,
                                        color: Colors.black),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RatingBar.builder(
                                          initialRating: 3,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 20,
                                          itemPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 1.0),
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.black,
                                          ),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        ),
                                        const TextCustom(
                                            text:
                                                "good very very very good hahahaaa",
                                            fontSize: 18,
                                            color: Colors.black),
                                      ],
                                    ));
                              },
                              separatorBuilder: (context, index) {
                                return const Divider();
                              },
                              itemCount: 10)
                        ]),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        // ignore: avoid_types_as_parameter_names
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.black, width: 2),
            ),
            backgroundColor: Colors.white,
            title: const TextCustom(
                text: "Purchase Confirmation",
                fontSize: 25,
                color: Colors.black),
            content: TextCustom(
                text:
                    "Are you sure you want to buy this Ebook for ${widget.book.price} VND?",
                fontSize: 20,
                color: Colors.black),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const TextCustom(
                      text: "Cancel", fontSize: 20, color: Colors.red)),
              TextButton(
                  onPressed: () {
                    // Add your buy logic here
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const TextCustom(
                      text: "Confirm", fontSize: 20, color: Colors.black)),
            ],
          );
        });
  }

  void _showBottomDialog(BuildContext context, BookItem book) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return QuantitySelector(book: book);
      },
    );
  }
}

class QuantitySelector extends StatefulWidget {
  final BookItem book;
  const QuantitySelector({super.key, required this.book});

  @override
  State<QuantitySelector> createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {
        if (state is PostCartSuccess) {
          if (state.result.isNotEmpty) {}
        } else if (state is CartFailure) {
          // Hiển thị lỗi nếu thêm thất bại
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: TextCustom(
                    text: 'Fail to add', fontSize: 20, color: Colors.white)),
          );
        }
      },
      child: Container(
        height: 400,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  flex: 3,
                  child: Image.network(
                    widget.book.image,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Flexible(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: TextCustom(
                            text: "Pricing: ${widget.book.price} VND",
                            fontSize: 25,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextCustom(
                          text: "Inventory: ${widget.book.quantity}",
                          fontSize: 20,
                          color: Colors.black),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            TextCustom(
              text: widget.book.title,
              fontSize: 25,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity, // Chiều rộng bằng màn hình
              child: Column(children: [
                Container(
                  color: Colors.grey,
                  height: 1,
                ),
                SizedBox(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.book),
                            SizedBox(
                              width: 10,
                            ),
                            TextCustom(
                                text: "Quantity",
                                fontSize: 20,
                                color: Colors.black),
                          ],
                        ),
                        Row(children: [
                          IconButton(
                            icon: const Icon(Icons.remove, color: Colors.black),
                            onPressed: () {
                              setState(() {
                                if (quantity > 0) quantity--;
                                if (quantity == 0) {
                                  Navigator.of(context).pop();
                                }
                              });
                            },
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          TextCustom(
                            text: "$quantity",
                            color: Colors.black,
                            fontSize: 25,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            icon: const Icon(Icons.add, color: Colors.black),
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            },
                          )
                        ]),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          context
                              .read<CartBloc>()
                              .add(PostCartEvent(widget.book.bookId, quantity));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: TextCustom(
                                    text: 'Add items successfully',
                                    fontSize: 20,
                                    color: Colors.white)),
                          );
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.black, width: 2.0)),
                          child: const SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: Center(
                              // Thêm Center để căn giữa
                              child: TextCustom(
                                text: "Add To Cart",
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
                          context
                              .read<CartBloc>()
                              .add(PostCartEvent(widget.book.bookId, quantity));
                          context.pushNamed(AppRoute.cart.name);
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border:
                                  Border.all(color: Colors.black, width: 2.0)),
                          child: const SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: Center(
                              // Thêm Center để căn giữa
                              child: TextCustom(
                                text: "Buy Now",
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
              ]),
            ),
            // Add more buttons as needed
          ],
        ),
      ),
    );
  }
}
