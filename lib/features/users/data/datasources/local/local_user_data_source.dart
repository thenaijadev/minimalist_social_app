import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:minimalist_social_app/core/errors/auth_error.dart';
import 'package:minimalist_social_app/core/errors/user_error.dart';
import 'package:minimalist_social_app/core/utils/typedef.dart';
import 'package:minimalist_social_app/features/users/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthUserLocalDataSource {
  FutureEitherUserOrUserError saveUser(FutureEitherUserOrUserError user);

  FutureEitherLocalUserOrUserError getUser();
  EitherFutureTrueOrUserError deleteUser();
}

class AuthUserLocalDataSourceImpl implements AuthUserLocalDataSource {
  final Future<SharedPreferences> sharedPreferences;
  final String cachedUser;
  AuthUserLocalDataSourceImpl(
      {required this.sharedPreferences, this.cachedUser = 'CACHED_AUTHUSER'});

  @override
  FutureEitherLocalUserOrUserError getUser() async {
    final preferences = await sharedPreferences;
    final jsonString = preferences.getString(cachedUser);

    if (jsonString != null) {
      final userModel =
          await Future.value(UserModel.fromJson(json.decode(jsonString)));

      return right(userModel);
    } else {
      return left(UserError(message: "Unable to get locally saved auth user"));
    }
  }

  @override
  FutureEitherUserOrUserError saveUser(FutureEitherUserOrUserError user) async {
    final preferences = await sharedPreferences;
    final theUser = await user;
    theUser.fold((l) {
      return left(AuthError(
          message: "There has been an error saving auth user locally"));
    }, (r) async {
      final isSaved = await preferences.setString(
        cachedUser,
        json.encode(
          r.toJson(),
        ),
      );
      return right(isSaved);
    });

    return left(
        UserError(message: "There has been an error saving auth user locally"));
  }

  @override
  EitherFutureTrueOrUserError deleteUser() async {
    try {
      final preferences = await sharedPreferences;
      bool isDeleted = await preferences.remove(cachedUser);
      return right(isDeleted);
    } catch (e) {
      return left(UserError(
          message: "There has been an error deleting the user locally"));
    }
  }
}
