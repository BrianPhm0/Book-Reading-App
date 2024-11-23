// change_password_bottom_sheet.dart
import 'package:book_store/core/utils/show_snackbar.dart';
import 'package:book_store/features/book/presentation/bloc/auth/auth_bloc.dart';
import 'package:book_store/features/book/presentation/providers/handleSubmit.dart';
import 'package:book_store/features/book/presentation/widgets/custom_button.dart';
import 'package:book_store/features/book/presentation/widgets/custome_textfield.dart';
import 'package:book_store/features/book/presentation/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordBottomSheet extends StatefulWidget {
  final Function(String oldPassword, String newPassword) onSave;

  const ChangePasswordBottomSheet({super.key, required this.onSave});

  @override
  // ignore: library_private_types_in_public_api
  _ChangePasswordBottomSheetState createState() =>
      _ChangePasswordBottomSheetState();
}

class _ChangePasswordBottomSheetState extends State<ChangePasswordBottomSheet> {
  final oldController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();
  bool _obscureTextOld = true;
  bool _obscureTextPass = true;
  bool _obscureTextConfirm = true;

  final formKey = GlobalKey<FormState>();
  late FormHandler _formHandler;

  @override
  void dispose() {
    context.read<AuthBloc>().add(AuthGetUser());
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _formHandler = FormHandler(
      formKey: formKey,
      controllers: [
        oldController,
        passController,
        confirmPassController,
      ],
      validators: [
        (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your current Password';
          }
          if (value.length < 6) {
            return 'Password must contain at least 6 characters';
          }
          return null;
        },
        (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your new Password';
          }
          if (value.length < 6) {
            return 'Password must contain at least 6 characters';
          }
          return null;
        },
        (value) {
          if (value == null || value.isEmpty) {
            return 'Re-type new password';
          }
          if (value.length < 6) {
            return 'Password must contain at least 6 characters';
          }
          if (value != passController.text) {
            return 'New password does not match. Enter new password again';
          }
          return null;
        },
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is ChangePassSuccess) {
            Navigator.of(context).pop();
            context.read<AuthBloc>().add(AuthGetUser());
            showSnackBar(context, "Change password successfully");
          }
          if (state is AuthPassFail) {
            // Clear all text fields when change password fails
            oldController.clear();
            passController.clear();
            confirmPassController.clear();
            context.read<AuthBloc>().add(AuthGetUser());
            Navigator.of(context).pop();
            showSnackBar(context, "Fail to change password");
            // showSnackBar(context, "Fail to change password");
          }
        },
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12))),
          height: MediaQuery.of(context).size.height * 0.95,
          child: Column(
            children: [
              // Top button indicator (handle)
              Container(
                width: 60,
                height: 6,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const TextCustom(
                  text: 'Change Password', fontSize: 35, color: Colors.black),
              // Content of the bottom sheet
              Container(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15),
                        CustomeTextfield(
                          obscureText: _obscureTextOld,
                          controller: oldController,
                          name: 'Current Password',
                          suffix: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureTextOld = !_obscureTextOld;
                              });
                            },
                            icon: _obscureTextOld
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                            color: Colors.black,
                          ),
                          inputType: TextInputType.visiblePassword,
                          validator: _formHandler.validators[0],
                        ),
                        const SizedBox(height: 15),
                        CustomeTextfield(
                          obscureText: _obscureTextPass,
                          controller: passController,
                          name: 'New Password',
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
                          validator: _formHandler.validators[1],
                        ),
                        const SizedBox(height: 15),
                        CustomeTextfield(
                          obscureText: _obscureTextConfirm,
                          controller: confirmPassController,
                          name: 'Re-type new Password',
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
                          validator: _formHandler.validators[2],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: CustomButton(
                            name: 'Save',
                            onPressed: () {
                              FocusScope.of(context).unfocus();

                              _formHandler.submit(() {
                                context.read<AuthBloc>().add(ChangePassEvent(
                                    oldController.text.trim(),
                                    passController.text.trim()));
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
