import 'package:minimalist_social_app/core/utils/typedef.dart';
import 'package:minimalist_social_app/features/auth/data/datasources/remote/local_auth_service.dart';
import 'package:minimalist_social_app/features/auth/domain/repositories/local_auth_repository.dart';

class LocalAuthRepositoryImplementation implements LocalAuthRepository {
  final LocalAuthService authService;

  LocalAuthRepositoryImplementation({
    required this.authService,
  });
  @override
  EitherBoolOrLocalAuthError canAuthenticateWithBiometrics() async {
    return authService.canAuthenticateWithBiometrics();
  }

  @override
  EitherListOfBiometricsOrLocalAuthError getBiometricsTypes() async {
    return authService.getBiometricsTypes();
  }

  @override
  EitherBoolOrLocalAuthError authenticate() async {
    return authService.authenticate();
  }
}
