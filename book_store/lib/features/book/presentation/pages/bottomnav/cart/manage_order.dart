import 'package:book_store/core/common/widgets/loader.dart';
import 'package:book_store/features/book/business/entities/order/order_item.dart';
import 'package:book_store/features/book/presentation/bloc/order/order_bloc.dart';
import 'package:book_store/features/book/presentation/providers/route.dart';
import 'package:book_store/features/book/presentation/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ManageOrder extends StatefulWidget {
  const ManageOrder({super.key});

  @override
  State<ManageOrder> createState() => _ManageOrderState();
}

class _ManageOrderState extends State<ManageOrder> {
  @override
  void initState() {
    super.initState();

    context.read<OrderBloc>().add(GetOrderEvent());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Manage Order",
            style: TextStyle(
              fontSize: 35,
              fontFamily: 'Schyler',
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
          bottom: const TabBar(
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(
                fontSize: 18,
                fontFamily: 'Schyler',
                fontWeight: FontWeight.bold), // Active tab text style
            unselectedLabelStyle: TextStyle(
              fontSize: 16,
              fontFamily: 'Schyler',
            ), // Inactive tab text style
            tabs: [
              Tab(
                text: "Orders status",
              ),
              Tab(text: "Orders history"),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: BlocConsumer<OrderBloc, OrderState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is OrderLoading) {
              return const Center(
                  child: Loader(size: 50.0, color: Colors.black));
            } else if (state is GetOrderSuccess) {
              List<OrderItem> processingOrders = state.order['processing']!;
              List<OrderItem> completeOrders = state.order['completed']!;

              return SafeArea(
                child: TabBarView(
                  children: [
                    Center(
                      child: processingOrders.isEmpty
                          ? const TextCustom(
                              textAlign: TextAlign.center,
                              text:
                                  "No active orders. Place an order to track status!",
                              fontSize: 25,
                              color: Colors.black)
                          : ListView.builder(
                              itemBuilder: (context, index) {
                                return buildStatus(
                                    context, index, processingOrders[index]);
                              },
                              itemCount: processingOrders.length,
                            ),
                    ),
                    Center(
                      child: completeOrders.isEmpty
                          ? const TextCustom(
                              textAlign: TextAlign.center,
                              text:
                                  "You have no orders yet. Start shopping now!",
                              fontSize: 25,
                              color: Colors.black)
                          : ListView.builder(
                              itemBuilder: (context, index) {
                                return buildHistory(
                                    context, index, completeOrders[index]);
                              },
                              itemCount: completeOrders.length,
                            ),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: Loader(size: 50.0, color: Colors.black));
          },
        ),
      ),
    );
  }

  Widget buildStatus(BuildContext context, int index, OrderItem? order) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(AppRoute.detailStatus.name, extra: order?.orderId);
      },
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color:
                    Colors.grey.withOpacity(0.5), // Shadow color with opacity
                spreadRadius: 2, // Spread radius
                blurRadius: 5, // Blur radius
                offset: const Offset(0, 3), // Offset to give depth
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: TextCustom(
                        text: '${order?.name} | ${order?.phone}',
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    FittedBox(
                      child: TextCustom(
                        text: order?.address ?? '',
                        fontSize: 22,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FittedBox(
                      child: TextCustom(
                        text: order?.orderDate ?? '',
                        fontSize: 22,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextCustom(
                      text: order?.status ?? '',
                      fontSize: 20,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    FittedBox(
                      child: TextCustom(
                        text: '${order?.totalAmount} VND',
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHistory(BuildContext context, int index, OrderItem? order) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(AppRoute.detailHistory.name, extra: order?.orderId);
      },
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color:
                    Colors.grey.withOpacity(0.5), // Shadow color with opacity
                spreadRadius: 2, // Spread radius
                blurRadius: 5, // Blur radius
                offset: const Offset(0, 3), // Offset to give depth
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: TextCustom(
                        text: '${order?.name} | ${order?.phone}',
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    FittedBox(
                      child: TextCustom(
                        text: order?.address ?? '',
                        fontSize: 22,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FittedBox(
                      child: TextCustom(
                        text: order?.orderDate ?? '',
                        fontSize: 22,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextCustom(
                      text: order?.status ?? '',
                      fontSize: 20,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    FittedBox(
                      child: TextCustom(
                        text: '${order?.totalAmount} VND',
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
