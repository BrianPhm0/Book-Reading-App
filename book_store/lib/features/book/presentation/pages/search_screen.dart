import 'package:book_store/features/book/presentation/widgets/app_bar.dart';
import 'package:book_store/features/book/presentation/widgets/custom_button.dart';
import 'package:book_store/features/book/presentation/widgets/custome_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//create form that put book types to firebase

//Return colums

//Form contain
//2 Text Form Field
//2 controller
//Global form key
//Button submit

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final typeBookIdController = TextEditingController();
    final priceController = TextEditingController();
    final quantityController = TextEditingController();
    final descriptionController = TextEditingController();
    final ratingController = TextEditingController();

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Search',
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CustomeTextfield(
              name: 'title',
              inputType: TextInputType.none,
              controller: titleController,
              obscureText: false),
          const SizedBox(
            height: 20,
          ),
          CustomeTextfield(
              name: 'typeBookId',
              inputType: TextInputType.none,
              controller: typeBookIdController,
              obscureText: false),
          const SizedBox(
            height: 20,
          ),
          CustomeTextfield(
              name: 'price',
              inputType: TextInputType.none,
              controller: priceController,
              obscureText: false),
          const SizedBox(
            height: 20,
          ),
          CustomeTextfield(
              name: 'quantity',
              inputType: TextInputType.none,
              controller: quantityController,
              obscureText: false),
          const SizedBox(
            height: 20,
          ),
          CustomeTextfield(
              name: 'description',
              inputType: TextInputType.none,
              controller: descriptionController,
              obscureText: false),
          const SizedBox(
            height: 20,
          ),
          CustomeTextfield(
              name: 'rating',
              inputType: TextInputType.none,
              controller: ratingController,
              obscureText: false),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
              name: 'Submit',
              onPressed: () {
                final docRef =
                    FirebaseFirestore.instance.collection('books').doc();
                docRef.set({
                  'bookId': docRef.id,
                  'title': titleController.text.trim(),
                  'image': '',
                  'bookTypeId': typeBookIdController.text.trim(),
                  'uploadDate': DateTime.now(),
                  'price': priceController.text.trim(),
                  'quantity': quantityController.text.trim(),
                  'description': descriptionController.text.trim(),
                  'rating': ratingController.text.trim(),
                });
                titleController.clear();
                typeBookIdController.clear();
                priceController.clear();
                quantityController.clear();
                descriptionController.clear();
                ratingController.clear();
              })
        ],
      ),
    );
  }
}
