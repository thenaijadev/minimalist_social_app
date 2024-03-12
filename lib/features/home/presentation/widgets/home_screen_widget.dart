import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimalist_social_app/config/router/routes.dart';
import 'package:minimalist_social_app/core/widgets/loading_widget.dart';
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
          return const Center(
            child: LoadingWidget(),
          );
        }

        return BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return state is AuthStateIsLoggedIn
                ? Padding(
                    padding: const EdgeInsets.only(
                        right: 20, left: 20.0, top: 0, bottom: 0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * .9,
                      child: ListView(
                        children: [
                          Transform.scale(
                            scaleX: 1.08,
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
                              hintColor:
                                  Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.9,
                              child: ListView.builder(
                                // controller: widget.controller,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  final document = snapshot.data!.docs;
                                  final data = document[index].data()!
                                      as Map<String, dynamic>;

                                  return data['email'] != state.user.email
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: Container(
                                            height: 70,
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        width: .1,
                                                        color: theme
                                                            .inversePrimary))),
                                            child: ListTile(
                                              onTap: () {
                                                Navigator.of(context).pushNamed(
                                                    Routes.chats,
                                                    arguments: data);

                                                (data);
                                              },
                                              leading: data["profilePicture"]
                                                          .toString() ==
                                                      "null"
                                                  ? const Icon(
                                                      CupertinoIcons
                                                          .profile_circled,
                                                      size: 50,
                                                    )
                                                  : CircleAvatar(
                                                      radius: 30,
                                                      child: data["profilePicture"]
                                                                  .toString() ==
                                                              "null"
                                                          ? const Icon(
                                                              CupertinoIcons
                                                                  .profile_circled,
                                                              size: 30,
                                                            )
                                                          : Image.network(
                                                              '${data["profilePicture"]}'),
                                                    ),
                                              title: TextWidget(
                                                text:
                                                    data["userName"].toString(),
                                                color: theme.inversePrimary,
                                              ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox();
                                },
                              ),
                            ),
                          ),
                        ],
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
