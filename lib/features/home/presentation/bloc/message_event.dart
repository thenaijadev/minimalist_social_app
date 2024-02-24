// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'message_bloc.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

class MessageEventSendMessage extends MessageEvent {
  final ChatMessage chat;
  const MessageEventSendMessage({
    required this.chat,
  });
}

class MessageEventDeleteMessage extends MessageEvent {
  final String messageId;
  const MessageEventDeleteMessage({required this.messageId});
}

class MessageEventUpdateMessage extends MessageEvent {
  final String messageId;
  const MessageEventUpdateMessage({required this.messageId});
}
