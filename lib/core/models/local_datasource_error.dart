import 'package:minimalist_social_app/core/models/article_error.dart';

class LocalDataSourceError extends ArticleError {
  LocalDataSourceError({required super.message});

  @override
  String toString() => 'LocalDataSourceError(message: $message)';
}
