import 'package:book_store/core/common/cubits/cubit/user_cubit.dart';
import 'package:book_store/core/common/widgets/loader.dart';
import 'package:book_store/features/book/business/entities/user.dart';
import 'package:book_store/features/book/presentation/bloc/auth/auth_bloc.dart';
import 'package:book_store/features/book/presentation/providers/route.dart';
import 'package:book_store/features/book/presentation/widgets/app_bar.dart';
import 'package:book_store/features/book/presentation/widgets/change_pass_bottom_sheet.dart';
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

class _AccountScreenState extends State<AccountScreen> {
  // final oldController = TextEditingController();
  // final passController = TextEditingController();
  // final confirmPassController = TextEditingController();

  // String? email;

  // final formKey = GlobalKey<FormState>();
  // @override
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
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<UserCubit, UserState>(
            builder: (context, userState) {
              if (userState is UserLoggedIn) {
                final user = userState.user;
                return _buildAccountContent(context, user);
              } else if (userState is AuthLoading) {
                return const Loader();
              } else {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.goNamed(AppRoute.login.name);
                });
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
          const SizedBox(height: 20),
          _buildInfoTile(context, 'Name', user.userName ?? '', Icons.person),
          const SizedBox(height: 20),
          _buildInfoTile(context, 'Email', user.email, Icons.email),
          const SizedBox(height: 20),
          _buildInfoTile(context, 'Phone', user.phone ?? '+94', Icons.phone),
          const SizedBox(height: 20),
          ListTile(
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
            leading: const Icon(Icons.password, color: Colors.black, size: 35),
            trailing:
                const Icon(Icons.arrow_forward, color: Colors.black, size: 35),
            tileColor: Colors.grey,
          ),
          const SizedBox(height: 35),
          _buildEditAndSignOutButtons(context),
        ],
      ),
    );
  }

  Widget _buildInfoTile(
      BuildContext context, String title, String value, IconData icon) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            color: Colors.grey,
            spreadRadius: 5,
            blurRadius: 10,
          ),
        ],
      ),
      child: ListTile(
        title: TextCustom(
          text: title,
          fontSize: 25,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        subtitle: TextCustom(
          color: Colors.black,
          fontSize: 25,
          text: value,
        ),
        leading: Icon(icon, color: Colors.black, size: 35),
        tileColor: Colors.grey,
      ),
    );
  }

  Widget _buildEditAndSignOutButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          width: double.infinity,
          child: CustomButton(
            name: 'Edit',
            size: 23,
            onPressed: () {},
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 50,
          width: double.infinity,
          child: CustomButton(
            backgroundColor: Colors.red,
            name: 'Sign Out',
            size: 23,
            onPressed: () {
              context.read<AuthBloc>().add(AuthUserSignOut());
            },
          ),
        ),
      ],
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
