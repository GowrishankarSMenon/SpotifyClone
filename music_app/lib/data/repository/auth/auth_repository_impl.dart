import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:music_app/data/models/auth/create_user_rq.dart';
import 'package:music_app/data/models/auth/signin_user_rq.dart';
import 'package:music_app/data/sources/auth/auth_firebase_service.dart';
import 'package:music_app/domain/repository/auth/auth.dart';
import 'package:music_app/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signin(SigninUserRq signinUserRq) async{
    return await sl<AuthFirebaseService>().signin(signinUserRq);
  }

  @override
  Future<Either> signup(CreateUserRq createUserRq) async {
    return await sl<AuthFirebaseService>().signup(createUserRq);
  }

}