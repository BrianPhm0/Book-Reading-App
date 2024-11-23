import 'package:book_store/core/common/widgets/loader.dart';
import 'package:book_store/core/utils/show_snackbar.dart';
import 'package:book_store/features/book/business/entities/user/user.dart';
import 'package:book_store/features/book/presentation/bloc/auth/auth_bloc.dart';
import 'package:book_store/features/book/presentation/providers/handleSubmit.dart';
import 'package:book_store/features/book/presentation/widgets/app_bar.dart';
import 'package:book_store/features/book/presentation/widgets/change_pass_bottom_sheet.dart';
import 'package:book_store/features/book/presentation/widgets/custom_button.dart';
import 'package:book_store/features/book/presentation/widgets/custome_textfield.dart';
import 'package:book_store/features/book/presentation/widgets/text_custom.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late FormHandler _formHandler;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthGetUser());

    /// Khởi tạo các controller rỗng
    nameController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();

    /// Tạo đối tượng FormHandler
    _formHandler = FormHandler(
      formKey: formKey,
      controllers: [
        nameController,
        phoneController,
        addressController,
      ],
      validators: [
        (value) =>
            value == null || value.isEmpty ? 'Please enter your Name' : null,
        (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your Phone number';
          }
          if (value.length != 10) return 'This is not a valid phone';
          return null;
        },
        (value) =>
            value == null || value.isEmpty ? 'Please enter your Address' : null,
      ],
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Setting",
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.read<AuthBloc>().add(AuthGetUser());
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is UpdateUserSuccess) {
              showSnackBar(context, 'Update information successfully');
            }
          },
          builder: (context, userState) {
            if (userState is AuthLoading) {
              return Container(
                margin: const EdgeInsets.only(top: 200),
                child: const Center(
                    child: Loader(size: 50.0, color: Colors.black)),
              );
            }
            if (userState is AuthSuccess) {
              final user = userState.user;

              /// Cập nhật giá trị ban đầu từ dữ liệu người dùng
              nameController.text = user.fullname ?? '';
              phoneController.text = user.phone ?? 'Add your phone number';
              addressController.text =
                  user.address ?? 'Add your address number';

              return _buildSettings(context, user);
            } else if (userState is UpdateUserSuccess) {
              context.read<AuthBloc>().add(AuthGetUser());
            }

            return const Center(child: Loader(size: 50.0, color: Colors.black));
          },
        ),
      ),
    );
  }

  Widget _buildSettings(BuildContext context, User user) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        // if (state is UpdateUserSuccess) {
        //   showSnackBar(context, 'Update information successfully');
        // }
      },
      builder: (context, state) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomeTextfield(
                    obscureText: false,
                    controller: nameController,
                    fontSize: 25.0,
                    name: 'Username',
                    inputType: TextInputType.name,
                    validator: _formHandler.validators[0],
                  ),
                  const SizedBox(height: 15),
                  CustomeTextfield(
                    obscureText: false,
                    fontSize: 25.0,
                    controller: phoneController,
                    name: 'Phone number',
                    inputType: TextInputType.phone,
                    validator: _formHandler.validators[1],
                  ),
                  const SizedBox(height: 15),
                  CustomeTextfield(
                    obscureText: false,
                    fontSize: 25.0,
                    controller: addressController,
                    name: 'Address',
                    inputType: TextInputType.none,
                    validator: _formHandler.validators[2],
                  ),
                  const SizedBox(height: 15),
                  InkWell(
                    onTap: () {
                      _showBottomSheet(context);
                    },
                    child: textFieldSettings(
                      "Password",
                      "change your password",
                      Icons.lock,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    child: CustomButton(
                      rectangle: 5,
                      size: 25,
                      name: 'Save',
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        _formHandler.submit(() {
                          context.read<AuthBloc>().add(UpdateUserEvent(
                              user.userId!,
                              user.username!,
                              user.email,
                              phoneController.text.trim(),
                              nameController.text.trim(),
                              addressController.text.trim()));
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ChangePasswordBottomSheet(
          onSave: (oldPassword, newPassword) {
            // Xử lý thay đổi mật khẩu
          },
        );
      },
    );
  }

  Widget textFieldSettings(String title, String value, IconData icon) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey, width: 2)),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 35,
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextCustom(text: title, fontSize: 25, color: Colors.black),
                    TextCustom(text: value, fontSize: 20, color: Colors.black)
                  ],
                ),
              ],
            ),
            const Icon(
              Icons.chevron_right,
              size: 40,
            ),
          ],
        ),
      ),
    );
  }
}
