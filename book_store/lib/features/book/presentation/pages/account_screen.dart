import 'package:book_store/features/book/presentation/providers/handleSubmit.dart';
import 'package:book_store/features/book/presentation/providers/route.dart';
import 'package:book_store/features/book/presentation/widgets/app_bar.dart';
import 'package:book_store/features/book/presentation/widgets/custom_button.dart';
import 'package:book_store/features/book/presentation/widgets/custome_textfield.dart';
// import 'package:book_store/features/book/presentation/widgets/custom_dialog.dart';
import 'package:book_store/features/book/presentation/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final oldController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();
  bool _obscureTextOld = true;
  bool _obscureTextPass = true;
  bool _obscureTextConfirm = true;

  late FormHandler _formHandler;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _formHandler = FormHandler(formKey: formKey, controllers: [
      oldController,
      passController,
      confirmPassController
    ], validators: [
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
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: true,
        autoLeading: false,
        title: 'Account',
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 18),
            child: GestureDetector(
              onTap: () {
                context.goNamed(AppRoute.bottomnav.name);
              },
              child: const TextCustom(
                text: 'Done',
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Row(),
                SizedBox(
                  height: 120,
                  width: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: const Image(
                      image: AssetImage('assets/account.png'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                //name
                Container(
                  decoration:
                      const BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 5),
                        color: Colors.grey,
                        spreadRadius: 5,
                        blurRadius: 10)
                  ]),
                  child: const ListTile(
                    title: TextCustom(
                      text: 'Name',
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    subtitle: TextCustom(
                      color: Colors.black,
                      fontSize: 25,
                      text: 'ducpham',
                    ),
                    leading: Icon(
                      Icons.person,
                      color: Colors.black,
                      size: 35,
                    ),
                    tileColor: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                //Email
                Container(
                  decoration:
                      const BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 5),
                        color: Colors.grey,
                        spreadRadius: 5,
                        blurRadius: 10)
                  ]),
                  child: const ListTile(
                    title: TextCustom(
                      text: 'Email',
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    subtitle: TextCustom(
                      color: Colors.black,
                      fontSize: 25,
                      text: 'afptm123@gmail.com',
                    ),
                    leading: Icon(
                      Icons.email,
                      color: Colors.black,
                      size: 35,
                    ),
                    tileColor: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                //Phone
                Container(
                  decoration:
                      const BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 5),
                        color: Colors.grey,
                        spreadRadius: 5,
                        blurRadius: 10)
                  ]),
                  child: const ListTile(
                    title: TextCustom(
                      text: 'Phone',
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    subtitle: TextCustom(
                      color: Colors.black,
                      fontSize: 25,
                      text: '0965323955',
                    ),
                    leading: Icon(
                      Icons.phone,
                      color: Colors.black,
                      size: 35,
                    ),
                    tileColor: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                //password
                Container(
                  decoration:
                      const BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 5),
                        color: Colors.grey,
                        spreadRadius: 5,
                        blurRadius: 10)
                  ]),
                  child: ListTile(
                    onTap: () {
                      _showBottomSheet(context);
                    },
                    title: const TextCustom(
                      text: 'Password',
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    subtitle: const TextCustom(
                      color: Colors.black,
                      fontSize: 25,
                      text: '**********',
                    ),
                    leading: const Icon(
                      Icons.password,
                      color: Colors.black,
                      size: 35,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                      size: 35,
                    ),
                    tileColor: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 35,
                ),
                //Edit
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: CustomButton(
                    name: 'Edit',
                    size: 23,
                    onPressed: () {},
                  ),
                ),
                //Sign Out
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: CustomButton(
                    backgroundColor: Colors.red,
                    name: 'Sign Out',
                    size: 23,
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows for custom height of the bottom sheet
      builder: (BuildContext context) {
        final screenHeight = MediaQuery.of(context).size.height;
        final bottomSheetHeight = screenHeight * 0.95; // 80% of screen height

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12))),
            height: bottomSheetHeight,
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
                            validator: _formHandler.validators[1],
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: CustomButton(
                              name: 'Save',
                              onPressed: () {
                                _formHandler.submit(() {
                                  // final formData = _formHandler.getFormData();
                                  Navigator.pop(context);
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
        );
      },
    );
  }
}
