import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minimalist_social_app/core/models/article_error.dart';
import 'package:minimalist_social_app/features/auth/domain/entities/auth_user_entity.dart';
import 'package:minimalist_social_app/features/auth/domain/usecases/auth_usecases.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthUsecase authUsecase})
      : super(AuthStateIsNotLoggedIn()) {
    on<AuthEventGetCurrentUser>((event, emit) async {
      final authUser = await authUsecase.getcurrentUser();
      authUser.fold((l) => AuthError(message: l.message), (r) {
        emit(AuthStateIsLoggedIn(user: r));
      });
    });

    on<AuthEventCreateUser>((event, emit) async {
      final String email = event.email;
      final String password = event.password;

      final authUser =
          await authUsecase.createUser(email: email, password: password);
      authUser.fold((l) => AuthError(message: l.message), (r) {
        emit(AuthStateIsLoggedIn(user: r));
      });
    });

    on<AuthEventLogin>((event, emit) async {
      final String email = event.email;
      final String password = event.password;

      final authUser =
          await authUsecase.logIn(email: email, password: password);
      authUser.fold((l) => AuthError(message: l.message), (r) {
        emit(AuthStateIsLoggedIn(user: r));
      });
    });

    on<AuthEventLogout>((event, emit) async {
      final authUser = await authUsecase.logOut();
      authUser.fold((l) => AuthError(message: l.message), (r) {
        emit(AuthStateIsNotLoggedIn());
      });
    });

    on<AuthEventSendEmailVerification>((event, emit) async {
      final authUser = await authUsecase.sendEmailVerification();
      authUser.fold((l) => AuthError(message: l.message), (r) {
        emit(const AuthStateEmailSent());
      });
    });

    on<AuthEventSendPasswordReset>((event, emit) async {
      final toEmail = event.toEmail;
      final authUser = await authUsecase.sendPasswordReset(toEmail: toEmail);
      authUser.fold((l) => AuthError(message: l.message), (r) {
        emit(const AuthStatePasswordResetSent());
      });
    });
  }
}
