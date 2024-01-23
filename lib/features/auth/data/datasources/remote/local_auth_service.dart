// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:local_auth/local_auth.dart';
import 'package:minimalist_social_app/core/errors/local_auth_error.dart';
import 'package:minimalist_social_app/core/utils/typedef.dart';

abstract class LocalAuthService {
  EitherBoolOrLocalAuthError canAuthenticateWithBiometrics();
  EitherListOfBiometricsOrLocalAuthError getBiometricsTypes();
}

class LocalAuthServiceImplementation implements LocalAuthService {
  final LocalAuthentication auth;
  LocalAuthServiceImplementation({
    required this.auth,
  });
  @override
  EitherBoolOrLocalAuthError canAuthenticateWithBiometrics() async {
    try {
      final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
      return right(canAuthenticateWithBiometrics);
    } catch (e) {
      return left(LocalAuthError(message: e.toString()));
    }
  }

  @override
  EitherListOfBiometricsOrLocalAuthError getBiometricsTypes() async {
    try {
      final List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();

      if (availableBiometrics.isNotEmpty) {}

      if (availableBiometrics.contains(BiometricType.strong) ||
          availableBiometrics.contains(BiometricType.face)) {
        // Specific types of biometrics are available.
        // Use checks like this with caution!
      }

      return right(availableBiometrics);
    } catch (e) {
      return left(LocalAuthError(message: e.toString()));
    }
  }
}
