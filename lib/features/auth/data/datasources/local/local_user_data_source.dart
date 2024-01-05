import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:minimalist_social_app/core/Models/article_error.dart';
import 'package:minimalist_social_app/core/utils/typedef.dart';
import 'package:minimalist_social_app/features/auth/data/models/auth_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthUserLocalDataSource {
  FutureEitherAuthUserOrAuthError saveUser(
      FutureEitherAuthUserOrAuthError user);

  FutureEitherLocalAuthUserOrAuthError getUser();
  EitherFutureTrueOrAuthError deleteUser();
}

const cachedPokemon = 'CACHED_AUTHUSER';

class AuthUserLocalDataSourceImpl implements AuthUserLocalDataSource {
  final Future<SharedPreferences> sharedPreferences;

  AuthUserLocalDataSourceImpl({required this.sharedPreferences});

  @override
  FutureEitherLocalAuthUserOrAuthError getUser() async {
    final preferences = await sharedPreferences;
    final jsonString = preferences.getString(cachedPokemon);

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
        cachedPokemon,
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
      bool isDeleted = await preferences.remove(cachedPokemon);
      return right(isDeleted);
    } catch (e) {
      return left(AuthError(
          message: "There has been an error deleting the user locally"));
    }
  }
}
