import 'package:book_store/features/book/presentation/providers/route.dart';
import 'package:book_store/features/book/presentation/widgets/custom_button.dart';
import 'package:book_store/features/book/presentation/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddressBottomSheet extends StatefulWidget {
  const AddressBottomSheet({super.key});

  @override
  State<AddressBottomSheet> createState() => _AddressBottomSheetState();
}

class _AddressBottomSheetState extends State<AddressBottomSheet> {
  int selected = 0;
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
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return buildItem(context, index);
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: CustomButton(
                        name: "Add new address",
                        onPressed: () {
                          context.pushNamed(AppRoute.address.name);
                          Navigator.pop(context);
                        },
                        textColor: Colors.black,
                        fontWeight: FontWeight.bold,
                        size: 20,
                        backgroundColor: Colors.white,
                        rectangle: 5,
                      )),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget buildItem(BuildContext context, int index) {
    return
        // Dismissible(
        // key: ValueKey(items[index]),
        InkWell(
      onTap: () {
        setState(() {
          selected = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        height: 110,
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
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: TextCustom(
                        text: "Pham | 0965323955",
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    FittedBox(
                      child: TextCustom(
                          text: "Tan Tao A, Binh Tan, Tp. HCM",
                          fontSize: 22,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    context.pushNamed(AppRoute.address.name);
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.create,
                    color: selected == index ? Colors.black : Colors.grey,
                    size: 30,
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
