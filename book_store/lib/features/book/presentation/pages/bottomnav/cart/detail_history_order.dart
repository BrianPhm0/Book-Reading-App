import 'package:book_store/features/book/presentation/pages/bottomnav/cart/review_page.dart';
import 'package:book_store/features/book/presentation/providers/route.dart';
import 'package:book_store/features/book/presentation/widgets/app_bar.dart';
import 'package:book_store/features/book/presentation/widgets/custom_button.dart';
import 'package:book_store/features/book/presentation/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailHistoryOrder extends StatefulWidget {
  const DetailHistoryOrder({super.key});

  @override
  State<DetailHistoryOrder> createState() => _DetailHistoryOrderState();
}

class _DetailHistoryOrderState extends State<DetailHistoryOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(title: "Order Status"),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildStatus(),
              const Spacer(),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: CustomButton(
                  borderColor: Colors.red,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  name: "Cancel Order",
                  onPressed: () {},
                  size: 20,
                  rectangle: 5,
                ),
              ),
            ],
          ),
        )));
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
              text: "Cancel Order",
              fontSize: 25,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            content: const TextCustom(
                text: "Are you sure you want to Cancel this order?",
                fontSize: 20,
                color: Colors.black),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const TextCustom(
                      text: "Close", fontSize: 20, color: Colors.red)),
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
}

Widget buildStatus() {
  return GestureDetector(
    onTap: () {},
    child: Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color with opacity
            spreadRadius: 2, // Spread radius
            blurRadius: 5, // Blur radius
            offset: const Offset(0, 3), // Offset to give depth
          ),
        ],
      ),
      child: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 7,
            ),
            TextCustom(
              text: 'Duc | 0965323955',
              maxLines: 2,
              fontSize: 25,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 7,
            ),
            TextCustom(
              text: 'Adress: 4449 Nguyen Cuu Phu tan tao a binhf tannsda',
              maxLines: 2,
              fontSize: 25,
              color: Colors.black,
            ),
            SizedBox(
              height: 7,
            ),
            TextCustom(
              text: 'Date: 10-7-2024',
              fontSize: 25,
              color: Colors.black,
            ),
            SizedBox(
              height: 7,
            ),
            TextCustom(
              text: "Status: Processing",
              fontSize: 25,
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 7,
            ),
            TextCustom(
              text: "Total money: 10000000 VND",
              maxLines: 2,
              fontSize: 25,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    ),
  );
}
