import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final bool isMe;

  const MessageBubble({super.key, required this.isMe});
  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        margin: EdgeInsets.only(
            right: isMe ? 0 : 90, left: !isMe ? 0 : 90, bottom: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10).copyWith(
            bottomLeft: Radius.circular(!isMe ? 0 : 10),
            bottomRight: Radius.circular(isMe ? 0 : 10),
          ),
        ),
        child: const Text(
            "dasadfsfjdshfalsdkla;sfsdajfhaslDKHADLFASJDASLFHALFASta"),
      ),
    );
  }
}
