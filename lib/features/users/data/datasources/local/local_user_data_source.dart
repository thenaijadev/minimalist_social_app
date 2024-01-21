import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:minimalist_social_app/core/errors/user_error.dart';
import 'package:minimalist_social_app/core/utils/typedef.dart';
import 'package:minimalist_social_app/features/users/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLocalDataSource {
  FutureEitherUserOrUserError saveUser(UserModel user);

  FutureEitherLocalUserOrUserError getUser();
  EitherFutureTrueOrUserError deleteUser();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final Future<SharedPreferences> sharedPreferences;
  final String cachedUser;
  UserLocalDataSourceImpl(
      {required this.sharedPreferences, this.cachedUser = 'CACHED_USER'});

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
  FutureEitherUserOrUserError saveUser(UserModel user) async {
    final preferences = await sharedPreferences;

    try {
      await preferences.setString(
        cachedUser,
        json.encode(
          user.toJson(),
        ),
      );
      return right(user);
    } catch (e) {
      return left(
        UserError(
          message: e.toString(),
        ),
      );
    }
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
