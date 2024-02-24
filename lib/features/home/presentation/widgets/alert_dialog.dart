import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimalist_social_app/features/home/presentation/bloc/message_bloc.dart';
import 'package:minimalist_social_app/features/home/presentation/widgets/alert_button.dart';

showAlertDialog(BuildContext context, String message, String id) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(message),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // AlertButton(
        //   label: "Edit",
        //   onPressed: () {},
        // ),
        // const Gap(10),
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
