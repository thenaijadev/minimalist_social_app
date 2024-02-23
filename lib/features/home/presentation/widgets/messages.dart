import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimalist_social_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:minimalist_social_app/features/home/presentation/widgets/message_bubble.dart';

class Messages extends StatefulWidget {
  const Messages({
    super.key,
  });

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('messages')
      .orderBy("time", descending: false)
      .snapshots();
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
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        return BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return state is AuthStateIsLoggedIn
                ? Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 20, left: 20.0, top: 10, bottom: 0),
                      child: ListView.builder(
                        controller: controller,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final document = snapshot.data!.docs;
                          final data =
                              document[index].data()! as Map<String, dynamic>;

                          return MessageBubble(
                              id: "",
                              sender: data['sender'] == state.user.email
                                  ? ""
                                  : data['sender'],
                              message: data["message"],
                              isMe: data['sender'] == state.user.email);
                        },
                      ),
                    ),
                  )
                : const SizedBox();
          },
        );
      },
    );
  }
}