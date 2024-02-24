import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:minimalist_social_app/core/errors/message_error.dart';
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

  Future<EitherBoolOrChatError> updateData(String messageId) async {
    try {
      final washingtonRef = db.collection("cites").doc("DC");
      await washingtonRef.update({"capital": true});
      return right(true);
    } catch (e) {
      return left(MessageError(message: e.toString()));
    }
  }
}
