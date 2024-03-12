import 'package:flutter/material.dart';
import 'package:minimalist_social_app/core/widgets/dark_mode_switch.dart';
import 'package:minimalist_social_app/core/widgets/text_widget.dart';

AppBar appBar({required theme, required String title}) {
  return AppBar(
    centerTitle: true,
    actions: const [
      DarkModeSwitch(),
    ],
    backgroundColor: theme.background,
    title: TextWidget(
      text: title,
      fontWeight: FontWeight.bold,
      color: theme.inversePrimary,
    ),
  );
}
