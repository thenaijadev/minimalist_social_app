import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimalist_social_app/core/utils/logger.dart';
import 'package:minimalist_social_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:minimalist_social_app/features/chat/presentation/widgets/message_bubble.dart';

class Messages extends StatefulWidget {
  const Messages({super.key, required this.controller, required this.reciever});
  final ScrollController controller;
  final Map<String, dynamic> reciever;
  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('messages')
      .orderBy("arrangementTime", descending: false)
      .snapshots();
  @override
  void initState() {
    super.initState();
    logger.e(widget.reciever);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        Future.delayed(Durations.medium1, () {
          if (widget.controller.position.atEdge) {
            return;
          }
          widget.controller.animateTo(
              curve: Curves.decelerate,
              duration: const Duration(milliseconds: 200),
              widget.controller.position.maxScrollExtent + 500);
        });
        return BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return state is AuthStateIsLoggedIn
                ? Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 20, left: 20.0, top: 10, bottom: 0),
                      child: snapshot.data!.docs.isNotEmpty
                          ? ListView.builder(
                              controller: widget.controller,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final document = snapshot.data!.docs;
                                final data = document[index].data()!
                                    as Map<String, dynamic>;
                                final String id = data["id"];
                                return id.contains(state.user.email) &&
                                        id.contains(widget.reciever["email"])
                                    ? MessageBubble(
                                        time: data['time'],
                                        id: data["id"],
                                        sender:
                                            data['sender'] == state.user.email
                                                ? ""
                                                : data['sender'],
                                        message: data["message"],
                                        isMe:
                                            data['sender'] == state.user.email)
                                    : const SizedBox();
                              },
                            )
                          : const SizedBox(),
                    ),
                  )
                : const SizedBox();
          },
        );
      },
    );
  }
}
