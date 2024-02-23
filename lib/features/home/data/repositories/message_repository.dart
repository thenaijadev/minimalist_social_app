import 'package:minimalist_social_app/core/utils/typedef.dart';
import 'package:minimalist_social_app/features/home/data/Models/message.dart';
import 'package:minimalist_social_app/features/home/data/provider/message_provider.dart';

class MessageRepository {
  MessageRepository({required this.provider});
  final MessageProvider provider;

  EitherBoolOrChatError sendMessage(ChatMessage message) {
    return provider.sendMessage(message);
  }

  Future<EitherBoolOrChatError> deleteMessage(String messageId) async {
    return provider.deleteMessage(messageId);
  }
}
