import 'package:minimalist_social_app/core/utils/typedef.dart';

abstract class FirebaseAuthRepository {
  FutureEitherAuthUserOrAuthError createUser(
      {required String email,
      required String password,
      required String userName});

  FutureEitherAuthUserOrAuthError getcurrentUser();

  FutureEitherAuthUserOrAuthError logIn({
    required String email,
    required String password,
  });

  EitherFutureTrueOrAuthError logOut();
  EitherFutureTrueOrAuthError sendEmailVerification();
  EitherFutureTrueOrAuthError sendPasswordReset({required String toEmail});
}
