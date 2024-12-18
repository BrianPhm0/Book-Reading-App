import 'package:book_store/core/common/widgets/loader.dart';
import 'package:book_store/features/book/business/entities/cart/cart.dart';
import 'package:book_store/features/book/business/entities/voucher/voucher.dart';
import 'package:book_store/features/book/presentation/bloc/auth/auth_bloc.dart';
import 'package:book_store/features/book/presentation/bloc/cart/bloc/cart_bloc.dart';
import 'package:book_store/features/book/presentation/providers/route.dart';
import 'package:book_store/features/book/presentation/widgets/app_bar.dart';
import 'package:book_store/features/book/presentation/widgets/custom_text_button.dart';
import 'package:book_store/features/book/presentation/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Cart extends StatefulWidget {
  final Voucher? initVoucher;
  final int? initIndex;
  const Cart({super.key, this.initVoucher, this.initIndex});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  late Voucher? _selectedVoucher;
  late int? _selectedIndex;
  @override
  void initState() {
    super.initState();
    _selectedVoucher = widget.initVoucher;
    _selectedIndex = widget.initIndex;
    context.read<CartBloc>().add(GetCartEvent());
  }

  Widget buildItem(BuildContext context, int index, CartItem cart) {
    return CartCount(cart: cart);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthFailure) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: const CustomAppBar(
              title: "Cart",
            ),
            body: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  padding: const EdgeInsets.only(top: 50),
                  child: Wrap(
                    alignment: WrapAlignment
                        .center, // Căn giữa các phần tử theo chiều ngang
                    spacing:
                        10.0, // Khoảng cách giữa các phần tử theo chiều ngang
                    runSpacing: 10.0, // Khoảng cách giữa các dòng
                    children: [
                      const TextCustom(
                        textAlign: TextAlign.center,
                        text: "You need to log in to access cart!",
                        fontSize: 22,
                        color: Colors.black,
                      ),
                      CustomTextButton(
                        fontSize: 22,
                        name: 'Login',
                        onPressed: () {
                          // Điều hướng đến màn hình đăng nhập
                          context.pushNamed(AppRoute.login.name);
                        },
                        underlineCheck: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (state is AuthTokenSuccess) {
          context.read<AuthBloc>().add(AuthGetUser());
        } else if (state is AuthSuccess) {
          context.read<CartBloc>().add(GetCartEvent());
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
                          // ListView.builder(
                          //   shrinkWrap: true,
                          //   itemBuilder: (context, index) {
                          //     return buildItem(
                          //         context, index, state.cart[index]);
                          //   },
                          //   itemCount: state.cart.length,
                          // ),
                          const SizedBox(height: 15),
                          const TextCustom(
                            text: "Order Summary",
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          // const SizedBox(height: 10),
                          // _buildSummaryRow(
                          //     "Subtotal", '${getTotal(state.cart)} VND'),
                          // const SizedBox(height: 10),
                          // _buildSummaryRow("Shipping", "0 VND"),
                          const SizedBox(height: 10),
                          Container(
                            height: 1,
                            color: Colors.black,
                          ),
                          const SizedBox(height: 10),
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.end,
                          //   children: [
                          //     // Original price with strikethrough, shown only if there's a discount
                          //     if (_selectedVoucher != null &&
                          //         _selectedVoucher!.discount > 0)
                          //       Text(
                          //         "${getTotal(state.cart).toStringAsFixed(2)} VND",
                          //         style: const TextStyle(
                          //           fontFamily: 'Schyler',
                          //           fontSize: 23,
                          //           color: Colors.grey,
                          //           decoration: TextDecoration
                          //               .lineThrough, // Strikethrough
                          //         ),
                          //       ),

                          //     // Discounted total
                          //     _buildSummaryRow(
                          //       "Total",
                          //       "${double.parse((getTotal(state.cart) * (1 - (_selectedVoucher?.discount ?? 0))).toStringAsFixed(2)).toInt()} VND",
                          //       fontSize: 25,
                          //       fontWeight: FontWeight.bold,
                          //     ),
                          //   ],
                          // )
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   width: double.infinity, // Chiều rộng bằng màn hình
                  //   child: Column(children: [
                  //     Container(
                  //       color: Colors.grey,
                  //       height: 1,
                  //     ),
                  // InkWell(
                  //   onTap: () async {
                  //     final result = await context.pushNamed(
                  //         AppRoute.voucher.name,
                  //         extra: _selectedIndex ?? -1);

                  // if (result != null && result is VoucherArgs) {
                  // setState(() {
                  //   _selectedVoucher = result.voucher;
                  //   _selectedIndex = result.index;
                  // });

                  //   if (_selectedVoucher != null &&
                  //       _selectedVoucher!.minCost >
                  //           getTotal(state.cart)) {
                  //     showSnackBar(
                  // ignore: use_build_context_synchronously
                  //         context,
                  //         'Does not satisfy the condition');
                  //     setState(() {
                  //       _selectedVoucher = null;
                  //       _selectedIndex = null;
                  //     });
                  //   }
                  // }
                  // },
                  //       child: SizedBox(
                  //         height: 50,
                  //         child: Padding(
                  //           padding: const EdgeInsets.only(left: 20, right: 20),
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             crossAxisAlignment: CrossAxisAlignment.center,
                  //             children: [
                  //               const Row(
                  //                 children: [
                  //                   Icon(Icons.local_offer),
                  //                   SizedBox(
                  //                     width: 10,
                  //                   ),
                  //                   TextCustom(
                  //                       text: "Voucher",
                  //                       fontSize: 20,
                  //                       color: Colors.black),
                  //                 ],
                  //               ),
                  //               _selectedVoucher != null
                  //                   ? TextCustom(
                  //                       text:
                  //                           '-${_selectedVoucher!.discount * 100}%',
                  //                       fontSize: 26,
                  //                       fontWeight: FontWeight.bold,
                  //                       color: Colors.black)
                  //                   : const Icon(Icons.arrow_forward)
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     Container(
                  //       color: Colors.grey,
                  //       height: 1,
                  //     ),
                  //     InkWell(
                  //       onTap: () {
                  //         context.pushNamed(AppRoute.checkout.name,
                  //             extra: _selectedVoucher?.voucherCode ?? '');
                  //       },
                  //       child: Container(
                  //         color: Colors.black,
                  //         child: const SizedBox(
                  //           width: double.infinity,
                  //           height: 50,
                  //           child: Center(
                  //             // Thêm Center để căn giữa
                  //             child: TextCustom(
                  //               text: "Check out",
                  //               fontSize: 25,
                  //               color: Colors.white,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     )
                  //   ]),
                  // ),
                ],
              ),
            ),

            //   return Container(
            //     color: Colors.white,
            //     child: Center(
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Image.asset(
            //             "assets/cart/shopping_cart.png",
            //             width: 150.0, // Set the width
            //             height: 150.0, // Set the height
            //           ),
            //           const SizedBox(
            //             height: 35,
            //           ),
            //           const TextCustom(
            //             text: "Your Cart is empty",
            //             fontSize: 35,
            //             color: Colors.black,
            //             fontWeight: FontWeight.bold,
            //           ),
            //           const SizedBox(
            //             height: 15,
            //           ),
            //           const TextCustom(
            //             text: "Continue Shopping",
            //             fontSize: 25,
            //             color: Colors.black,
            //           ),
            //         ],
            //       ),
            //     ),
            //   );
            // }
          );
        }
        return const Center(child: Loader(size: 50.0, color: Colors.black));
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
  late int quantity = int.parse(widget.cart.quantity);

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {
        if (state is DeleteCartSuccess) {
          context.read<CartBloc>().add(GetCartEvent());
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
                            if (quantity > 1) {
                              setState(() {
                                quantity--;
                                _updateQuantity(quantity);
                              });
                            } else {
                              context.read<CartBloc>().add(DeleteCartEvent(
                                  id: widget.cart.bookItem!.bookId));
                            }
                          },
                        ),
                        TextCustom(
                          text: '$quantity',
                          color: Colors.white,
                          fontSize: 25,
                        ),
                        IconButton(
                          icon: const Icon(Icons.add, color: Colors.white),
                          onPressed: () {
                            setState(() {
                              quantity++;
                              _updateQuantity(quantity);
                            });
                          },
                        ),
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

  void _updateQuantity(int quantity) {
    context.read<CartBloc>().add(UpdateItemEvent(
          widget.cart.bookItem?.bookId ?? '',
          quantity,
        ));
  }
}

double getTotal(List<CartItem> cart) {
  double total = 0.0;
  for (var item in cart) {
    total += double.parse(item.total);
  }
  return total;
}
