import 'package:book_store/core/common/widgets/dialog.dart';
import 'package:book_store/core/common/widgets/loader.dart';
import 'package:book_store/core/utils/show_snackbar.dart';
import 'package:book_store/features/book/business/entities/user/user_args.dart';
import 'package:book_store/features/book/presentation/bloc/auth/auth_bloc.dart';

import 'package:book_store/features/book/presentation/providers/handleSubmit.dart';
import 'package:book_store/features/book/presentation/widgets/app_bar.dart';
import 'package:book_store/features/book/presentation/widgets/custom_button.dart';
import 'package:book_store/features/book/presentation/widgets/custom_text_button.dart';
import 'package:book_store/features/book/presentation/widgets/custome_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyScreen extends StatefulWidget {
  final UserArgs userArgs;
  const VerifyScreen({super.key, required this.userArgs});

  @override
  State<VerifyScreen> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<VerifyScreen> {
  final verifyController = TextEditingController();
  late String verifyCode;
  //form key
  late FormHandler _formHandler;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(VerifyCodeEvent(widget.userArgs.email));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialogAuth(context, '', 'Verification Code Sent',
          'A code has been sent to your email. Check your inbox (or spam folder) and enter the code below to continue.\nDidn’t get it? Wait a moment, then tap "Resend Code."'); // Customize your dialog message here
    });

    _formHandler = FormHandler(formKey: formKey, controllers: [
      verifyController
    ], validators: [
      (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter verify code';
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(
          title: 'Verify Account',
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
                                name: 'Verify code',
                                inputType: TextInputType.number,
                                controller: verifyController,
                                obscureText: false,
                              ),
                              const SizedBox(height: 5),
                              Container(
                                alignment: Alignment.centerRight,
                                child: CustomTextButton(
                                  fontSize: 18,
                                  name: 'Resend code',
                                  onPressed: () {
                                    context.read<AuthBloc>().add(
                                        VerifyCodeEvent(widget.userArgs.email));
                                    showSnackBar(context,
                                        'A new code has been sent to your email. Please check your inbox (or spam folder) shortly.');
                                  },
                                  underlineCheck: true,
                                ),
                              ),
                              const SizedBox(height: 18),
                              SizedBox(
                                height: 50,
                                child: CustomButton(
                                  rectangle: 5,
                                  name: 'Submit',
                                  onPressed: () {
                                    _formHandler.submit(() {
                                      if (verifyController.text.trim() ==
                                          verifyCode) {
                                        context.read<AuthBloc>().add(AuthSignUp(
                                            email: widget.userArgs.email,
                                            password: widget.userArgs.password,
                                            name: widget.userArgs.name));
                                      } else {
                                        showSnackBar(context,
                                            "The code you entered is incorrect. Please try again.");
                                      }
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
