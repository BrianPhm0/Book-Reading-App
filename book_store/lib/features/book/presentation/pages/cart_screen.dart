import 'package:book_store/features/book/presentation/widgets/text_custom.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return const TextCustom(text: 'Carttt', fontSize: 30, color: Colors.black);
  }
}
