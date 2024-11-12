// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:book_store/features/book/presentation/providers/handleSubmit.dart';
import 'package:book_store/features/book/presentation/widgets/app_bar.dart';
import 'package:book_store/features/book/presentation/widgets/custom_button.dart';
import 'package:book_store/features/book/presentation/widgets/custome_textfield.dart';
import 'package:book_store/features/book/presentation/widgets/text_custom.dart';
import 'package:flutter/material.dart';

class ChangesScreen extends StatefulWidget {
  final String propertyName;
  final String? propertyUser;
  final int index;
  const ChangesScreen({
    super.key,
    required this.propertyName,
    this.propertyUser,
    required this.index,
  });

  @override
  State<ChangesScreen> createState() => _ChangesScreenState();
}

class _ChangesScreenState extends State<ChangesScreen> {
  final _textCotroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late FormHandler _formHandler;

  @override
  void initState() {
    _textCotroller.text = widget.propertyUser ?? '';
    _formHandler = FormHandler(formKey: _formKey, controllers: [
      _textCotroller
    ], validators: [
      (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your Name';
        }
        return null;
      },
      (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your Phone Number';
        }
        if (value.length != 9) {
          return 'Phone number consists of 9 digits';
        }
        return null;
      },
      (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your Address';
        }
        return null;
      },
    ]);

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _textCotroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: widget.propertyName),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextCustom(
                text: widget.propertyName,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black),
            const SizedBox(
              height: 10,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomeTextfield(
                    inputType: widget.index == 0
                        ? TextInputType.name
                        : widget.index == 1
                            ? TextInputType.number
                            : widget.index == 2
                                ? TextInputType.streetAddress
                                : TextInputType.none,
                    controller: _textCotroller,
                    validator: _formHandler.validators[widget.index],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: CustomButton(
                      rectangle: 5,
                      name: 'Save',
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        // Handle the Get Started button press
                        //handle success data
                        _formHandler.submit(() {
                          print("done");
                        });
                      },
                    ),
                  ),
                ],
              ),
            )

            // Form(child: )
          ],
        ),
      ),
    );
  }
}
