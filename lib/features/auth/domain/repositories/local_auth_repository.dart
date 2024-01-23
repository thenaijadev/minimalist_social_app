import 'package:minimalist_social_app/core/utils/typedef.dart';

abstract class LocalAuthRepository {
  EitherBoolOrLocalAuthError canAuthenticateWithBiometrics();
  EitherListOfBiometricsOrLocalAuthError getBiometricsTypes();
  EitherBoolOrLocalAuthError authenticate();
}
