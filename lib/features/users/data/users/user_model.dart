// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:uuid/uuid.dart';

class UserModel {
  String? id;
  String email;
  String userName;
  String? profilePicture;
  String? timeCreated;
  bool? isVerified;
  DateTime? lastContacted;

  UserModel(
      {this.id,
      required this.email,
      this.profilePicture,
      required this.userName,
      this.isVerified,
      this.timeCreated,
      this.lastContacted}) {
    id = const Uuid().v4();
    timeCreated ??=
        '${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()} at ${DateTime.now().hour.toString()}:${DateTime.now().minute.toString()}';
    lastContacted ??= DateTime.now();
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? userName,
    String? profilePicture,
    String? timeCreated,
    bool? isVerified,
    DateTime? lastContacted,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      userName: userName ?? this.userName,
      profilePicture: profilePicture ?? this.profilePicture,
      isVerified: isVerified ?? this.isVerified,
      timeCreated: timeCreated ?? this.timeCreated,
      lastContacted: lastContacted ?? this.lastContacted,
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, userName: $userName, profilePicture: $profilePicture, timeCreated: $timeCreated, isVerified: $isVerified, lastContacted: $lastContacted)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'userName': userName,
      'profilePicture': profilePicture,
      'timeCreated': timeCreated,
      'isVerified': isVerified,
      'lastContacted': lastContacted?.millisecondsSinceEpoch,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as String : null,
      email: map['email'] as String,
      userName: map['userName'] as String,
      profilePicture: map['profilePicture'] != null
          ? map['profilePicture'] as String
          : null,
      timeCreated:
          map['timeCreated'] != null ? map['timeCreated'] as String : null,
      isVerified: map['isVerified'] != null ? map['isVerified'] as bool : null,
      lastContacted: map['lastContacted'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['lastContacted'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
