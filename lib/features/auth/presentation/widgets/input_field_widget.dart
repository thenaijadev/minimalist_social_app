import 'package:flutter/material.dart';
import 'package:minimalist_social_app/core/widgets/text_widget.dart';

class InputFieldWidget extends StatelessWidget {
  const InputFieldWidget(
      {super.key,
      required this.label,
      required this.hintColor,
      this.initialValue,
      required this.hintText,
      this.hintSize = 14,
      required this.onChanged,
      this.validator,
      required this.textFieldkey,
      this.obscureText = false,
      this.suffixIcon,
      this.prefixicon,
      this.padding = const EdgeInsets.only(bottom: 10),
      this.onTap,
      this.maxLines = 1,
      this.fontWeight = FontWeight.w600,
      this.labelFontSize = 16,
      this.enabledBorderRadius = 30,
      this.verticalContentPadding = 20,
      this.controller});
  final String label;
  final String hintText;
  final double hintSize;
  final void Function(String?) onChanged;
  final void Function()? onTap;

  final String? Function(String?)? validator;
  final GlobalKey<FormFieldState> textFieldkey;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixicon;
  final String? initialValue;
  final EdgeInsetsGeometry padding;
  final int? maxLines;
  final double enabledBorderRadius;
  final double verticalContentPadding;
  final FontWeight fontWeight;
  final Color hintColor;
  final double labelFontSize;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 15),
      child: SizedBox(
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: padding,
            child: TextWidget(
              text: label,
              color: Theme.of(context).colorScheme.inversePrimary,
              fontWeight: fontWeight,
              fontSize: labelFontSize,
            ),
          ),
          TextFormField(
            controller: controller,
            onTap: onTap,
            key: textFieldkey,
            initialValue: initialValue,
            onChanged: onChanged,
            maxLines: maxLines,
            validator: validator,
            obscureText: obscureText,
            decoration: InputDecoration(
              prefixIcon: prefixicon,
              suffixIcon: suffixIcon,
              hintStyle: TextStyle(
                  color: hintColor,
                  fontSize: hintSize,
                  fontFamily: 'Neue Plak'),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 24, vertical: verticalContentPadding),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 255, 0, 0),
                  width: 2.0,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 255, 0, 0),
                  width: 2.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  width: 2.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondary, width: 1),
                borderRadius: BorderRadius.circular(enabledBorderRadius),
              ),
              hintText: hintText,
            ),
          ),
        ]),
      ),
    );
  }
}
