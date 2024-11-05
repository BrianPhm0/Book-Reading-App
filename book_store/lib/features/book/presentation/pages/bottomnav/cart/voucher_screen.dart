import 'package:book_store/features/book/presentation/widgets/app_bar.dart';
import 'package:book_store/features/book/presentation/widgets/text_custom.dart';
import 'package:flutter/material.dart';

class VoucherScreen extends StatefulWidget {
  const VoucherScreen({super.key});

  @override
  State<VoucherScreen> createState() => _VoucherScreenState();
}

class _VoucherScreenState extends State<VoucherScreen> {
  int selected = -1;
  final TextEditingController text = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Voucher"),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  flex: 4,
                  child: TextField(
                    controller: text,
                    decoration: const InputDecoration(
                      labelText: "Enter voucher code",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Flexible(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      print(text.text);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 47,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(
                            3), // Adjust the radius as needed
                      ),
                      alignment: Alignment
                          .center, // Centers the text within the container
                      child: const TextCustom(
                        text: "Apply",
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return buildItem(context, index);
                },
                itemCount: 3,
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget buildItem(BuildContext context, int index) {
    return
        // Dismissible(
        // key: ValueKey(items[index]),
        GestureDetector(
      onTap: () {
        setState(() {
          selected = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: selected == index ? Colors.black : Colors.grey, width: 3),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: TextCustom(
                        text: "10% Off Your Next Purchase",
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    FittedBox(
                      child: TextCustom(
                          text: "Enjoy 10% off your next book purchase!",
                          fontSize: 22,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Icon(
                  Icons.check_circle,
                  color: selected == index ? Colors.black : Colors.white,
                  size: 30,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
