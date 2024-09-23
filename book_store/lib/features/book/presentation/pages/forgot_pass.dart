import 'package:book_store/core/common/widgets/dialog.dart';
import 'package:book_store/core/common/widgets/loader.dart';
import 'package:book_store/core/utils/show_snackbar.dart';
import 'package:book_store/features/book/presentation/bloc/auth_bloc.dart';
import 'package:book_store/features/book/presentation/providers/handleSubmit.dart';
import 'package:book_store/features/book/presentation/providers/route.dart';
import 'package:book_store/features/book/presentation/widgets/app_bar.dart';
import 'package:book_store/features/book/presentation/widgets/custom_button.dart';
import 'package:book_store/features/book/presentation/widgets/custome_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                  child: BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthFailure) {
                        showSnackBar(context, state.message);
                      } else if (state is AuthPasswordResetSuccess) {
                        showDialogForget(context, AppRoute.login.name);
                      }
                    },
                    builder: (context, state) {
                      return Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomeTextfield(
                              name: 'Email',
                              inputType: TextInputType.emailAddress,
                              controller: emailController,
                              obscureText: false,
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 50,
                              child: CustomButton(
                                name: 'Submit',
                                onPressed: () {
                                  _formHandler.submit(() {
                                    context.read<AuthBloc>().add(AuthResetPass(
                                        email: emailController.text.trim()));
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
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
