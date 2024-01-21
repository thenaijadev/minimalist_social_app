import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:minimalist_social_app/core/errors/user_error.dart';
import 'package:minimalist_social_app/core/utils/typedef.dart';

abstract class UserService {
  EitherTrueOrUserError createUserDocument({
    required String email,
    required String userName,
  });
}

class UserServiceImplementation implements UserService {
  @override
  EitherTrueOrUserError createUserDocument({
    required String email,
    required String userName,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(email)
          .set({"email": email, "username": userName});
      return right(true);
    } catch (e) {
      return left(UserError(message: e.toString()));
    }
  }
}
