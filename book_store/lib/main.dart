//connecting bloc with UI
import 'package:book_store/core/common/cubits/cubit/user_cubit.dart';
import 'package:book_store/features/book/presentation/bloc/auth/auth_bloc.dart';
import 'package:book_store/features/book/presentation/bloc/book/bloc/book_bloc.dart';
import 'package:book_store/features/book/presentation/providers/route.dart';
import 'package:book_store/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        ),
        BlocProvider(
          //handle authentication logic
          create: (context) => serviceLocator<BookBloc>(),
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
    super.initState();
    // FirebaseAuth.instance.signOut();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: _buildTheme(),
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      // routeInformationParser: AppRouter.router.routeInformationParser,
      builder: (context, child) {
        return BlocListener<UserCubit, UserState>(
          listener: (context, state) {
            if (state is UserLoggedIn) {
              print('hihi');
              print(state);
              AppRouter.goTo('/bottomnav');
            }
          },
          child: child,
        );
      },
    );
  }
}
