// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:book_store/features/book/presentation/widgets/text_custom.dart';
import 'package:flutter/material.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({
    super.key,
  });

  @override
  State<ReviewPage> createState() => _DetailBookBottomSheetState();
}

class _DetailBookBottomSheetState extends State<ReviewPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();
  int _rating = -1;

  @override
  void dispose() {
    _titleController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        height: mediaQuery.size.height * 0.95,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Top button indicator
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const TextCustom(
                        text: "Cancel", fontSize: 20, color: Colors.black),
                  ),
                  const Spacer(),
                  const TextCustom(
                    text: "Write a Review",
                    fontSize: 23,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      if (_rating < 0) {
                        _showAlertDialog(context);
                      }
                    },
                    child: const TextCustom(
                      text: "Send",
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < _rating ? Icons.star : Icons.star_border,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () {
                      setState(() {
                        _rating = index + 1;
                      });
                    },
                  );
                }),
              ),
            ),
            const Center(
              child: Text(
                'Tap a Star to Rate',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              color: Colors.grey,
              height: 2,
            ),

            TextField(
              controller: _titleController,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(color: Colors.grey),
                focusedBorder: InputBorder.none, // No border when focused
                enabledBorder: InputBorder.none,
              ),
            ),
            Container(
              color: Colors.grey,
              height: 2,
            ),

            TextField(
              controller: _reviewController,
              style: const TextStyle(color: Colors.black),
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Review (Optional)',
                hintStyle: TextStyle(color: Colors.grey),
                focusedBorder: InputBorder.none, // No border when focused
                enabledBorder: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        // ignore: avoid_types_as_parameter_names
        builder: (BuildContext context) {
          return const Rating();
        });
  }
}

class Rating extends StatefulWidget {
  const Rating({super.key});

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  int _rating = -1;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Colors.black, width: 2),
      ),
      backgroundColor: Colors.white,
      title: const Center(
        child:
            TextCustom(text: "Please Rate", fontSize: 25, color: Colors.black),
      ),
      content: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(5, (index) {
          return IconButton(
            icon: Icon(
              index < _rating ? Icons.star : Icons.star_border,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              setState(() {
                _rating = index + 1;
              });
            },
          );
        }),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const TextCustom(
                    text: "Cancel", fontSize: 20, color: Colors.red)),
            const Spacer(),
            TextButton(
                onPressed: () {
                  // Add your buy logic here
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: TextCustom(
                    text: "Send",
                    fontSize: 20,
                    color: _rating == -1 ? Colors.grey : Colors.black)),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}
