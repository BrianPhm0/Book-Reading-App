import 'package:book_store/core/common/widgets/loader.dart';
import 'package:book_store/features/book/business/entities/address/address.dart';
import 'package:book_store/features/book/presentation/bloc/address/address_bloc.dart';
import 'package:book_store/features/book/presentation/providers/route.dart';
import 'package:book_store/features/book/presentation/widgets/custom_button.dart';
import 'package:book_store/features/book/presentation/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddressBottomSheet extends StatefulWidget {
  final Function(Address selectedAddress, int index)? onAddressSelected;
  final Address? initialSelectedAddress; // selected

  const AddressBottomSheet({
    super.key,
    this.onAddressSelected,
    this.initialSelectedAddress,
  });

  @override
  State<AddressBottomSheet> createState() => _AddressBottomSheetState();
}

class _AddressBottomSheetState extends State<AddressBottomSheet> {
  int selected = -1;

  @override
  void initState() {
    super.initState();
    context.read<AddressBloc>().add(GetAddressEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddressBloc, AddressState>(
      listener: (context, state) {
        if (state is AddressFail) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.toString())),
          );
        }
      },
      builder: (context, state) {
        if (state is AddressLoading) {
          return const Center(child: Loader(size: 50.0, color: Colors.black));
        } else if (state is GetAddressSuccess) {
          // Xác định selected index ban đầu nếu chưa được đặt
          if (selected == -1 && widget.initialSelectedAddress != null) {
            final index = state.address.indexWhere(
              (address) => address == widget.initialSelectedAddress,
            );
            if (index != -1) {
              selected = index;
            }
          }

          return Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
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
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.address.length,
                            itemBuilder: (context, index) {
                              return buildItem(
                                context,
                                index,
                                state.address[index],
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: CustomButton(
                              name: "Add new address",
                              onPressed: () async {
                                context.pushNamed(AppRoute.address.name);
                              },
                              textColor: Colors.black,
                              fontWeight: FontWeight.bold,
                              size: 20,
                              backgroundColor: Colors.white,
                              rectangle: 5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Center(child: Text('Unknown state: ${state.toString()}'));
      },
    );
  }

  Widget buildItem(BuildContext context, int index, Address address) {
    return InkWell(
      onTap: () {
        setState(() {
          selected = index;
        });
        widget.onAddressSelected?.call(address, index);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        height: 110,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected == index ? Colors.black : Colors.grey,
            width: 3,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: TextCustom(
                        text: "${address.name} | ${address.phone}",
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    FittedBox(
                      child: TextCustom(
                        text: address.address,
                        fontSize: 22,
                        color: Colors.black,
                      ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
