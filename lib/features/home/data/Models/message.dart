// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:uuid/uuid.dart';

class ChatMessage {
  String? id;
  String sender;
  String message;
  String? time;
  DateTime? arrangementTime;
  ChatMessage(
      {this.id,
      required this.sender,
      required this.message,
      this.time,
      this.arrangementTime}) {
    id = const Uuid().v4(); // Generate a random UUID for the message ID
    time ??=
        '${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()} at ${DateTime.now().hour.toString()}:${DateTime.now().minute.toString()}';
    arrangementTime ??=
        DateTime.now(); // // If time is not provided, set it to current time
  }

  ChatMessage copyWith({
    String? id,
    String? sender,
    String? message,
    String? time,
    DateTime? arrangementTime,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      sender: sender ?? this.sender,
      message: message ?? this.message,
      time: time ?? this.time,
      arrangementTime: arrangementTime ?? this.arrangementTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'sender': sender,
      'message': message,
      'time': time,
      'arrangementTime': arrangementTime?.millisecondsSinceEpoch,
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id'] != null ? map['id'] as String : null,
      sender: map['sender'] as String,
      message: map['message'] as String,
      time: map['time'] != null ? map['time'] as String : null,
      arrangementTime: map['arrangementTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['arrangementTime'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMessage.fromJson(String source) =>
      ChatMessage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatMessage(id: $id, sender: $sender, message: $message, time: $time, arrangementTime: $arrangementTime)';
  }

  @override
  bool operator ==(covariant ChatMessage other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.sender == sender &&
        other.message == message &&
        other.time == time &&
        other.arrangementTime == arrangementTime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        sender.hashCode ^
        message.hashCode ^
        time.hashCode ^
        arrangementTime.hashCode;
  }
}
