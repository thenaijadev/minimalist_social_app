import 'package:flutter/material.dart';
import 'package:minimalist_social_app/core/widgets/dark_mode_switch.dart';
import 'package:minimalist_social_app/core/widgets/text_widget.dart';
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
      body: Center(
          child: Column(
        children: [
          const Messages(),
          MessageField(
            fieldKey: messageFieldKey,
            send: () {},
            onChanged: (value) {},
          )
        ],
      )),
    );
  }
}
