import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
      {super.key,
      required this.text,
      this.fontSize = 16,
      this.fontWeight = FontWeight.normal,
      this.color = AppColors.black,
      this.textAlign,
      this.overflow,
      this.onTap});
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final VoidCallback? onTap;
  final Color color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        textAlign: textAlign,
        overflow: overflow,
        style: GoogleFonts.poppins(
            color: color, fontSize: fontSize, fontWeight: fontWeight),
      ),
    );
  }
}
