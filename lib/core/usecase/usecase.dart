import 'package:minimalist_social_app/core/utils/typedef.dart';

abstract class UseCase<Type> {
  FutureEitherAuthUserOrAuthError createUser({
    required String email,
    required String password,
  });

  FutureEitherAuthUserOrAuthError logIn({
    required String email,
    required String password,
  });

  EitherFutureTrueOrAuthError logOut();
  EitherFutureTrueOrAuthError sendEmailVerification();
  EitherFutureTrueOrAuthError sendPasswordReset({required String toEmail});
}
