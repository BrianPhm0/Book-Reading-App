import 'package:book_store/core/common/widgets/loader.dart';
import 'package:book_store/features/book/business/entities/user/user_args.dart';
import 'package:book_store/features/book/presentation/bloc/auth/auth_bloc.dart';

import 'package:book_store/features/book/presentation/providers/handleSubmit.dart';
import 'package:book_store/features/book/presentation/providers/route.dart';
import 'package:book_store/features/book/presentation/widgets/app_bar.dart';
import 'package:book_store/features/book/presentation/widgets/custom_button.dart';
import 'package:book_store/features/book/presentation/widgets/custom_text_button.dart';
import 'package:book_store/features/book/presentation/widgets/custome_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();
  final emailController = TextEditingController();
  bool _obscureTextPass = true;
  bool _obscureTextConfirm = true;

  late FormHandler _formHandler;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    ///Create handle object
    _formHandler = FormHandler(formKey: formKey, controllers: [
      nameController,
      emailController,
      passController,
      confirmPassController
    ], validators: [
      ///validate name
      (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your Name';
        }
        return null;
      },
      (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your Email';
        }
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'This is not a valid email';
        }
        return null;
      },
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
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(
          title: 'Register',
        ),
        body: SizedBox.expand(
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Stack(children: [
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 40),
                      const Text(
                        'Please fill your details to register',
                        style: TextStyle(
                          fontFamily: 'Schyler',
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 30),
                      CustomeTextfield(
                        obscureText: false,
                        controller: nameController,
                        name: 'Username',
                        inputType: TextInputType.name,
                        validator: _formHandler.validators[0],
                      ),
                      const SizedBox(height: 15),
                      CustomeTextfield(
                        obscureText: false,
                        controller: emailController,
                        name: 'Email',
                        inputType: TextInputType.emailAddress,
                        validator: _formHandler.validators[1],
                      ),
                      const SizedBox(height: 15),
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
                        validator: _formHandler.validators[2],
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
                        validator: _formHandler.validators[3],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        child: CustomButton(
                          name: 'Register',
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            _formHandler.submit(() {
                              context.pushNamed(AppRoute.verify.name,
                                  extra: UserArgs(
                                      nameController.text.trim(),
                                      emailController.text.trim(),
                                      passController.text.trim()));
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already a member?',
                            style: TextStyle(
                              fontFamily: 'Schyler',
                              fontSize: 20,
                            ),
                          ),
                          CustomTextButton(
                            name: 'Signin',
                            onPressed: () {
                              // Handle the Register button press
                              context.goNamed(AppRoute.login.name);
                            },
                            underlineCheck: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (context.watch<AuthBloc>().state is AuthLoading)
                  const Positioned.fill(
                    child: Center(
                      child: Loader(size: 50.0, color: Colors.black),
                    ),
                  ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
