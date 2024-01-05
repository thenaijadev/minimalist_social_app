// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:minimalist_social_app/features/auth/domain/entities/auth_user_entity.dart';

class AuthUserModel extends AuthUserEntity {
  const AuthUserModel({
    required super.id,
    required super.email,
    required super.isEmailVerified,
  });
  factory AuthUserModel.fromFirebase(User user) => AuthUserModel(
        id: user.uid,
        email: user.email!,
        isEmailVerified: user.emailVerified,
      );
  @override
  List<Object?> get props => [id, email, isEmailVerified];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'isEmailVerified': isEmailVerified,
    };
  }

  factory AuthUserModel.fromMap(Map<String, dynamic> map) {
    return AuthUserModel(
      id: (map['id'] ?? '') as String,
      email: (map['email'] ?? '') as String,
      isEmailVerified: (map['isEmailVerified'] ?? false) as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthUserModel.fromJson(String source) =>
      AuthUserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
