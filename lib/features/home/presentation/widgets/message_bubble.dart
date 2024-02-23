import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:minimalist_social_app/core/widgets/text_widget.dart';
import 'package:minimalist_social_app/features/home/presentation/bloc/message_bloc.dart';

class MessageBubble extends StatelessWidget {
  final bool isMe;
  final String message;
  final String sender;
  final String id;
  const MessageBubble(
      {super.key,
      required this.isMe,
      required this.message,
      required this.sender,
      required this.id});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        context
            .read<MessageBloc>()
            .add(MessageEventDeleteMessage(messageId: id));
      },
      child: FadeInUp(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          margin: EdgeInsets.only(
              right: isMe ? 0 : 90, left: !isMe ? 0 : 90, bottom: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(10).copyWith(
              bottomLeft: Radius.circular(!isMe ? 0 : 10),
              bottomRight: Radius.circular(isMe ? 0 : 10),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  TextWidget(
                    text: sender == "" ? "You" : sender,
                    textAlign: TextAlign.start,
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              const Gap(10),
              TextWidget(
                text: message,
                textAlign: TextAlign.start,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
