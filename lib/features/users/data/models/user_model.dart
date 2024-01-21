// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:minimalist_social_app/features/users/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    required super.userName,
  });
  // factory UserModel.fromFirebase(
  //   User user,
  // ) =>
  //     UserModel(
  //       id: user.uid,
  //       email: user.email!,
  //       isEmailVerified: user.emailVerified,
  //     );
  @override
  List<Object?> get props => [id, email, userName];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'userName': userName,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: (map['id'] ?? '') as String,
      email: (map['email'] ?? '') as String,
      userName: (map['userName']) as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
