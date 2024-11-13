import 'package:book_store/core/common/widgets/loader.dart';
import 'package:book_store/features/book/business/entities/voucher/voucher.dart';
import 'package:book_store/features/book/presentation/bloc/voucher/voucher_bloc.dart';
import 'package:book_store/features/book/presentation/pages/bottomnav/cart/voucher_args.dart';
import 'package:book_store/features/book/presentation/widgets/app_bar.dart';
import 'package:book_store/features/book/presentation/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VoucherScreen extends StatefulWidget {
  final int? initIndex;
  const VoucherScreen({super.key, this.initIndex});

  @override
  State<VoucherScreen> createState() => _VoucherScreenState();
}

class _VoucherScreenState extends State<VoucherScreen> {
  int? selected;
  final TextEditingController text = TextEditingController();

  @override
  void initState() {
    super.initState();
    selected = widget.initIndex;
    // Chỉ gọi sự kiện để lấy loại sách khi cây widget đã được xây dựng
    context.read<VoucherBloc>().add(GetVoucherEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VoucherBloc, VoucherState>(
      listener: (context, state) {
        if (state is VoucherFailure) {}
      },
      builder: (context, state) {
        if (state is VoucherLoading) {
          return const Center(child: Loader(size: 50.0, color: Colors.black));
        } else if (state is GetVoucherSuccess) {
          if (state.voucher.isEmpty) {
            return Scaffold(
              appBar: CustomAppBar(
                title: "Voucher",
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop(
                      VoucherArgs(null, null),
                    );
                  },
                ),
              ),
              backgroundColor: Colors.white,
              body: const Center(
                child: TextCustom(
                  text: "No vouchers available",
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
          return GestureDetector(
            onTap: () {
              setState(() {
                selected = widget.initIndex;
              });
            },
            child: Scaffold(
              appBar: CustomAppBar(
                title: "Voucher",
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    if (selected != null && selected! >= 0) {
                      Navigator.of(context).pop(
                        VoucherArgs(
                            selected != null ? state.voucher[selected!] : null,
                            selected),
                      );
                    } else {
                      Navigator.of(context).pop(
                        VoucherArgs(
                            null, null), // Return null if no voucher selected
                      );
                    }
                  },
                ),
              ),
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    // Wrap the Column with SingleChildScrollView
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 4,
                              child: TextField(
                                controller: text,
                                decoration: const InputDecoration(
                                  labelText: "Enter voucher code",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  print(text.text);
                                },
                                child: Container(
                                  height: 47,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  alignment: Alignment.center,
                                  child: const TextCustom(
                                    text: "Apply",
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        ListView.builder(
                          shrinkWrap:
                              true, // Allow ListView to take only the necessary height
                          physics:
                              const NeverScrollableScrollPhysics(), // Disable scrolling for ListView
                          itemBuilder: (context, index) {
                            return buildItem(
                                context, index, state.voucher[index]);
                          },
                          itemCount: state.voucher.length,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        return const Center(
          child: Text("Error fetching data"),
        );
      },
    );
  }

  Widget buildItem(BuildContext context, int index, Voucher voucher) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected == index ? Colors.black : Colors.grey,
            width: 3,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: TextCustom(
                        maxLines: 2,
                        text:
                            "Get ${voucher.discount * 100}% off on orders from ${voucher.minCost} VND",
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: TextCustom(
                        text:
                            "Valid from ${voucher.releaseDate} to ${voucher.expiredDate}",
                        fontSize: 22,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Icon(
                  Icons.check_circle,
                  color: selected == index ? Colors.black : Colors.white,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
