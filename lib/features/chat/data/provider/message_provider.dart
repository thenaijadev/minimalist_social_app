import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:minimalist_social_app/core/errors/message_error.dart';
import 'package:minimalist_social_app/core/utils/typedef.dart';
import 'package:minimalist_social_app/features/chat/data/models/chat_message.dart';

class MessageProvider {
  MessageProvider({required this.db});
  final FirebaseFirestore db;
  EitherBoolOrChatError sendMessage(ChatMessage message) {
    try {
      db.collection("messages").doc(message.id).set(message.toMap());
      return right(true);
    } catch (e) {
      return left(MessageError(message: e.toString()));
    }
  }

  Future<EitherBoolOrChatError> deleteMessage(String messageId) async {
    try {
      await db.collection("messages").doc(messageId).delete();
      return right(true);
    } catch (e) {
      return left(MessageError(message: e.toString()));
    }
  }

  Future<EitherBoolOrChatError> updateData(
      {required String messageId, required String updatedMessage}) async {
    try {
      final messageRef = db.collection("messages").doc(messageId);
      await messageRef.update({"message": updatedMessage});
      return right(true);
    } catch (e) {
      return left(MessageError(message: e.toString()));
    }
  }
}
