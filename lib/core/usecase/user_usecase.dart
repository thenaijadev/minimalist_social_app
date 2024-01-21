import 'package:minimalist_social_app/core/utils/typedef.dart';

abstract class UseCase<Type> {
  EitherTrueOrUserError createUserDocument(
      {required String email, required String userName});
}
