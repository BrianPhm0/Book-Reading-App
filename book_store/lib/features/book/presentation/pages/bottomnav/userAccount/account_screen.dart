import 'package:book_store/core/common/widgets/loader.dart';
import 'package:book_store/features/book/business/entities/user/user.dart';
import 'package:book_store/features/book/presentation/bloc/auth/auth_bloc.dart';
import 'package:book_store/features/book/presentation/providers/route.dart';
import 'package:book_store/features/book/presentation/widgets/app_bar.dart';
import 'package:book_store/features/book/presentation/widgets/custom_button.dart';
import 'package:book_store/features/book/presentation/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

/// username, password, email, phone, address,
class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    super.initState();
    // Chỉ gọi sự kiện để lấy loại sách khi cây widget đã được xây dựng
    context.read<AuthBloc>().add(AuthGetUser());
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
            child: InkWell(
              onTap: () {
                context.goNamed(AppRoute.bottomnav.name);
              },
              child: const TextCustom(
                text: 'Done',
                fontSize: 23,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, userState) {
              if (userState is AuthFailure) {
                Navigator.of(context).pop();
                context.pushNamed(AppRoute.login.name);
              }
            },
            builder: (context, userState) {
              if (userState is AuthSuccess) {
                final user = userState.user;

                // print(user);
                return _buildAccountContent(context, user);
              } else if (userState is AuthLoading) {
                return Container(
                  margin: const EdgeInsets.only(top: 200),
                  child: const Center(
                      child: Loader(size: 50.0, color: Colors.black)),
                );
              } else {
                // WidgetsBinding.instance.addPostFrameCallback((_) {
                // context.goNamed(AppRoute.bottomnav.name);
                // });
                return const SizedBox(); // Return an empty widget
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAccountContent(BuildContext context, User user) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildInfoUser(context, user.username ?? 'User', user.email),
          const SizedBox(height: 30),
          _buildInfoTile(context, 'Notifications'),
          const SizedBox(height: 30),
          _buildInfoTile(
            context,
            'Manage Hidden Purchases',
          ),
          const SizedBox(height: 30),
          _buildInfoTile(
            context,
            'Redeem Gift Card or Code',
          ),
          const SizedBox(height: 30),
          InkWell(
            onTap: () {
              context.pushNamed(AppRoute.settings.name);
            },
            child: _buildInfoTile(
              context,
              'View Account Settings',
            ),
          ),
          const SizedBox(height: 30),
          _buildEditAndSignOutButtons(context),
        ],
      ),
    );
  }

  Widget _buildInfoTile(BuildContext context, String title) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
        child: TextCustom(
          text: title,
          fontSize: 25,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildInfoUser(BuildContext context, String title, String value) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.account_circle_sharp,
              size: 65,
            ),
            // Icon(icon, color: Colors.black, size: 30),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextCustom(
                    text: title,
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  TextCustom(
                    color: Colors.black,
                    fontSize: 25,
                    text: value,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildEditAndSignOutButtons(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: CustomButton(
        backgroundColor: Colors.red,
        name: 'Sign Out',
        size: 23,
        borderColor: Colors.red,
        onPressed: () {
          context.read<AuthBloc>().add(AuthUserSignOut());
          context.goNamed(AppRoute.bottomnav.name);
        },
      ),
    );
  }
}
