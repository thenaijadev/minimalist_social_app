import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minimalist_social_app/features/home/presentation/widgets/nav_bar_item.dart';

BottomNavigationBar bottomNavigationBar(
    {required void Function(int) onTap,
    required theme,
    required int selectedIndex}) {
  return BottomNavigationBar(
    selectedItemColor: theme.inversePrimary,
    onTap: onTap,
    items: [
      navbarItem(
          width: selectedIndex == 0 ? 100 : 0,
          theme: theme,
          color: selectedIndex == 0 ? theme.secondary : Colors.transparent,
          icon: CupertinoIcons.home,
          label: "Home"),
      navbarItem(
          width: selectedIndex == 1 ? 100 : 0,
          theme: theme,
          color: selectedIndex == 1 ? theme.secondary : Colors.transparent,
          icon: CupertinoIcons.profile_circled,
          label: "Profile"),
      navbarItem(
          width: selectedIndex == 2 ? 100 : 0,
          theme: theme,
          color: selectedIndex == 2 ? theme.secondary : Colors.transparent,
          icon: CupertinoIcons.settings,
          label: "Settings")
    ],
  );
}
