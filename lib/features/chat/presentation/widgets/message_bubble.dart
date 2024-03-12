import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:minimalist_social_app/core/utils/logger.dart';
import 'package:minimalist_social_app/core/widgets/text_widget.dart';
import 'package:minimalist_social_app/features/chat/presentation/widgets/alert_dialog.dart';

class MessageBubble extends StatefulWidget {
  final bool isMe;
  final String message;
  final String sender;
  final String id;
  final String time;
  const MessageBubble({
    super.key,
    required this.isMe,
    required this.message,
    required this.sender,
    required this.id,
    required this.time,
  });

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  final GlobalKey<FormFieldState> fieldKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        if (widget.isMe) {
          showAlertDialog(
              context: context,
              message: widget.message,
              id: widget.id,
              isMe: widget.isMe,
              edit: () {
                Navigator.of(context).pop();
                (widget.id);
                showEditAlertDialog(
                    context: context, message: widget.message, id: widget.id);
              });
        }
      },
      child: FadeInUp(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          margin: EdgeInsets.only(
              right: widget.isMe ? 0 : 90,
              left: !widget.isMe ? 0 : 90,
              bottom: 20),
          decoration: BoxDecoration(
            color: widget.isMe
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.inversePrimary,
            borderRadius: BorderRadius.circular(10).copyWith(
              bottomLeft: Radius.circular(!widget.isMe ? 0 : 10),
              bottomRight: Radius.circular(widget.isMe ? 0 : 10),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: widget.sender == "" ? "You" : widget.sender,
                    textAlign: TextAlign.start,
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                  // IconButton(
                  //   onPressed: () {
                  //     showAlertDialog(context);
                  //   },
                  //   icon: const Icon(CupertinoIcons.ellipsis_vertical),
                  //   iconSize: 15,
                  // )
                ],
              ),
              TextWidget(
                  text: widget.message,
                  textAlign: TextAlign.start,
                  color: widget.isMe
                      ? Theme.of(context).colorScheme.inversePrimary
                      : Theme.of(context).colorScheme.primary),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextWidget(
                    text: widget.time,
                    textAlign: TextAlign.start,
                    color: widget.isMe
                        ? Theme.of(context).colorScheme.inversePrimary
                        : Theme.of(context).colorScheme.primary,
                    fontSize: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
