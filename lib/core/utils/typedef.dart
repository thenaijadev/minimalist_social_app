import 'package:minimalist_social_app/core/Models/article_error.dart';
import 'package:dartz/dartz.dart';

// typedef FutureEitherArticleOrException
//     = Future<Either<ArticleError, NewsArticlesEntity>>;

// typedef EitherArticleOrException = Either<ArticleError, NewsArticlesEntity>;

typedef EithertrueOrLocalDataSourceError = Future<Either<ArticleError, bool>>;

// typedef EitherArticleModelOrLocalDataSourceError
//     = Future<Either<ArticleError, NewsArticlesEntity>>;
