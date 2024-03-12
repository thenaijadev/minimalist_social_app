import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimalist_social_app/core/widgets/dark_mode_switch.dart';
import 'package:minimalist_social_app/core/widgets/text_widget.dart';
import 'package:minimalist_social_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:minimalist_social_app/features/home/data/Models/message.dart';
import 'package:minimalist_social_app/features/home/presentation/bloc/message_bloc.dart';
import 'package:minimalist_social_app/features/chat/presentation/widgets/message_field.dart';
import 'package:minimalist_social_app/features/chat/presentation/widgets/messages.dart';
import 'package:minimalist_social_app/features/home/presentation/widgets/my_drawer.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

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
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        centerTitle: true,
        actions: const [
          DarkModeSwitch(),
        ],
        backgroundColor: Theme.of(context).colorScheme.background,
        title: TextWidget(
          text: "Chat",
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      drawer: const MyDrawer(),
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Messages(
                controller: controller,
              ),
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
                                      sender: state.user.email,
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
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
