import 'package:book_store/core/common/widgets/loader.dart';
import 'package:book_store/core/utils/show_snackbar.dart';
import 'package:book_store/features/book/business/entities/order/order_id.dart';
import 'package:book_store/features/book/presentation/bloc/order/order_bloc.dart';
import 'package:book_store/features/book/presentation/widgets/app_bar.dart';
import 'package:book_store/features/book/presentation/widgets/custom_button.dart';
import 'package:book_store/features/book/presentation/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailOrderStatus extends StatefulWidget {
  final String? id;
  const DetailOrderStatus({super.key, this.id});

  @override
  State<DetailOrderStatus> createState() => _DetailOrderStatusState();
}

class _DetailOrderStatusState extends State<DetailOrderStatus> {
  @override
  void initState() {
    context.read<OrderBloc>().add(GetOrderByIdEvent(widget.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderBloc, OrderState>(
      listener: (context, state) {
        if (state is CancelOrderSuccess) {
          context.read<OrderBloc>().add(GetOrderEvent());
          Navigator.of(context)
              .pop(); // Close the DetailOrderStatus screen safely
        }
      },
      builder: (context, state) {
        if (state is OrderLoading) {
          return const Center(child: Loader(size: 50.0, color: Colors.black));
        } else if (state is GetOrderIdSuccess) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: CustomAppBar(
              title: "Order status",
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  context.read<OrderBloc>().add(GetOrderEvent());
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return buildStatus(
                              context, index, state.order[index]);
                        },
                        itemCount: state.order.length,
                      ),
                    ),
                    // buildHistory(context)),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: CustomButton(
                        borderColor: Colors.red,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        name: "Cancel Order",
                        onPressed: () {
                          _showAlertDialog(context);
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
        }
        return const Center(child: Loader(size: 50.0, color: Colors.black));
      },
    );
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
            color: Colors.black,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const TextCustom(
                text: "Close",
                fontSize: 20,
                color: Colors.red,
              ),
            ),
            TextButton(
              onPressed: () {
                context.read<OrderBloc>().add(CancelOrderEvent(widget.id!));
                showSnackBar(context, "Cancel order successfully");
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const TextCustom(
                text: "Confirm",
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ],
        );
      },
    );
  }
}

Widget buildStatus(BuildContext context, int index, OrderId orderId) {
  return GestureDetector(
    onTap: () {
      // context.pushNamed(AppRoute.detailHistory.name);
    },
    child: SizedBox(
        width: double.infinity,
        height: 150, // Ensure height is fixed for layout
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 4,
                child: Image.network(
                  orderId.book!.image,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 5),
              Flexible(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextCustom(
                      text: orderId.book!.title,
                      color: Colors.black,
                      maxLines: 2,
                      fontSize: 22,
                    ),
                    TextCustom(
                      maxLines: 1,
                      text: orderId.book!.authorName,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextCustom(
                        text: 'x${orderId.quantity}',
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      const Spacer(),
                      TextCustom(
                        text: '${orderId.book?.price} VND',
                        maxLines: 2,
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(
                        width: 15,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )),
  );
}
