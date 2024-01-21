// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class UsersEventCreateUser extends UsersEvent {
  final String email;
  final String userName;
  const UsersEventCreateUser({
    required this.email,
    required this.userName,
  });
  @override
  List<Object> get props => [];
}
