import 'package:book_store/features/book/business/entities/book_type.dart';
import 'package:book_store/features/book/presentation/pages/bottomnav/cart/add_address_screen.dart';
import 'package:book_store/features/book/presentation/pages/bottomnav/cart/payment_success_screen.dart';
import 'package:book_store/features/book/presentation/pages/bottomnav/userAccount/account_screen.dart';
import 'package:book_store/features/book/presentation/pages/bottomnav/bottom_nav_screen.dart';
import 'package:book_store/features/book/presentation/pages/bottomnav/categories/categories_books_screen.dart';
import 'package:book_store/features/book/presentation/pages/bottomnav/cart/check_out_screen.dart';
import 'package:book_store/features/book/presentation/pages/userlogin/forgot_pass.dart';
import 'package:book_store/features/book/presentation/pages/userlogin/login_screen.dart';
import 'package:book_store/features/book/presentation/pages/userlogin/sign_up_screen.dart';

import 'package:go_router/go_router.dart';

enum AppRoute {
  login,
  signup,
  forgot,
  home,
  bottomnav,
  account,
  categoriyBooks,
  categories,
  checkout,
  address,
  paymentSuccess
}

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
      GoRoute(
        path: '/categoryBooks',
        name: AppRoute.categoriyBooks.name,
        builder: (context, state) {
          final bookType = state.extra as BookType;

          return CategoriesBooksScreen(
            bookTypeId: bookType.bookTypeId,
            bookTypeName: bookType.bookTypeName,
          );
        },
      ),
      GoRoute(
        path: '/checkout',
        name: AppRoute.checkout.name,
        builder: (context, state) {
          return const CheckOutScreen();
        },
      ),
      GoRoute(
        path: '/address',
        name: AppRoute.address.name,
        builder: (context, state) {
          return const AddAddressScreen();
        },
      ),
      GoRoute(
        path: '/paymentSuccess',
        name: AppRoute.paymentSuccess.name,
        builder: (context, state) {
          return const PaymentSuccessScreen();
        },
      ),
    ],
  );

  static void goTo(String path) {
    router.go(path);
  }
}
