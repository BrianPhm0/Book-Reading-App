// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:book_store/features/book/business/entities/book.dart';
import 'package:book_store/features/book/presentation/widgets/custom_button.dart';
import 'package:book_store/features/book/presentation/widgets/text_custom.dart';
import 'package:flutter/material.dart';

class DetailBookBottomSheet extends StatefulWidget {
  final Book book;
  const DetailBookBottomSheet({
    super.key,
    required this.book,
  });

  @override
  State<DetailBookBottomSheet> createState() => _DetailBookBottomSheetState();
}

class _DetailBookBottomSheetState extends State<DetailBookBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final halfScreenWidth = mediaQuery.size.width / 2.3;
    final halfScreenHeight = mediaQuery.size.height / 3;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        height: mediaQuery.size.height * 0.95,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Top button indicator
            Container(
              width: 60,
              height: 6,
              margin: const EdgeInsets.symmetric(vertical: 2),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(height: 20),
            TextCustom(
              text: widget.book.title,
              fontSize: 30,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 15),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: halfScreenWidth,
                          height: halfScreenHeight,
                          child: Image.asset(
                            'assets/book_cover/book_cover.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 25),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextCustom(
                              text:
                                  ' Rating: ${widget.book.rating.toString()}/5',
                              fontSize: 24,
                              color: Colors.black,
                            ),
                            TextCustom(
                              text:
                                  ' Pricing: \$${widget.book.price.toString()}',
                              fontSize: 25,
                              color: Colors.black,
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 50,
                              width: 160, // Set a width for the button
                              child: CustomButton(
                                name: 'Add to Cart',
                                onPressed: () {
                                  print('Added to cart');
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const TextCustom(
                      text: 'Description:',
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 15),
                    // Make description scrollable if too long
                    TextCustom(
                      text: widget.book.description,
                      fontSize: 20,
                      color: Colors.black,
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
}
