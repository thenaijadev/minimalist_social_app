import 'package:flutter/material.dart';
import 'package:minimalist_social_app/features/auth/presentation/widgets/input_field_widget.dart';

class MessageField extends StatefulWidget {
  const MessageField(
      {super.key,
      required this.fieldKey,
      required this.send,
      required this.onChanged});
  final GlobalKey<FormFieldState> fieldKey;
  final void Function() send;
  final void Function(String) onChanged;
  @override
  State<MessageField> createState() => _MessageFieldState();
}

class _MessageFieldState extends State<MessageField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: InputFieldWidget(
        label: "",
        hintColor: Theme.of(context).colorScheme.inversePrimary,
        enabledBorderRadius: 10,
        hintText: "Type Messages",
        onChanged: (message) {},
        textFieldkey: widget.fieldKey,
        suffixIcon: GestureDetector(
          onTap: widget.send,
          child: const Icon(
            Icons.send,
          ),
        ),
      ),
    );
  }
}
