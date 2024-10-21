import 'package:book_store/features/book/presentation/widgets/text_custom.dart';
import 'package:flutter/material.dart';

class PaymentBottomSheet extends StatefulWidget {
  final int selectedPayment;
  const PaymentBottomSheet({super.key, required this.selectedPayment});

  @override
  State<PaymentBottomSheet> createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends State<PaymentBottomSheet> {
  List<String> payment = ['Momo', 'Paypal', 'Cash'];

  late int selectedPaymentIndex;

  @override
  void initState() {
    super.initState();
    selectedPaymentIndex = widget.selectedPayment;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Container(
      height: mediaQuery.size.height * 0.8,
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 5,
              width: 50,
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: payment.length,
                      itemBuilder: (context, index) {
                        return buildItem(context, index, payment);
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget buildItem(
    BuildContext context,
    int index,
    List<String> payment,
  ) {
    return
        // Dismissible(
        // key: ValueKey(items[index]),
        Container(
      margin: const EdgeInsets.only(top: 20),
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black, width: 3),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedPaymentIndex = index;
            Navigator.pop(context, index);
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                            width: 30, // Adjust the width as needed
                            height: 30,
                            child: Image.asset(
                                fit: BoxFit.contain,
                                "assets/payment/payment${index + 1}.png")),
                        const SizedBox(
                          width: 15,
                        ),
                        TextCustom(
                          text: payment[index],
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: selectedPaymentIndex ==
                        index // Check if this is the selected item
                    ? const Icon(
                        Icons.check_circle,
                        color: Colors.black,
                        size: 30,
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
