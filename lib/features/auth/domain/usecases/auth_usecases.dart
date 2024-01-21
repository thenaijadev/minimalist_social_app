// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:minimalist_social_app/core/usecase/auth_usecase.dart';
import 'package:minimalist_social_app/core/utils/typedef.dart';
import 'package:minimalist_social_app/features/auth/domain/entities/auth_user_entity.dart';
import 'package:minimalist_social_app/features/auth/domain/repositories/firebase_auth_repository.dart';

class AuthUsecase implements UseCase<AuthUserEntity> {
  final FirebaseAuthRepository authRepository;
  AuthUsecase({
    required this.authRepository,
  });

  @override
  FutureEitherAuthUserOrAuthError logIn(
      {required String email, required String password}) {
    return authRepository.logIn(email: email, password: password);
  }

  @override
  EitherFutureTrueOrAuthError logOut() {
    return authRepository.logOut();
  }

  @override
  EitherFutureTrueOrAuthError sendEmailVerification() {
    return authRepository.sendEmailVerification();
  }

  @override
  EitherFutureTrueOrAuthError sendPasswordReset({required String toEmail}) {
    return authRepository.sendPasswordReset(toEmail: toEmail);
  }

  @override
  FutureEitherAuthUserOrAuthError getcurrentUser() {
    return authRepository.getcurrentUser();
  }

  @override
  FutureEitherAuthUserOrAuthError createUser({
    required String email,
    required String password,
    required String userName,
  }) {
    return authRepository.createUser(
        email: email, password: password, userName: userName);
  }
}
