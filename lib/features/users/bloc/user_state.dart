// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserStateIsLoading extends UserState {}

class UserStateError extends UserState {
  final UserError error;
  const UserStateError({
    required this.error,
  });
}

class UserStateUserCreated extends UserState {
  final UserModel user;
  const UserStateUserCreated({
    required this.user,
  });
}
