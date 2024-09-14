import 'package:book_store/features/book/presentation/providers/handleSubmit.dart';
import 'package:book_store/features/book/presentation/widgets/app_bar.dart';
import 'package:book_store/features/book/presentation/widgets/custom_button.dart';
import 'package:book_store/features/book/presentation/widgets/custome_textfield.dart';
import 'package:flutter/material.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  final emailController = TextEditingController();
  //form key
  late FormHandler _formHandler;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _formHandler = FormHandler(formKey: formKey, controllers: [
      emailController
    ], validators: [
      (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your Email';
        }
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'This is not a valid email';
        }
        return null;
      }
    ]);
  }

  @override
  Widget build(BuildContext context) {
    //GestureDetector
    //Safe
    //Scroll
    //TextFormField
    //Button

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(
          title: 'Forgot Password',
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomeTextfield(
                    name: 'Email',
                    inputType: TextInputType.emailAddress,
                    controller: emailController,
                    obscureText: false),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  child: CustomButton(
                      name: 'Submit',
                      onPressed: () {
                        _formHandler.submit(() {});
                      }),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
