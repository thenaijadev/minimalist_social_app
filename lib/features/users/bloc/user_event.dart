// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserEventCreateUser extends UserEvent {
  final String userName;
  final String email;
  final bool isVerified;
  const UserEventCreateUser(
      {required this.userName, required this.email, required this.isVerified});
}
