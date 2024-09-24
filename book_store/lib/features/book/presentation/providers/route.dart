import 'package:book_store/features/book/presentation/pages/account_screen.dart';
import 'package:book_store/features/book/presentation/pages/bottom_nav_screen.dart';
import 'package:book_store/features/book/presentation/pages/forgot_pass.dart';
import 'package:book_store/features/book/presentation/pages/login_screen.dart';
import 'package:book_store/features/book/presentation/pages/sign_up_screen.dart';
import 'package:go_router/go_router.dart';

enum AppRoute { login, signup, forgot, home, bottomnav, account }

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: <RouteBase>[
      GoRoute(
        path: '/login',
        name: AppRoute.login.name,
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: '/forgot',
        name: AppRoute.forgot.name,
        builder: (context, state) {
          return const ForgotPass();
        },
      ),
      GoRoute(
        path: '/signup',
        name: AppRoute.signup.name,
        builder: (context, state) {
          return const SignUpScreen();
        },
      ),
      GoRoute(
        path: '/bottomnav',
        name: AppRoute.bottomnav.name,
        builder: (context, state) {
          return const BottomNavScreen();
        },
      ),
      GoRoute(
        path: '/account',
        name: AppRoute.account.name,
        builder: (context, state) {
          return const AccountScreen();
        },
      ),
    ],
  );

  static void goTo(String path) {
    router.go(path);
  }
}
