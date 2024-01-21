import 'package:minimalist_social_app/core/errors/auth_error.dart';

class LocalAuthUserError extends AuthError {
  LocalAuthUserError({required super.message});

  @override
  String toString() => 'LocalDataSourceError(message: $message)';
}
