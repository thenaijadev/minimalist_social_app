import 'package:flutter/material.dart';
import 'package:minimalist_social_app/core/widgets/text_widget.dart';

BottomNavigationBarItem navbarItem(
    {required double width,
    required Color color,
    required theme,
    required IconData icon,
    required String label}) {
  return BottomNavigationBarItem(
    label: "",
    icon: AnimatedContainer(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 10),
      duration: const Duration(milliseconds: 300),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(20), color: color),
      child: Column(
        children: [
          Icon(
            icon,
            color: theme.inversePrimary,
          ),
          TextWidget(
            text: label,
            fontSize: 15,
            color: theme.inversePrimary,
          )
        ],
      ),
    ),
  );
}
