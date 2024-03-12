import 'package:flutter/material.dart';
import 'package:minimalist_social_app/features/home/presentation/widgets/bottom_nav_bar.dart';
import 'package:minimalist_social_app/features/home/presentation/widgets/home_screen_widget.dart';
import 'package:minimalist_social_app/features/home/presentation/widgets/my_drawer.dart';

import '../widgets/app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreenWidget(),
    const Center(child: Text('Settings Page')),
    const Center(child: Text('Profile Page')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
        appBar: appBar(theme: theme, title: "Chats"),
        drawer: const MyDrawer(),
        body: _pages[_selectedIndex],
        backgroundColor: theme.background,
        bottomNavigationBar: bottomNavigationBar(
            onTap: _onItemTapped, theme: theme, selectedIndex: _selectedIndex));
  }
}
