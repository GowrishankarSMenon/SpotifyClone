import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:music_app/data/models/auth/create_user_rq.dart';
import 'package:music_app/data/models/auth/signin_user_rq.dart';

abstract class AuthFirebaseService {
  Future<Either<String, String>> signin(SigninUserRq signinUserRq);
  Future<Either<String, String>> signup(CreateUserRq createUserRq);
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<Either<String, String>> signup(CreateUserRq createUserRq) async {
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createUserRq.email,
        password: createUserRq.password,
      );
      FirebaseFirestore.instance.collection('Users').add(
        {
          'name':createUserRq.fullName,
          'email':data.user?.email
        }
      );
      return const Right('Signup successful');
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'Account already exists with the same email';
      }
      return Left(message);
    }
  }

  @override
  Future<Either<String, String>> signin(SigninUserRq signinUserRq) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: signinUserRq.email,
        password: signinUserRq.password,
      );
      return const Right('Signin successful');
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'invalid-email') {
        message = 'No user found for that email';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password for that user';
      }
      return Left(message);
    }
  }
}
