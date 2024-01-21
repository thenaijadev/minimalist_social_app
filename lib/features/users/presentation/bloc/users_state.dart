// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'users_bloc.dart';

abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

class UsersInitial extends UsersState {}

class UsersStateError extends UsersState {
  final UserError error;
  const UsersStateError({
    required this.error,
  });
}

class UsersStateUserCreated extends UsersState {
  const UsersStateUserCreated();
}
