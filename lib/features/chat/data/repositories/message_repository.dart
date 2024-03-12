import 'package:minimalist_social_app/core/utils/typedef.dart';
import 'package:minimalist_social_app/features/chat/data/models/message.dart';
import 'package:minimalist_social_app/features/chat/data/provider/message_provider.dart';

class MessageRepository {
  MessageRepository({required this.provider});
  final MessageProvider provider;

  EitherBoolOrChatError sendMessage(ChatMessage message) {
    return provider.sendMessage(message);
  }

  Future<EitherBoolOrChatError> deleteMessage(String messageId) async {
    return provider.deleteMessage(messageId);
  }

  Future<EitherBoolOrChatError> updateData(
      {required String messageId, required String updatedMessage}) async {
    return provider.updateData(
        messageId: messageId, updatedMessage: updatedMessage);
  }
}
