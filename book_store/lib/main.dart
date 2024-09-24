import 'package:book_store/core/common/cubits/cubit/user_cubit.dart';
import 'package:book_store/features/book/presentation/bloc/auth_bloc.dart';
import 'package:book_store/features/book/presentation/providers/route.dart';

import 'package:book_store/init_dependencies.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

//connecting bloc with UI
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          //handle authentication logic
          create: (context) => serviceLocator<AuthBloc>(),
        ),
        BlocProvider(
          //handle authentication logic
          create: (context) => serviceLocator<UserCubit>(),
        )
        // Add a different bloc here if needed
        // BlocProvider(
        //   create: (context) => AnotherBloc(), // Replace with another bloc
        // ),
      ],
      child: const MyWidget(), // Your main widget goes here
    ),
  );
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  ThemeData _buildTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.black,
      ),
      primaryColor: Colors.black,
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(fontFamily: 'Schyler'),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }

  @override
  void initState() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.signOut();
    super.initState();
    context.read<AuthBloc>().add(AuthCurrentUser());
  }

  @override
  Widget build(BuildContext context) {
    // final router = goRouter();
    return MaterialApp.router(
      theme: _buildTheme(),
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      builder: (context, child) {
        return BlocListener<UserCubit, UserState>(
          listener: (context, state) {
            if (state is UserLoggedIn) {
              AppRouter.goTo(AppRoute.bottomnav.name);
            }
          },
          child: child,
        );
      },
    );
  }
}
