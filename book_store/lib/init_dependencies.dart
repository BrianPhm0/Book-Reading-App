import 'package:book_store/core/common/cubits/cubit/user_cubit.dart';
import 'package:book_store/features/book/business/repositories/auth_repository.dart';
import 'package:book_store/features/book/business/usecases/user_current.dart';
import 'package:book_store/features/book/business/usecases/user_forget_pass.dart';
import 'package:book_store/features/book/business/usecases/user_login.dart';
import 'package:book_store/features/book/business/usecases/user_sign_up.dart';
import 'package:book_store/features/book/data/datasourses/auth_remote_data_source.dart';
import 'package:book_store/features/book/data/repositories/auth_repository_impl.dart';
import 'package:book_store/features/book/presentation/bloc/auth_bloc.dart';
import 'package:book_store/firebase_options.dart';
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

  // Register data sources and repositories

  serviceLocator.registerLazySingleton(() => UserCubit());
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
    // Finally, register AuthBloc
    ..registerFactory<CurrentUser>(() => CurrentUser(serviceLocator()))
    ..registerLazySingleton<AuthBloc>(() => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        userForgetPass: serviceLocator(),
        currentUser: serviceLocator(),
        userCubit: serviceLocator()));
}
