import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minimalist_social_app/core/errors/message_error.dart';
import 'package:minimalist_social_app/features/chat/data/models/chat_message.dart';
import 'package:minimalist_social_app/features/chat/data/repositories/message_repository.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageRepository repo;
  MessageBloc({required this.repo}) : super(MessageStateInitial()) {
    on<MessageEventSendMessage>((event, emit) {
      emit(MessageStateIsLoading());
      final message = event.chat;
      final res = repo.sendMessage(message);

      res.fold((l) => emit(MessageStateError(error: l)),
          (r) => emit(MessageStateMessagesSent()));

      emit(MessageStateInitial());
    });

    on<MessageEventDeleteMessage>((event, emit) async {
      emit(MessageStateIsLoading());
      final String messageId = event.messageId;
      final res = await repo.deleteMessage(messageId);

      res.fold((l) => emit(MessageStateError(error: l)),
          (r) => emit(MessageStateMessageDeleted()));
    });

    on<MessageEventUpdateMessage>((event, emit) async {
      emit(MessageStateIsLoading());
      final String messageId = event.messageId;
      final String updatedMessage = event.updatedMessage;
      final res = await repo.updateData(
          messageId: messageId, updatedMessage: updatedMessage);

      res.fold((l) => emit(MessageStateError(error: l)),
          (r) => emit(MessageStateMessageUpdated()));
    });
  }
}
