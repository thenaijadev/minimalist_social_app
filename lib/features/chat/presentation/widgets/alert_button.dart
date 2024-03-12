import 'package:flutter/material.dart';
import 'package:minimalist_social_app/core/widgets/text_widget.dart';

class AlertButton extends StatelessWidget {
  const AlertButton({super.key, required this.onPressed, required this.label});
  final void Function()? onPressed;
  final String label;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
          child: TextWidget(
            text: label,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
      ),
    );
  }
}
