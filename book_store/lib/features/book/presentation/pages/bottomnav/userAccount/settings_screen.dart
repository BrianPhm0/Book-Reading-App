import 'package:book_store/core/common/cubits/cubit/user_cubit.dart';
import 'package:book_store/core/common/widgets/loader.dart';
import 'package:book_store/features/book/business/entities/user.dart';
import 'package:book_store/features/book/presentation/bloc/auth/auth_bloc.dart';
import 'package:book_store/features/book/presentation/providers/route.dart';
import 'package:book_store/features/book/presentation/widgets/app_bar.dart';
import 'package:book_store/features/book/presentation/widgets/change_pass_bottom_sheet.dart';
import 'package:book_store/features/book/presentation/widgets/text_custom.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<String> userProperties = ["Name", "Phone", "Address"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: "Settings"),
      body: SingleChildScrollView(
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, userState) {
            if (userState is UserLoggedIn) {
              final user = userState.user;

              return _buildSettingsContent(context, user);
            } else if (userState is AuthLoading) {
              return const Loader();
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  Padding _buildSettingsContent(BuildContext context, User user) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
                onTap: () {
                  context.pushNamed(
                    AppRoute.changes.name,
                    extra: {
                      'propertyName': userProperties[0],
                      'propertyUser': user.userName ?? '',
                      'index': 0,
                    },
                  );
                },
                child: textFieldSettings(
                    "Name", user.userName ?? "user", Icons.email)),
            const SizedBox(
              height: 20,
            ),
            InkWell(
                onTap: () {
                  context.pushNamed(
                    AppRoute.changes.name,
                    extra: {
                      'propertyName': userProperties[1],
                      'propertyUser': user.phone ?? '',
                      'index': 1,
                    },
                  );
                },
                child: textFieldSettings(
                    "Phone", "+94-${user.phone ?? ""}", Icons.phone)),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                context.pushNamed(
                  AppRoute.changes.name,
                  extra: {
                    'propertyName': userProperties[2],
                    'propertyUser': user.address ?? '',
                    'index': 2,
                  },
                );
              },
              child: textFieldSettings(
                  "Address",
                  user.address?.isNotEmpty == true
                      ? user.address!
                      : "Add your address",
                  Icons.add_home_sharp),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
                onTap: () {
                  _showBottomSheet(context);
                },
                child: textFieldSettings(
                    "Password", "change your password", Icons.lock)),
          ],
        ));
  }

  Widget textFieldSettings(String title, String value, IconData icon) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 2)),
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

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows for custom height of the bottom sheet
      builder: (BuildContext context) {
        return ChangePasswordBottomSheet(
          onSave: (oldPassword, newPassword) {
            // Handle the password change logic here
            // You can call your authentication service or bloc here to change the password
          },
        );
      },
    );
  }
}
