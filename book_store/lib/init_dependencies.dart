import 'package:book_store/core/common/cubits/cubit/user_cubit.dart';
import 'package:book_store/features/book/business/repositories/address_repository.dart';
import 'package:book_store/features/book/business/repositories/auth_repository.dart';
import 'package:book_store/features/book/business/repositories/book_repository.dart';
import 'package:book_store/features/book/business/repositories/cart_repository.dart';
import 'package:book_store/features/book/business/repositories/check_repository.dart';
import 'package:book_store/features/book/business/repositories/detail_repository.dart';
import 'package:book_store/features/book/business/repositories/home_repository.dart';
import 'package:book_store/features/book/business/repositories/order_repository.dart';
import 'package:book_store/features/book/business/repositories/voucher_repository.dart';
import 'package:book_store/features/book/business/usecases/address/get_address.dart';
import 'package:book_store/features/book/business/usecases/address/save_address.dart';
import 'package:book_store/features/book/business/usecases/book/get_latest_book.dart';
import 'package:book_store/features/book/business/usecases/book/get_list_book_by_type.dart';
import 'package:book_store/features/book/business/usecases/book/get_list_book_type_usecase.dart';
import 'package:book_store/features/book/business/usecases/book/get_purchase_book.dart';
import 'package:book_store/features/book/business/usecases/book/search_book.dart';
import 'package:book_store/features/book/business/usecases/cart/delete_cart.dart';
import 'package:book_store/features/book/business/usecases/cart/get_cart.dart';
import 'package:book_store/features/book/business/usecases/cart/post_cart_item.dart';
import 'package:book_store/features/book/business/usecases/cart/update_item.dart';
import 'package:book_store/features/book/business/usecases/check/pay_cash.dart';
import 'package:book_store/features/book/business/usecases/detail/get_detail.dart';
import 'package:book_store/features/book/business/usecases/detail/get_review.dart';
import 'package:book_store/features/book/business/usecases/home/best_deal.dart';
import 'package:book_store/features/book/business/usecases/home/latest_book.dart';
import 'package:book_store/features/book/business/usecases/home/top_book.dart';
import 'package:book_store/features/book/business/usecases/order/cancel_order.dart';
import 'package:book_store/features/book/business/usecases/order/get_order.dart';
import 'package:book_store/features/book/business/usecases/order/get_order_by_id.dart';
import 'package:book_store/features/book/business/usecases/detail/post_review.dart';
import 'package:book_store/features/book/business/usecases/user/update_user.dart';
import 'package:book_store/features/book/business/usecases/user/user_current.dart';
import 'package:book_store/features/book/business/usecases/user/user_forget_pass.dart';
import 'package:book_store/features/book/business/usecases/user/user_get_user.dart';
import 'package:book_store/features/book/business/usecases/user/user_login.dart';
import 'package:book_store/features/book/business/usecases/user/user_login_jwt.dart';

import 'package:book_store/features/book/business/usecases/user/user_sign_out.dart';
import 'package:book_store/features/book/business/usecases/user/user_sign_up.dart';
import 'package:book_store/features/book/business/usecases/user/user_token_current.dart';
import 'package:book_store/features/book/business/usecases/user/verify.dart';
import 'package:book_store/features/book/business/usecases/voucher/add_voucher.dart';
import 'package:book_store/features/book/business/usecases/voucher/get_public_voucher.dart';
import 'package:book_store/features/book/business/usecases/voucher/get_voucher.dart';
import 'package:book_store/features/book/data/datasourses/local/local_data.dart';

import 'package:book_store/features/book/data/datasourses/remote/auth_remote_data_source.dart';
import 'package:book_store/features/book/data/datasourses/remote/book_remote_data_source.dart';
import 'package:book_store/features/book/data/datasourses/remote/cart_remote_data_source.dart';
import 'package:book_store/features/book/data/datasourses/remote/check_data.dart';
import 'package:book_store/features/book/data/datasourses/remote/detail_data.dart';
import 'package:book_store/features/book/data/datasourses/remote/home_remote_data_source.dart';
import 'package:book_store/features/book/data/datasourses/remote/order_data.dart';
import 'package:book_store/features/book/data/datasourses/remote/voucher_data.dart';
import 'package:book_store/features/book/data/repositories/address_repository_impl.dart';
import 'package:book_store/features/book/data/repositories/auth_repository_impl.dart';
import 'package:book_store/features/book/data/repositories/book_repository_impl.dart';
import 'package:book_store/features/book/data/repositories/cart_repository_impl.dart';
import 'package:book_store/features/book/data/repositories/check_repository_impl.dart';
import 'package:book_store/features/book/data/repositories/detail_repository_impl.dart';
import 'package:book_store/features/book/data/repositories/home_repository_impl.dart';
import 'package:book_store/features/book/data/repositories/order_repository_imple.dart';
import 'package:book_store/features/book/data/repositories/voucher_repository_impl.dart';
import 'package:book_store/features/book/presentation/bloc/address/address_bloc.dart';
import 'package:book_store/features/book/presentation/bloc/auth/auth_bloc.dart';
import 'package:book_store/features/book/presentation/bloc/order/order_bloc.dart';
import 'package:book_store/features/book/presentation/bloc/book/bloc/category/book_bloc.dart';
import 'package:book_store/features/book/presentation/bloc/book/bloc/home/home_bloc.dart';
import 'package:book_store/features/book/presentation/bloc/cart/bloc/cart_bloc.dart';
import 'package:book_store/features/book/presentation/bloc/check/check_bloc.dart';
import 'package:book_store/features/book/presentation/bloc/detail/detail_bloc.dart';
import 'package:book_store/features/book/presentation/bloc/voucher/voucher_bloc.dart';
import 'package:book_store/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Register FirebaseAuth instance
  serviceLocator.registerLazySingleton(() => FirebaseAuth.instance);
  serviceLocator.registerLazySingleton(() => FirebaseFirestore.instance);

  // Register data sources and repositories
  serviceLocator.registerLazySingleton(() => UserCubit());
  _initBook();
  _initHome();
  _initCart();
  _initAddress();
  _initCheck();
  _initDetail();
  _initVoucher();
  _initOrder();
}

void _initAuth() {
  // Register the AuthRemoteDataSource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImple(serviceLocator(), serviceLocator()))
    ..registerFactory<LocalData>(() => LocalDataImpl())

    // Register the AuthRepository
    ..registerFactory<AuthRepository>(
        () => AuthRepositoryImpl(serviceLocator()))

    // Register UserSignUp use case

    ..registerFactory<UserSignUp>(() => UserSignUp(serviceLocator()))
    //UserLogin
    ..registerFactory<UserLogin>(() => UserLogin(serviceLocator()))
    //User Reset Pass
    ..registerFactory<UserForgetPass>(() => UserForgetPass(serviceLocator()))
    ..registerFactory<UserSignOut>(() => UserSignOut(serviceLocator()))
    ..registerFactory<UserLoginJwt>(() => UserLoginJwt(serviceLocator()))
    ..registerFactory<GetUser>(() => GetUser(serviceLocator()))
    ..registerFactory<UpdateUser>(() => UpdateUser(serviceLocator()))
    ..registerFactory<UserTokenCurrent>(
        () => UserTokenCurrent(serviceLocator()))
    ..registerFactory<VerifyCode>(() => VerifyCode(serviceLocator()))

    // Finally, register AuthBloc

    //User Save Token
    // ..registerFactory<UserSaveToken>(() => UserSaveToken(serviceLocator()))
    ..registerFactory<CurrentUser>(() => CurrentUser(serviceLocator()))
    ..registerLazySingleton<AuthBloc>(() => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        userForgetPass: serviceLocator(),
        currentUser: serviceLocator(),
        userCubit: serviceLocator(),
        userSignOut: serviceLocator(),
        userLoginJwt: serviceLocator(),
        tokenCurrent: serviceLocator(),
        getUser: serviceLocator(),
        updateUser: serviceLocator(),
        verifyCode: serviceLocator()));
}

void _initBook() {
  serviceLocator
    ..registerFactory<BookRemoteDataSource>(
        () => BookRemoteDataSourceImpl(serviceLocator<FirebaseFirestore>()))

    // Register the BookRepository
    ..registerFactory<BookRepository>(
        () => BookRepositoryImpl(serviceLocator()))
    ..registerFactory<GetListBookTypeUsecase>(
        () => GetListBookTypeUsecase(serviceLocator()))
    ..registerFactory<GetListBooksByType>(
        () => GetListBooksByType(serviceLocator()))
    ..registerFactory<GetPurchaseBook>(() => GetPurchaseBook(serviceLocator()))
    ..registerFactory<GetLatestBook>(() => GetLatestBook(serviceLocator()))
    ..registerFactory<SearchBook>(() => SearchBook(serviceLocator()))
    ..registerLazySingleton<BookBloc>(() => BookBloc(
        bookTypeUsecase: serviceLocator(),
        booksByType: serviceLocator(),
        latestBook: serviceLocator(),
        purchaseBook: serviceLocator(),
        searchBook: serviceLocator()));
}

void _initHome() {
  serviceLocator
    ..registerFactory<HomeRemoteDataSource>(() => HomeRemoteDataSourceImp())
    ..registerFactory<HomeRepository>(
        () => HomeRepositoryImpl(serviceLocator()))
    ..registerFactory<LatestBook>(() => LatestBook(serviceLocator()))
    ..registerFactory<TopBook>(() => TopBook(serviceLocator()))
    ..registerFactory<BestDeal>(() => BestDeal(serviceLocator()))
    ..registerLazySingleton<HomeBloc>(() => HomeBloc(
        latestBook: serviceLocator(),
        topBook: serviceLocator(),
        bestDeal: serviceLocator()));
}

void _initCart() {
  serviceLocator
    ..registerFactory<CartRemoteDataSource>(() => CartRemoteDataSourceImpl())
    ..registerFactory<CartRepository>(
        () => CartRepositoryImpl(serviceLocator()))
    ..registerFactory<PostCartItem>(() => PostCartItem(serviceLocator()))
    ..registerFactory<GetCart>(() => GetCart(serviceLocator()))
    ..registerFactory<DeleteCart>(() => DeleteCart(serviceLocator()))
    ..registerFactory<UpdateItem>(() => UpdateItem(serviceLocator()))
    ..registerLazySingleton<CartBloc>(() => CartBloc(
        postCartItem: serviceLocator(),
        getCart: serviceLocator(),
        deleteCart: serviceLocator(),
        updateItem: serviceLocator()));
}

void _initAddress() {
  serviceLocator
    ..registerFactory<AddressRepository>(
        () => AddressRepositoryImpl(localData: serviceLocator()))
    ..registerFactory<SaveAddress>(() => SaveAddress(serviceLocator()))
    ..registerFactory<GetAddress>(() => GetAddress(serviceLocator()))
    ..registerLazySingleton<AddressBloc>(() => AddressBloc(
        saveAddress: serviceLocator(), getAddress: serviceLocator()));
}

void _initCheck() {
  serviceLocator
    ..registerFactory<CheckData>(() => CheckDataImpl())
    ..registerFactory<CheckRepository>(
        () => CheckRepositoryImpl(serviceLocator()))
    ..registerFactory<PayCash>(() => PayCash(serviceLocator()))
    // ..registerFactory<GetAddress>(() => GetAddress(serviceLocator()))
    ..registerLazySingleton<CheckBloc>(
        () => CheckBloc(payCash: serviceLocator()));
}

void _initDetail() {
  serviceLocator
    ..registerFactory<DetailData>(() => DetailDataImpl())
    ..registerFactory<DetailRepository>(
        () => DetailRepositoryImpl(serviceLocator()))
    ..registerFactory<GetDetail>(() => GetDetail(serviceLocator()))
    ..registerFactory<GetReview>(() => GetReview(serviceLocator()))
    ..registerFactory<PostReview>(() => PostReview(serviceLocator()))
    // ..registerFactory<GetAddress>(() => GetAddress(serviceLocator()))
    ..registerLazySingleton<DetailBloc>(() => DetailBloc(
        getDetail: serviceLocator(),
        getReview: serviceLocator(),
        postReview: serviceLocator()));
}

void _initVoucher() {
  serviceLocator
    ..registerFactory<VoucherData>(() => VoucherDataImpl())
    ..registerFactory<VoucherRepository>(
        () => VoucherRepositoryImpl(serviceLocator()))
    ..registerFactory<Getvoucher>(() => Getvoucher(serviceLocator()))
    ..registerFactory<GetPublicVoucher>(
        () => GetPublicVoucher(serviceLocator()))
    ..registerFactory<AddVoucher>(() => AddVoucher(serviceLocator()))
    ..registerLazySingleton<VoucherBloc>(() => VoucherBloc(
        getvoucher: serviceLocator(),
        getPublicVoucher: serviceLocator(),
        addVoucher: serviceLocator()));
}

void _initOrder() {
  serviceLocator
    ..registerFactory<OrderData>(() => OrderDataImpl())
    ..registerFactory<OrderRepository>(
        () => OrderRepositoryImpl(serviceLocator()))
    ..registerFactory<GetOrder>(() => GetOrder(serviceLocator()))
    ..registerFactory<GetOrderById>(() => GetOrderById(serviceLocator()))
    ..registerFactory<CancelOrder>(() => CancelOrder(serviceLocator()))

    // ..registerFactory<GetAddress>(() => GetAddress(serviceLocator()))
    ..registerLazySingleton<OrderBloc>(() => OrderBloc(
          getOrder: serviceLocator(),
          getOrderById: serviceLocator(),
          cancelOrder: serviceLocator(),
        ));
}
