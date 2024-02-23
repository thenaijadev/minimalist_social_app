import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimalist_social_app/core/widgets/dark_mode_switch.dart';
import 'package:minimalist_social_app/core/widgets/snackbar.dart';
import 'package:minimalist_social_app/core/widgets/text_widget.dart';
import 'package:minimalist_social_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:minimalist_social_app/features/home/data/Models/message.dart';
import 'package:minimalist_social_app/features/home/presentation/bloc/message_bloc.dart';
import 'package:minimalist_social_app/features/home/presentation/widgets/message_field.dart';
import 'package:minimalist_social_app/features/home/presentation/widgets/messages.dart';
import 'package:minimalist_social_app/features/home/presentation/widgets/my_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final messageFieldKey = GlobalKey<FormFieldState>();

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
          text: "The Wall",
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      drawer: const MyDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocListener<MessageBloc, MessageState>(
            listener: (context, state) {
              if (state is MessageStateIsLoading) {
                InfoSnackBar.showSuccessSnackBar(context, "Is Loading");
              }
              if (state is MessageStateMessagesSent) {}
            },
            child: const Messages(),
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
                                  message: messageFieldKey.currentState?.value,
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
    );
  }
}
