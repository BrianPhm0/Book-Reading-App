import 'package:book_store/features/book/presentation/providers/handleSubmit.dart';
import 'package:book_store/features/book/presentation/widgets/app_bar.dart';
import 'package:book_store/features/book/presentation/widgets/custom_button.dart';
// import 'package:book_store/features/book/presentation/widgets/custom_text_button.dart';
import 'package:book_store/features/book/presentation/widgets/custome_textfield.dart';
import 'package:flutter/material.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddressScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  late FormHandler _formHandler;

  @override
  void initState() {
    super.initState();

    _formHandler = FormHandler(formKey: formKey, controllers: [
      nameController,
      phoneController,
      addressController
    ], validators: [
      (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your name";
        }
        return null;
      },
      (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your phone number';
        }
        if (value.length < 6) {
          return 'Phone number must be 9 characters';
        }
        return null;
      },
      (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your address";
        }
        return null;
      },
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: "Add New Address"),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //Form
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomeTextfield(
                      name: "Name",
                      inputType: TextInputType.none,
                      controller: nameController,
                      validator: _formHandler.validators[0],
                    ),
                    const SizedBox(height: 15),
                    CustomeTextfield(
                      name: "Phone",
                      inputType: TextInputType.none,
                      controller: phoneController,
                      validator: _formHandler.validators[1],
                    ),
                    const SizedBox(height: 15),
                    CustomeTextfield(
                      name: "Address",
                      inputType: TextInputType.none,
                      controller: addressController,
                      validator: _formHandler.validators[2],
                    ),
                    const SizedBox(height: 35),
                    SizedBox(
                      height: 50,
                      child: CustomButton(
                          name: "Delete this Address",
                          rectangle: 5,
                          borderColor: Colors.red,
                          backgroundColor: Colors.red,
                          onPressed: () {
                            _formHandler.submit(() {});
                          }),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 50,
                      child: CustomButton(
                          name: "Save",
                          rectangle: 5,
                          onPressed: () {
                            _formHandler.submit(() {});
                          }),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
