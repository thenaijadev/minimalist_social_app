import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:minimalist_social_app/core/widgets/text_widget.dart';
import 'package:minimalist_social_app/features/home/presentation/widgets/alert_dialog.dart';

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
        showAlertDialog(context: context, message: message, id: id, isMe: isMe);
        if (isMe) {}
      },
      child: FadeInUp(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: sender == "" ? "You" : sender,
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
