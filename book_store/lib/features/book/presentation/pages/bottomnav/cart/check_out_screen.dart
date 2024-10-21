import 'package:book_store/features/book/presentation/pages/bottomnav/cart/address_bottom_sheet.dart';
import 'package:book_store/features/book/presentation/pages/bottomnav/cart/payment_bottom_sheet.dart';
import 'package:book_store/features/book/presentation/providers/route.dart';
import 'package:book_store/features/book/presentation/widgets/app_bar.dart';
import 'package:book_store/features/book/presentation/widgets/custom_button.dart';
import 'package:book_store/features/book/presentation/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  List<String> payment = ['Momo', 'Paypal', 'Cash'];

  int selectedPayment = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: "Checkout"),
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const TextCustom(
                          text: "Delivering Address",
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Flexible(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FittedBox(
                                        child: TextCustom(
                                          text: "Pham | 0965323955",
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      FittedBox(
                                        child: TextCustom(
                                            text:
                                                "Tan Tao A, Binh Tan, Tp. HCM",
                                            fontSize: 22,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: () {
                                      _showAddressOption(context);
                                    },
                                    child: const TextCustom(
                                      text: "Change",
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: Colors.black, width: 2)),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const TextCustom(
                                        text: "Payment Method",
                                        fontSize: 25,
                                        color: Colors.black),
                                    InkWell(
                                      onTap: () {
                                        _showPayment(context);
                                      },
                                      child: const TextCustom(
                                        text: "Change",
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  height: 2,
                                  color: Colors.black,
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.check_circle,
                                        size: 30,
                                        color: Colors.black,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      TextCustom(
                                          text: payment[selectedPayment],
                                          fontSize: 30,
                                          color: Colors.black),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: CustomButton(
                        name: "Pay \$60",
                        onPressed: () {
                          context.goNamed(AppRoute.paymentSuccess.name);
                        },
                        size: 20,
                        rectangle: 5,
                      )),
                ],
              ))),
    );
  }

  void _showAddressOption(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return const AddressBottomSheet();
        });
  }

  void _showPayment(BuildContext context) async {
    final result = await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return PaymentBottomSheet(
            selectedPayment: selectedPayment,
          );
        });
    if (result != null) {
      setState(() {
        selectedPayment = result;
      });
    }
  }
}
