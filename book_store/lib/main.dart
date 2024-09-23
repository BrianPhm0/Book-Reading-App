import 'package:book_store/features/book/presentation/bloc/auth_bloc.dart';
import 'package:book_store/features/book/presentation/providers/route.dart';

import 'package:book_store/init_dependencies.dart';

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
        // Add a different bloc here if needed
        // BlocProvider(
        //   create: (context) => AnotherBloc(), // Replace with another bloc
        // ),
      ],
      child: const MyWidget(), // Your main widget goes here
    ),
  );
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final router = goRouter();

    return MaterialApp.router(
      theme: ThemeData(
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
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
