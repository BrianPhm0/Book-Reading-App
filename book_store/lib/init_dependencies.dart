import 'package:book_store/core/common/cubits/cubit/user_cubit.dart';
import 'package:book_store/features/book/business/entities/book.dart';
import 'package:book_store/features/book/business/repositories/auth_repository.dart';
import 'package:book_store/features/book/business/repositories/book_repository.dart';
import 'package:book_store/features/book/business/usecases/get_list_book_by_type.dart';
import 'package:book_store/features/book/business/usecases/get_list_book_type_usecase.dart';
import 'package:book_store/features/book/business/usecases/user_current.dart';
import 'package:book_store/features/book/business/usecases/user_forget_pass.dart';
import 'package:book_store/features/book/business/usecases/user_login.dart';
import 'package:book_store/features/book/business/usecases/user_sign_out.dart';
import 'package:book_store/features/book/business/usecases/user_sign_up.dart';
import 'package:book_store/features/book/data/datasourses/auth_remote_data_source.dart';
import 'package:book_store/features/book/data/datasourses/book_remote_data_source.dart';
import 'package:book_store/features/book/data/repositories/auth_repository_impl.dart';
import 'package:book_store/features/book/data/repositories/book_repository_impl.dart';
import 'package:book_store/features/book/presentation/bloc/auth/auth_bloc.dart';
import 'package:book_store/features/book/presentation/bloc/book/bloc/book_bloc.dart';
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
}

void _initAuth() {
  // Register the AuthRemoteDataSource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImple(serviceLocator()))

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
    // Finally, register AuthBloc
    ..registerFactory<CurrentUser>(() => CurrentUser(serviceLocator()))
    ..registerLazySingleton<AuthBloc>(() => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        userForgetPass: serviceLocator(),
        currentUser: serviceLocator(),
        userCubit: serviceLocator(),
        userSignOut: serviceLocator()));
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
    ..registerLazySingleton<BookBloc>(() => BookBloc(
        bookTypeUsecase: serviceLocator(), booksByType: serviceLocator()));
}
