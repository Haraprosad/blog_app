import 'dart:developer';

import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/core/secrets/supabase_secrets.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:blog_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_in.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/blog/data/datasources/blog_local_datasource.dart';
import 'package:blog_app/features/blog/data/datasources/blog_remote_datasource.dart';
import 'package:blog_app/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
    url: SupabaseSecrets.supabaseUrl,
    anonKey: SupabaseSecrets.supabaseKey,
  );
  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
  serviceLocator.registerLazySingleton(() => supabase.client);

  //core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(() => InternetConnection());
  serviceLocator.registerLazySingleton(() => Hive.box(name: 'blogs'));
}

void _initAuth() {
  //Data Source
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(
          supabaseClient: serviceLocator(),
        ))

    //Repository
    ..registerFactory<AuthRepository>(() => AuthRepositoryImpl(
          authRemoteDataSource: serviceLocator(),
          connectionChecker: serviceLocator(),
        ))

    //Use Cases
    ..registerFactory(() => UserSignUp(
          authRepository: serviceLocator(),
        ))
    ..registerFactory(() => UserSignIn(
          authRepository: serviceLocator(),
        ))
    ..registerFactory(() => CurrentUser(
          authRepository: serviceLocator(),
        ))

    //Bloc
    ..registerLazySingleton(() => AuthBloc(
          userSignUp: serviceLocator(),
          userSignIn: serviceLocator(),
          currentUser: serviceLocator(),
          appUserCubit: serviceLocator(),
        ));
}

void _initBlog() {
  //Data Source
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(() => BlogRemoteDataSourceImpl(
          supabaseClient: serviceLocator(),
        ))
    ..registerFactory<BlogLocalDataSource>(() => BlogLocalDataSourceImpl(
          box: serviceLocator(),
        ))

    //Repository
    ..registerFactory<BlogRepository>(() => BlogRepositoryImpl(
          blogRemoteDataSource: serviceLocator(),
          blogLocalDataSource: serviceLocator(),
          connectionChecker: serviceLocator(),
        ))
    //Use Cases
    ..registerFactory(() => UploadBlog(
          blogRepository: serviceLocator(),
        ))
    ..registerFactory(() => GetAllBlogs(
          blogRepository: serviceLocator(),
        ))

    //Bloc
    ..registerLazySingleton(() => BlogBloc(
          uploadBlog: serviceLocator(),
          getAllBlogs: serviceLocator(),
        ));
}
