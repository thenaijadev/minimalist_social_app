import 'package:minimalist_social_app/core/utils/typedef.dart';

abstract class UserRepository {
  EitherTrueOrUserError createUserDocument(
      {required String email, required String userName});
}
