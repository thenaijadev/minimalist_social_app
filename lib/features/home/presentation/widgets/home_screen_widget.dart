import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimalist_social_app/core/widgets/text_widget.dart';
import 'package:minimalist_social_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:minimalist_social_app/features/auth/presentation/widgets/input_field_widget.dart';

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({
    super.key,
  });

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('users')
      .orderBy("lastContacted", descending: false)
      .snapshots();
  final searchKey = GlobalKey<FormFieldState>();
  bool? usernameState = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
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
                ? Padding(
                    padding: const EdgeInsets.only(
                        right: 20, left: 20.0, top: 10, bottom: 0),
                    child: Column(
                      children: [
                        Transform.scale(
                          scaleX: 1.1,
                          child: InputFieldWidget(
                            padding: const EdgeInsets.all(0),
                            textFieldkey: searchKey,
                            hintText: "Search user",
                            verticalContentPadding: 0,
                            suffixIcon: const Icon(
                              CupertinoIcons.search,
                              size: 15,
                            ),
                            onChanged: (val) {
                              setState(() {
                                usernameState =
                                    searchKey.currentState?.validate();
                              });
                            },
                            enabledBorderRadius: 10,
                            hintColor: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: ListView.builder(
                              // controller: widget.controller,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final document = snapshot.data!.docs;
                                final data = document[index].data()!
                                    as Map<String, dynamic>;

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: ListTile(
                                    leading: const CircleAvatar(
                                      radius: 30,
                                    ),
                                    title: TextWidget(
                                      text: data['userName']
                                          .toString()
                                          .toUpperCase(),
                                      color: theme.inversePrimary,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox();
          },
        );
      },
    );
  }
}
