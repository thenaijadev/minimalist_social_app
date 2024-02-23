// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:uuid/uuid.dart';

class ChatMessage {
  String? id;
  String sender;
  String message;
  DateTime? time;

  ChatMessage({
    this.id,
    required this.sender,
    required this.message,
    required this.time,
  }) {
    id = const Uuid().v4(); // Generate a random UUID for the message ID
    time ??= DateTime.now(); // If time is not provided, set it to current time
  }

  ChatMessage copyWith({
    String? id,
    String? sender,
    String? message,
    DateTime? time,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      sender: sender ?? this.sender,
      message: message ?? this.message,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'sender': sender,
      'message': message,
      'time': time?.toIso8601String(),
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id'] != null ? map['id'] as String : null,
      sender: map['sender'] as String,
      message: map['message'] as String,
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMessage.fromJson(String source) =>
      ChatMessage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatMessage(id: $id, sender: $sender, message: $message, time: $time)';
  }

  @override
  bool operator ==(covariant ChatMessage other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.sender == sender &&
        other.message == message &&
        other.time == time;
  }

  @override
  int get hashCode {
    return id.hashCode ^ sender.hashCode ^ message.hashCode ^ time.hashCode;
  }
}
