import 'package:flutter/material.dart';
import 'package:minimalist_social_app/features/home/presentation/widgets/message_bubble.dart';

class Messages extends StatefulWidget {
  const Messages({super.key});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
        child: ListView(
          children: const [
            MessageBubble(
              isMe: true,
            ),
            MessageBubble(
              isMe: false,
            )
          ],
        ),
      ),
    );
  }
}
