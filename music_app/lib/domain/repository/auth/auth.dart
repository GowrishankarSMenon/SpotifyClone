import 'package:dartz/dartz.dart';
import 'package:music_app/data/models/auth/create_user_rq.dart';
import 'package:music_app/data/models/auth/signin_user_rq.dart';

abstract class AuthRepository {
  Future<Either> signup(CreateUserRq createUserRq);
  Future<Either> signin(SigninUserRq signinUserRq);
}