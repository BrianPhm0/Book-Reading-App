import 'package:book_store/core/common/widgets/loader.dart';
import 'package:book_store/core/utils/show_snackbar.dart';
import 'package:book_store/features/book/presentation/bloc/auth/auth_bloc.dart';
import 'package:book_store/features/book/presentation/providers/handleSubmit.dart';
import 'package:book_store/features/book/presentation/providers/route.dart';
import 'package:book_store/features/book/presentation/widgets/app_bar.dart';
import 'package:book_store/features/book/presentation/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:book_store/features/book/presentation/widgets/custom_button.dart';
import 'package:book_store/features/book/presentation/widgets/custom_text_button.dart';
import 'package:book_store/features/book/presentation/widgets/custome_textfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  //create formHandle object
  late FormHandler _formHandler;
  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _formHandler = FormHandler(formKey: formKey, controllers: [
      emailController,
      passController
    ], validators: [
      (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your Username';
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
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(
          title: 'Get Started',
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            //Form
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthFailure) {
                  showSnackBar(context, state.message);
                } else if (state is AuthTokenSuccess) {
                  context.goNamed(AppRoute.bottomnav.name);
                }
              },
              builder: (context, state) {
                return Stack(children: [
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 40),
                        const TextCustom(
                            text: 'Please fill your details to login',
                            fontSize: 18,
                            color: Colors.black),

                        const SizedBox(height: 30),
                        //Email
                        CustomeTextfield(
                          obscureText: false,
                          controller: emailController,
                          validator: _formHandler.validators[0],
                          name: 'Username',
                          inputType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 15),
                        //Password
                        CustomeTextfield(
                          obscureText: _obscureText,
                          validator: _formHandler.validators[1],
                          suffix: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            icon: _obscureText
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                            color: Colors.black,
                          ),
                          controller: passController,
                          name: 'Password',
                          inputType: TextInputType.visiblePassword,
                        ),
                        const SizedBox(height: 5),
                        Container(
                          alignment: Alignment.centerRight,
                          child: CustomTextButton(
                            name: 'Forget password?',
                            onPressed: () {
                              // Handle the Forgot Password button press
                              context.pushNamed(AppRoute.forgot.name);
                            },
                            underlineCheck: true,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 50,
                          child: CustomButton(
                            name: 'Get Started',
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              // Handle the Get Started button press
                              //handle success data
                              _formHandler.submit(() {
                                context.read<AuthBloc>().add(AuthLoginToken(
                                    name: emailController.text.trim(),
                                    password: passController.text.trim()));
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'New member?',
                              style: TextStyle(
                                fontFamily: 'Schyler',
                                fontSize: 20,
                              ),
                            ),
                            CustomTextButton(
                              name: 'Register',
                              onPressed: () {
                                // Handle the Register button press
                                context.pushNamed(AppRoute.signup.name);
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
                ]);
              },
            ),
          ),
        ),
      ),
    );
  }
}
