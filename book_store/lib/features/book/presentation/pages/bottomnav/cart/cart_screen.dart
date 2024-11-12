import 'package:book_store/core/common/widgets/loader.dart';
import 'package:book_store/features/book/business/entities/cart/cart.dart';
import 'package:book_store/features/book/presentation/bloc/cart/bloc/cart_bloc.dart';
import 'package:book_store/features/book/presentation/providers/route.dart';
import 'package:book_store/features/book/presentation/widgets/app_bar.dart';
import 'package:book_store/features/book/presentation/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(GetCartEvent());
  }

  Widget buildItem(BuildContext context, int index, CartItem cart) {
    return CartCount(cart: cart);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {
        if (state is CartFailure) {}
      },
      builder: (context, state) {
        if (state is CartLoading) {
          return const Center(child: Loader(size: 50.0, color: Colors.black));
        } else if (state is GetCartSuccess) {
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
                              return buildItem(
                                  context, index, state.cart[index]);
                            },
                            itemCount: state.cart.length,
                          ),
                          const SizedBox(height: 15),
                          const TextCustom(
                            text: "Order Summary",
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(height: 10),
                          _buildSummaryRow(
                              "Subtotal", '${getTotal(state.cart)} VND'),
                          const SizedBox(height: 10),
                          _buildSummaryRow("Shipping", "30000 VND"),
                          const SizedBox(height: 10),
                          Container(
                            height: 1,
                            color: Colors.black,
                          ),
                          const SizedBox(height: 10),
                          _buildSummaryRow(
                              "Total", "${getTotal(state.cart) + 30000} VND",
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
        } else if (state is DeleteCartSuccess) {
          context.read<CartBloc>().add(GetCartEvent());
        } else if (state is CartFailure) {}
        return Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/cart/shopping_cart.png",
                  width: 150.0, // Set the width
                  height: 150.0, // Set the height
                ),
                const SizedBox(
                  height: 35,
                ),
                const TextCustom(
                  text: "Your Cart is empty",
                  fontSize: 35,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 15,
                ),
                const TextCustom(
                  text: "Continue Shopping",
                  fontSize: 25,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        );
      },
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

class CartCount extends StatefulWidget {
  final CartItem cart;
  const CartCount({super.key, required this.cart});

  @override
  State<CartCount> createState() => _CartCountState();
}

class _CartCountState extends State<CartCount> {
  late int quantity = widget.cart.quantity;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {
        if (state is DeleteCartSuccess) {
          // Immediately fetch the updated cart after deletion
          context
              .read<CartBloc>()
              .add(GetCartEvent()); // Trigger to reload cart
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: TextCustom(
                text: 'Delete item successfully',
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          );
        } else if (state is CartFailure) {
          // Show error if the delete failed
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: TextCustom(
                text: 'Failed to delete',
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          );
        }
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(bottom: 20),
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
                  widget.cart.bookItem!.image,
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
                      text: widget.cart.bookItem!.title,
                      color: Colors.white,
                      maxLines: 2,
                      fontSize: 25,
                    ),
                    TextCustom(
                      maxLines: 1,
                      text: widget.cart.bookItem!.authorName,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove, color: Colors.white),
                          onPressed: () {
                            setState(() {
                              if (quantity > 0) quantity--;
                              if (quantity == 0) {
                                Navigator.of(context).pop();
                              }
                            });
                          },
                        ),
                        const SizedBox(width: 5),
                        TextCustom(
                          text: '$quantity',
                          color: Colors.white,
                          fontSize: 25,
                        ),
                        const SizedBox(width: 5),
                        IconButton(
                          icon: const Icon(Icons.add, color: Colors.white),
                          onPressed: () {
                            setState(() {
                              quantity++;
                            });
                          },
                        )
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              Flexible(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          // Trigger the delete event
                          context.read<CartBloc>().add(DeleteCartEvent(
                              id: widget.cart.bookItem!.bookId));
                        },
                        child: const Icon(
                          Icons.close,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      TextCustom(
                        text: "${widget.cart.bookItem!.price} VND",
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

double getTotal(List<CartItem> cart) {
  double total = 0.0;
  for (var item in cart) {
    total += item.total;
  }
  return total;
}
