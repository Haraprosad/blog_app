import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import '../../../../core/common/entities/user.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  const AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, User>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    return _getUser(
        fn: () async => await authRemoteDataSource.signInWithEmailAndPassword(
              email: email,
              password: password,
            ));
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
        fn: () async => await authRemoteDataSource.signUpWithEmailAndPassword(
              email: email,
              name: name,
              password: password,
            ));
  }

  Future<Either<Failure, User>> _getUser({
    required Future<User> Function() fn,
  }) async {
    try {
      final user = await fn();
      return right(user);
    } on sb.AuthException catch (e) {
      return left(Failure(message: e.message));
    } 
    on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }
  
  @override
  Future<Either<Failure, User>> currentUser() async{
    try{
      final user = await authRemoteDataSource.getCurrentUserData();
      if(user==null){
        return left(Failure(message: "User not logged in!"));
      }
      return right(user);
    }on ServerException catch(e){
      return left(Failure(message: e.toString()));
    }
  }
}
