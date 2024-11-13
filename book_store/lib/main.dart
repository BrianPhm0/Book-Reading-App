//connecting bloc with UI
import 'package:book_store/core/common/cubits/cubit/user_cubit.dart';
import 'package:book_store/features/book/presentation/bloc/address/address_bloc.dart';
import 'package:book_store/features/book/presentation/bloc/auth/auth_bloc.dart';
import 'package:book_store/features/book/presentation/bloc/book/bloc/category/book_bloc.dart';
import 'package:book_store/features/book/presentation/bloc/book/bloc/home/home_bloc.dart';
import 'package:book_store/features/book/presentation/bloc/cart/bloc/cart_bloc.dart';
import 'package:book_store/features/book/presentation/bloc/check/check_bloc.dart';
import 'package:book_store/features/book/presentation/bloc/detail/detail_bloc.dart';
import 'package:book_store/features/book/presentation/bloc/order/order_bloc.dart';
import 'package:book_store/features/book/presentation/bloc/voucher/voucher_bloc.dart';
import 'package:book_store/features/book/presentation/providers/route.dart';
import 'package:book_store/init_dependencies.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    DevicePreview(
      enabled: true,
      tools: const [
        ...DevicePreview.defaultTools,
        // CustomPlugin(),
      ],
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            // handle authentication logic
            create: (context) => serviceLocator<AuthBloc>(),
          ),
          BlocProvider(
            // handle user logic
            create: (context) => serviceLocator<UserCubit>(),
          ),
          BlocProvider(
            // handle book logic
            create: (context) => serviceLocator<BookBloc>(),
            lazy: false,
          ),
          BlocProvider(
            // handle book logic
            create: (context) => serviceLocator<HomeBloc>(),
            lazy: false,
          ),
          BlocProvider(
            // handle book logic
            create: (context) => serviceLocator<CartBloc>(),
            lazy: false,
          ),
          BlocProvider(
            // handle book logic
            create: (context) => serviceLocator<AddressBloc>(),
            lazy: false,
          ),
          BlocProvider(
            // handle book logic
            create: (context) => serviceLocator<CheckBloc>(),
            lazy: false,
          ),
          BlocProvider(
            // handle book logic
            create: (context) => serviceLocator<DetailBloc>(),
            lazy: false,
          ),
          BlocProvider(
            // handle book logic
            create: (context) => serviceLocator<VoucherBloc>(),
            lazy: false,
          ),
          BlocProvider(
            // handle book logic
            create: (context) => serviceLocator<OrderBloc>(),
            lazy: false,
          ),
          // Add a different bloc here if needed
          // BlocProvider(
          //   create: (context) => AnotherBloc(), // Replace with another bloc
          // ),
        ],
        child: const MyWidget(), // Your main widget goes here
      ),
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
    context.read<AuthBloc>().add(AuthIsTokendIn());
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
            if (state is UserLoggedInToken) {
              AppRouter.goTo('/bottomnav');
            }
          },
          child: child,
        );
      },
    );
  }
}
