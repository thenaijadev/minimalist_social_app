import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:minimalist_social_app/core/errors/auth_error.dart';
import 'package:minimalist_social_app/core/utils/typedef.dart';
import 'package:minimalist_social_app/features/auth/data/models/auth_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthUserLocalDataSource {
  FutureEitherAuthUserOrAuthError saveUser(
      FutureEitherAuthUserOrAuthError user);

  FutureEitherLocalAuthUserOrAuthError getUser();
  EitherFutureTrueOrAuthError deleteUser();
}

class AuthUserLocalDataSourceImpl implements AuthUserLocalDataSource {
  final Future<SharedPreferences> sharedPreferences;
  final String cachedUser;
  AuthUserLocalDataSourceImpl(
      {required this.sharedPreferences, this.cachedUser = 'CACHED_AUTHUSER'});

  @override
  FutureEitherLocalAuthUserOrAuthError getUser() async {
    final preferences = await sharedPreferences;
    final jsonString = preferences.getString(cachedUser);

    if (jsonString != null) {
      final newsArticleModel =
          await Future.value(AuthUserModel.fromJson(json.decode(jsonString)));

      return right(newsArticleModel);
    } else {
      return left(AuthError(message: "Unable to get locally saved articles"));
    }
  }

  @override
  FutureEitherAuthUserOrAuthError saveUser(
      FutureEitherAuthUserOrAuthError user) async {
    final preferences = await sharedPreferences;
    final theUser = await user;
    theUser.fold((l) {
      return left(AuthError(
          message: "There has been an error saving articles locally"));
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
        AuthError(message: "There has been an error saving articles locally"));
  }

  @override
  EitherFutureTrueOrAuthError deleteUser() async {
    try {
      final preferences = await sharedPreferences;
      bool isDeleted = await preferences.remove(cachedUser);
      return right(isDeleted);
    } catch (e) {
      return left(AuthError(
          message: "There has been an error deleting the user locally"));
    }
  }
}
