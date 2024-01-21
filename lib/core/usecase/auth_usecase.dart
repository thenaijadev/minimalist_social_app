import 'package:minimalist_social_app/core/utils/typedef.dart';

abstract class UseCase<Type> {
  FutureEitherAuthUserOrAuthError createUser(
      {required String email,
      required String password,
      required String userName});

  FutureEitherAuthUserOrAuthError logIn({
    required String email,
    required String password,
  });
  FutureEitherAuthUserOrAuthError getcurrentUser();

  EitherFutureTrueOrAuthError logOut();
  EitherFutureTrueOrAuthError sendEmailVerification();
  EitherFutureTrueOrAuthError sendPasswordReset({required String toEmail});
}
