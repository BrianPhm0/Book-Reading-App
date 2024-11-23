import 'package:book_store/core/utils/show_snackbar.dart';
import 'package:book_store/features/book/presentation/bloc/auth/auth_bloc.dart';

import 'package:book_store/features/book/presentation/providers/handleSubmit.dart';
import 'package:book_store/features/book/presentation/widgets/app_bar.dart';
import 'package:book_store/features/book/presentation/widgets/custom_button.dart';
import 'package:book_store/features/book/presentation/widgets/custome_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Newpass extends StatefulWidget {
  // final String email;
  const Newpass({
    super.key,
    // required this.email,
  });

  @override
  State<Newpass> createState() => _NewpassState();
}

class _NewpassState extends State<Newpass> {
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();

  bool _obscureTextPass = true;
  bool _obscureTextConfirm = true;

  late String verifyCode;
  //form key
  late FormHandler _formHandler;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _formHandler = FormHandler(formKey: formKey, controllers: [
      passController,
      confirmPassController
    ], validators: [
      (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your Password';
        }
        if (value.length < 6) {
          return 'Password must contain at least 6 characters';
        }
        return null;
      },
      (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your Confirm Password';
        }
        if (value.length < 6) {
          return 'Password must contain at least 6 characters';
        }
        if (value != passController.text) {
          return 'Password does not match';
        }

        return null;
      },
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(
          title: 'New Password',
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthFailure) {
                  showSnackBar(context, state.message);
                } else if (state is AuthPasswordResetSuccess) {}
              },
              builder: (context, state) {
                return BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is VerifyCodeSuccess) {
                      setState(() {
                        verifyCode = state.verifyCode!;
                      });
                    }
                  },
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomeTextfield(
                          obscureText: _obscureTextPass,
                          controller: passController,
                          name: 'Password',
                          suffix: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureTextPass = !_obscureTextPass;
                              });
                            },
                            icon: _obscureTextPass
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                            color: Colors.black,
                          ),
                          inputType: TextInputType.visiblePassword,
                          validator: _formHandler.validators[0],
                        ),
                        const SizedBox(height: 15),
                        CustomeTextfield(
                          obscureText: _obscureTextConfirm,
                          controller: confirmPassController,
                          name: 'Confirm Password',
                          suffix: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureTextConfirm = !_obscureTextConfirm;
                              });
                            },
                            icon: _obscureTextConfirm
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                            color: Colors.black,
                          ),
                          inputType: TextInputType.visiblePassword,
                          validator: _formHandler.validators[1],
                        ),
                        const SizedBox(height: 18),
                        SizedBox(
                          height: 50,
                          child: CustomButton(
                            rectangle: 5,
                            name: 'Submit',
                            onPressed: () {
                              _formHandler.submit(() {
                                // if (verifyController.text.trim() ==
                                //     verifyCode) {
                                //   // context.read<AuthBloc>().add(AuthSignUp(
                                //   //     email: widget.userArgs.email,
                                //   //     password: widget.userArgs.password,
                                //   //     name: widget.userArgs.name));
                                // } else {
                                //   showSnackBar(context,
                                //       "The code you entered is incorrect. Please try again.");
                                // }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        // Center the loader if loading
      ),
    );
  }
}
