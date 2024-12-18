import 'package:book_store/core/common/widgets/loader.dart';
import 'package:book_store/features/book/presentation/bloc/auth/auth_bloc.dart';

import 'package:book_store/features/book/presentation/providers/handleSubmit.dart';
import 'package:book_store/features/book/presentation/providers/route.dart';
import 'package:book_store/features/book/presentation/widgets/app_bar.dart';
import 'package:book_store/features/book/presentation/widgets/custom_button.dart';
import 'package:book_store/features/book/presentation/widgets/custome_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(
          title: 'Forget Password',
        ),
        body: SizedBox.expand(
          child: Stack(
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child:

                      // showDialogAuth(
                      //     context,
                      //     AppRoute.login.name,
                      //     'Verification Code Sent',
                      //     'A code has been sent to your email. Check your inbox (or spam folder) and enter the code below to continue.\nDidn’t get it? Wait a moment, then tap "Resend Code."');

                      Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomeTextfield(
                          name: 'Email',
                          inputType: TextInputType.emailAddress,
                          controller: emailController,
                          obscureText: false,
                          validator: _formHandler.validators[0],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 50,
                          child: CustomButton(
                            name: 'Submit',
                            onPressed: () {
                              _formHandler.submit(() {
                                context.pushNamed(AppRoute.verifyPass.name,
                                    extra: emailController.text.trim());
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Center the loader if loading
              if (context.watch<AuthBloc>().state is AuthLoading)
                const Positioned.fill(
                  child: Center(
                    child: Loader(size: 50.0, color: Colors.black),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
