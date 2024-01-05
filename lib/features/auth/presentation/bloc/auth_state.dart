// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthStateIsNotLoggedIn extends AuthState {}

class AuthStateIsLoggedIn extends AuthState {
  final AuthUserEntity user;
  const AuthStateIsLoggedIn({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}

class AuthStateUserCreated extends AuthState {
  final AuthUserEntity user;
  const AuthStateUserCreated({
    required this.user,
  });

  @override
  List<Object> get props => [];
}

class AuthStateIsLoading extends AuthState {
  const AuthStateIsLoading();

  @override
  List<Object> get props => [];
}

class AuthStateAuthError extends AuthState {
  final AuthError authError;
  const AuthStateAuthError({
    required this.authError,
  });
}

class AuthStateEmailVerificationLinkSent extends AuthState {
  const AuthStateEmailVerificationLinkSent();
}

class AuthStatePasswordResetSent extends AuthState {
  const AuthStatePasswordResetSent();
}
