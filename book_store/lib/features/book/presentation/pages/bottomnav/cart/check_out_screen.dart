import 'package:book_store/core/common/widgets/loader.dart';
import 'package:book_store/core/utils/show_snackbar.dart';
import 'package:book_store/features/book/business/entities/address/address.dart';
import 'package:book_store/features/book/presentation/bloc/auth/auth_bloc.dart';
import 'package:book_store/features/book/presentation/bloc/check/check_bloc.dart';
import 'package:book_store/features/book/presentation/pages/bottomnav/cart/address_bottom_sheet.dart';
import 'package:book_store/features/book/presentation/pages/bottomnav/cart/payment_bottom_sheet.dart';
import 'package:book_store/features/book/presentation/providers/route.dart';
import 'package:book_store/features/book/presentation/widgets/app_bar.dart';
import 'package:book_store/features/book/presentation/widgets/custom_button.dart';
import 'package:book_store/features/book/presentation/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CheckOutScreen extends StatefulWidget {
  final String? voucher;
  const CheckOutScreen({super.key, this.voucher});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  List<String> payment = ['Cash', 'Paypal', 'Momo'];
  Address? addressDefault;
  late String _voucher;
  int selectedPayment = 0;
  int selectedAddressIndex = -1;

  @override
  void initState() {
    super.initState();
    if (widget.voucher == null) {
      _voucher = '';
    } else {
      _voucher = widget.voucher!;
    }
    context.read<CheckBloc>().add(ResetCheckEvent());
    context.read<AuthBloc>().add(AuthGetUser());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: "Checkout"),
      body: BlocConsumer<CheckBloc, CheckState>(
        listener: (context, state) {
          if (state is CheckSuccess) {
            // print(state);
            context.read<CheckBloc>().add(ResetCheckEvent());
            context.goNamed(AppRoute.paymentSuccess.name);
          }
        },
        builder: (context, state) {
          if (state is CheckLoading) {
            return const Center(child: Loader(size: 50.0, color: Colors.black));
          }
          return BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                final user = state.user;

                if ((user.fullname?.isNotEmpty ?? false) &&
                    (user.phone?.isNotEmpty ?? false) &&
                    (user.address?.isNotEmpty ?? false)) {
                  final userAddress = Address(
                    user.fullname!,
                    user.phone!,
                    user.address!,
                  );

                  // Assign to addressDefault only if all fields are valid
                  setState(() {
                    addressDefault = userAddress;
                  });
                }
              }
            },
            child: SafeArea(
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
                          const SizedBox(height: 20),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        FittedBox(
                                          child: TextCustom(
                                            text: addressDefault != null
                                                ? "${addressDefault!.name} | ${addressDefault?.phone}"
                                                : "Name | Phone",
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        FittedBox(
                                          child: TextCustom(
                                            text: addressDefault?.address ??
                                                "Your address",
                                            fontSize: 22,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: InkWell(
                                      onTap: () => _showAddressOption(context),
                                      child: TextCustom(
                                        text: addressDefault != null
                                            ? "Change"
                                            : "Choose",
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
                          const SizedBox(height: 20),
                          Container(
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black, width: 2),
                            ),
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
                                        color: Colors.black,
                                      ),
                                      InkWell(
                                        onTap: () => _showPayment(context),
                                        child: const TextCustom(
                                          text: "Change",
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
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
                                        const SizedBox(width: 10),
                                        SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: Image.asset(
                                            fit: BoxFit.contain,
                                            "assets/payment/payment${selectedPayment + 1}.png",
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        TextCustom(
                                          text: payment[selectedPayment],
                                          fontSize: 30,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: CustomButton(
                        name: "Pay",
                        onPressed: () {
                          if (addressDefault?.name != null) {
                            // print('haha');
                            context.read<CheckBloc>().add(PayCashEvent(
                                addressDefault!.name,
                                addressDefault!.phone,
                                addressDefault!.address,
                                _voucher));
                          } else {
                            showSnackBar(context, 'Please choose your address');
                          }
                        },
                        size: 20,
                        rectangle: 5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showAddressOption(BuildContext context) async {
    final result = await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return AddressBottomSheet(
          initialSelectedAddress: addressDefault,
          onAddressSelected: (selectedAddress, index) {
            Navigator.pop(
                context, {'address': selectedAddress, 'index': index});
          },
        );
      },
    );

    if (result != null) {
      setState(() {
        addressDefault = result['address'] as Address; // Cập nhật địa chỉ
        selectedAddressIndex = result['index'] as int; // Cập nhật chỉ mục
      });
    }
  }

  void _showPayment(BuildContext context) async {
    final result = await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return PaymentBottomSheet(
          selectedPayment: selectedPayment,
        );
      },
    );
    if (result != null) {
      setState(() {
        selectedPayment = result;
      });
    }
  }
}
