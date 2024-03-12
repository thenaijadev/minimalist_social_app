// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'message_bloc.dart';

abstract class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object> get props => [];
}

class MessageStateInitial extends MessageState {}

class MessageStateIsLoading extends MessageState {}

class MessageStateError extends MessageState {
  final MessageError error;
  const MessageStateError({
    required this.error,
  });
}

class MessageStateMessagesSent extends MessageState {}

class MessageStateMessageDeleted extends MessageState {}

class MessageStateMessageUpdated extends MessageState {}
