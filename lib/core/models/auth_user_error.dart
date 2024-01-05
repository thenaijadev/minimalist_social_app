// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:minimalist_social_app/core/models/article_error.dart';

class AuthUserError extends AuthError {
  AuthUserError({required super.message});

  @override
  String toString() => 'AuthUserError(message: $message)';
}
