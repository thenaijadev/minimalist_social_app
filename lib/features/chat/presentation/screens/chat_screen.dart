import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimalist_social_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:minimalist_social_app/features/chat/data/models/chat_message.dart';
import 'package:minimalist_social_app/features/chat/presentation/bloc/message_bloc.dart';
import 'package:minimalist_social_app/features/chat/presentation/widgets/message_field.dart';
import 'package:minimalist_social_app/features/chat/presentation/widgets/messages.dart';
import 'package:minimalist_social_app/features/home/presentation/widgets/app_bar.dart';
import 'package:minimalist_social_app/features/home/presentation/widgets/my_drawer.dart';
import 'package:uuid/uuid.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.reciever});
  final Map<String, dynamic> reciever;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageFieldKey = GlobalKey<FormFieldState>();
  late ScrollController controller;
  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    (widget.reciever);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: theme.background,
      appBar: appBar(theme: theme, title: widget.reciever['userName']),
      drawer: const MyDrawer(),
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Messages(controller: controller, reciever: widget.reciever),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return state is AuthStateIsLoggedIn
                      ? MessageField(
                          fieldKey: messageFieldKey,
                          send: () {
                            if (messageFieldKey.currentState?.value
                                    .toString()
                                    .trim() ==
                                "") {
                              return;
                            }

                            context.read<MessageBloc>().add(
                                  MessageEventSendMessage(
                                    chat: ChatMessage(
                                      id: "${const Uuid().v4()}-${widget.reciever["email"]}-${state.user.email}",
                                      sender: state.user.email,
                                      senderId: state.user.id,
                                      reciever: widget.reciever["email"],
                                      message:
                                          messageFieldKey.currentState?.value,
                                    ),
                                  ),
                                );

                            messageFieldKey.currentState?.reset();
                          },
                          onChanged: (value) {},
                        )
                      : const SizedBox();
                },
              )
            ],
          ),
          Positioned(
            bottom: 85,
            right: 20,
            child: GestureDetector(
              onTap: () {
                controller.animateTo(
                    curve: Curves.decelerate,
                    duration: const Duration(milliseconds: 200),
                    controller.position.maxScrollExtent + 100);
              },
              child: CircleAvatar(
                backgroundColor: theme.inversePrimary,
                radius: 12,
                child: const Icon(Icons.arrow_downward_rounded),
              ),
            ),
          )
        ],
      ),
    );
  }
}
