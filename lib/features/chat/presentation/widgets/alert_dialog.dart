import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:minimalist_social_app/core/widgets/text_widget.dart';
import 'package:minimalist_social_app/features/chat/presentation/bloc/message_bloc.dart';
import 'package:minimalist_social_app/features/chat/presentation/widgets/alert_button.dart';
import 'package:minimalist_social_app/features/chat/presentation/widgets/message_field.dart';

showAlertDialog(
    {required BuildContext context,
    required String message,
    required String id,
    required bool isMe,
    required void Function()? edit}) {
  AlertDialog alert = AlertDialog(
    title: TextWidget(
      text: message,
      fontSize: 18,
      color: Theme.of(context).colorScheme.inversePrimary,
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AlertButton(
          label: "Edit",
          onPressed: edit,
        ),
        const Gap(10),
        AlertButton(
          label: "Delete",
          onPressed: () {
            context
                .read<MessageBloc>()
                .add(MessageEventDeleteMessage(messageId: id));
            Navigator.of(context).pop();
          },
        )
      ],
    ),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showEditAlertDialog({
  required BuildContext context,
  required String message,
  required String id,
}) {
  final GlobalKey<FormFieldState> fieldKey = GlobalKey<FormFieldState>();

  AlertDialog alert = AlertDialog(
    title: TextWidget(
      text: 'Current message: $message',
      fontSize: 18,
      color: Theme.of(context).colorScheme.inversePrimary,
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BlocListener<MessageBloc, MessageState>(
          listener: (context, state) {
            if (state is MessageStateMessageUpdated) {
              fieldKey.currentState?.reset();
              Navigator.of(context).pop();
            }
          },
          child: MessageField(
              fieldKey: fieldKey,
              send: () {
                context.read<MessageBloc>().add(MessageEventUpdateMessage(
                    messageId: id,
                    updatedMessage: fieldKey.currentState?.value));
              },
              onChanged: (val) {}),
        ),
        const Gap(10),
      ],
    ),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
