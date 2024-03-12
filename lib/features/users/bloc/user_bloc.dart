import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minimalist_social_app/core/errors/user_error.dart';
import 'package:minimalist_social_app/features/users/data/repositories/user_repository.dart';
import 'package:minimalist_social_app/features/users/data/users/user_model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  UserBloc({required this.userRepository}) : super(UserInitial()) {
    on<UserEventCreateUser>((event, emit) async {
      emit(UserStateIsLoading());
      final String email = event.email;
      final String userName = event.userName;
      final bool isEmailVerified = event.isVerified;
      final res = userRepository.createUser(UserModel(
          email: email, userName: userName, isVerified: isEmailVerified));
      res.fold((l) => emit(UserStateError(userError: l)), (r) {
        final user = UserModel(
            email: email, userName: userName, isVerified: isEmailVerified);

        emit(UserStateUserCreated(user: user));
      });
    });
  }
}
