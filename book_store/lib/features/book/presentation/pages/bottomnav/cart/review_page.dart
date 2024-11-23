// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:book_store/core/utils/show_snackbar.dart';
import 'package:book_store/features/book/presentation/bloc/detail/detail_bloc.dart';
import 'package:book_store/features/book/presentation/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewPage extends StatefulWidget {
  final String bookId;

  const ReviewPage({
    super.key,
    required this.bookId,
  });

  @override
  State<ReviewPage> createState() => _DetailBookBottomSheetState();
}

class _DetailBookBottomSheetState extends State<ReviewPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();
  int _rating = -1;

  late String id;

  @override
  void initState() {
    id = widget.bookId;

    super.initState();
  }

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
      child: BlocListener<DetailBloc, DetailState>(
        listener: (context, state) {
          if (state is PostReviewSuccess) {
            showSnackBar(context, 'Thank for your feedback!');
            Navigator.of(context).pop();
          }
        },
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
                        // Check if the rating is valid
                        if (_rating < 0) {
                          // Show the alert dialog if rating is not selected
                          _showAlertDialog(context);
                        } else {
                          // Submit the review if rating is selected
                          context.read<DetailBloc>().add(PostReviewEvent(
                              id, _rating.toString(), _reviewController.text));
                        }
                      },
                      child: const TextCustom(
                        text: "Send",
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    )
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
                child: TextCustom(
                  text: 'Tap a Star to Rate',
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              Container(
                color: Colors.grey,
                height: 2,
              ),

              TextField(
                controller: _reviewController,
                style: const TextStyle(
                    color: Colors.black, fontFamily: 'Schyler', fontSize: 20),
                maxLines: null,
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
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        // ignore: avoid_types_as_parameter_names
        builder: (BuildContext context) {
          return Rating(
            bookId: id,
          );
        });
  }
}

class Rating extends StatefulWidget {
  final String bookId;
  const Rating({super.key, required this.bookId});

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
                },a
                child: const TextCustom(
                    text: "Cancel", fontSize: 20, color: Colors.red)),
            const Spacer(),
            TextButton(
                onPressed: () {
                  context.read<DetailBloc>().add(
                      PostReviewEvent(widget.bookId, _rating.toString(), ''));

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
