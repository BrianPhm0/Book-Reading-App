import 'package:book_store/features/book/business/entities/categorybook/book_type.dart';
import 'package:book_store/features/book/presentation/pages/bottomnav/cart/add_address_screen.dart';
import 'package:book_store/features/book/presentation/pages/bottomnav/cart/cart.dart';
import 'package:book_store/features/book/presentation/pages/bottomnav/cart/detail_history_order.dart';
import 'package:book_store/features/book/presentation/pages/bottomnav/cart/detail_order_status.dart';
import 'package:book_store/features/book/presentation/pages/bottomnav/cart/manage_order.dart';
import 'package:book_store/features/book/presentation/pages/bottomnav/cart/payment_success_screen.dart';
import 'package:book_store/features/book/presentation/pages/bottomnav/cart/voucher_screen.dart';
import 'package:book_store/features/book/presentation/pages/bottomnav/categories/detail_book.dart';
import 'package:book_store/features/book/presentation/pages/bottomnav/categories/user_book_args.dart';
import 'package:book_store/features/book/presentation/pages/bottomnav/userAccount/account_screen.dart';
import 'package:book_store/features/book/presentation/pages/bottomnav/bottom_nav_screen.dart';
import 'package:book_store/features/book/presentation/pages/bottomnav/categories/categories_books_screen.dart';
import 'package:book_store/features/book/presentation/pages/bottomnav/cart/check_out_screen.dart';
import 'package:book_store/features/book/presentation/pages/bottomnav/userAccount/changes_screen.dart';
import 'package:book_store/features/book/presentation/pages/bottomnav/userAccount/settings_screen.dart';
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
  paymentSuccess,
  settings,
  changes,
  manageOrder,
  detailBook,
  cart,
  voucher,
  detailStatus,
  detailHistory
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
      GoRoute(
        path: '/settings',
        name: AppRoute.settings.name,
        builder: (context, state) {
          return const SettingsScreen();
        },
      ),
      GoRoute(
        path: '/changes',
        name: AppRoute.changes.name,
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>;
          final String propertyName = args['propertyName'] ?? '';
          final String propertyUser = args['propertyUser'] ?? '';
          final int index = args['index'] ?? '';

          return ChangesScreen(
            propertyName: propertyName,
            propertyUser: propertyUser,
            index: index,
          );
        },
      ),
      GoRoute(
        path: '/manageOrder',
        name: AppRoute.manageOrder.name,
        builder: (context, state) {
          return const ManageOrder();
        },
      ),
      GoRoute(
        path: '/detailBook',
        name: AppRoute.detailBook.name,
        builder: (context, state) {
          final UserBookArgs args = state.extra as UserBookArgs;

          return DetailBook(
            book: args.book,
            user: args.user,
            brandName: args.brandName,
          );
        },
      ),
      GoRoute(
        path: '/cart',
        name: AppRoute.cart.name,
        builder: (context, state) {
          return const Cart();
        },
      ),
      GoRoute(
        path: '/voucher',
        name: AppRoute.voucher.name,
        builder: (context, state) {
          return const VoucherScreen();
        },
      ),
      GoRoute(
        path: '/history',
        name: AppRoute.detailHistory.name,
        builder: (context, state) {
          return const DetailHistoryOrder();
        },
      ),
      GoRoute(
        path: '/status',
        name: AppRoute.detailStatus.name,
        builder: (context, state) {
          return const DetailOrderStatus();
        },
      ),
    ],
  );

  static void goTo(String path) {
    router.go(path);
  }
}
