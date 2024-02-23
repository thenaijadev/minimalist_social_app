import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:minimalist_social_app/core/errors/chat_error.dart';
import 'package:minimalist_social_app/core/utils/typedef.dart';
import 'package:minimalist_social_app/features/home/data/Models/message.dart';

class MessageProvider {
  MessageProvider({required this.db});
  final FirebaseFirestore db;
  EitherBoolOrChatError sendMessage(ChatMessage message) {
    try {
      db.collection("messages").doc(message.id).set(message.toMap());

      return right(true);
    } catch (e) {
      return left(ChatError(message: e.toString()));
    }
  }
}
