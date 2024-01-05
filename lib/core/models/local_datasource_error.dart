import 'package:minimalist_social_app/core/models/article_error.dart';

class LocalAuthUserError extends AuthError {
  LocalAuthUserError({required super.message});

  @override
  String toString() => 'LocalDataSourceError(message: $message)';
}
