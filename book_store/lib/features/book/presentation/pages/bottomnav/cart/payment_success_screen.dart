import 'package:book_store/features/book/presentation/providers/route.dart';
import 'package:book_store/features/book/presentation/widgets/custom_button.dart';
import 'package:book_store/features/book/presentation/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaymentSuccessScreen extends StatefulWidget {
  const PaymentSuccessScreen({super.key});

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/payment/payment_success.gif"),
            const SizedBox(
              height: 15,
            ),
            const TextCustom(
              text: "Payment Successfully",
              fontSize: 25,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            const TextCustom(
              text: "Your order has been validated",
              fontSize: 20,
              color: Colors.black,
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 40,
              child: CustomButton(
                  size: 20,
                  name: "Continue Shopping",
                  onPressed: () {
                    context.goNamed(AppRoute.bottomnav.name);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
