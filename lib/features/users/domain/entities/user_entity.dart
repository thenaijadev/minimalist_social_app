import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String userName;

  const UserEntity({
    required this.id,
    required this.email,
    required this.userName,
  });

  @override
  List<Object?> get props => [
        id,
        email,
        userName,
      ];
}
