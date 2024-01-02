// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:minimalist_social_app/core/models/article_error.dart';

class RemoteDataSourseError extends ArticleError {
  RemoteDataSourseError({required super.message});

  @override
  String toString() => 'RemoteDataSourseError(message: $message)';
}
