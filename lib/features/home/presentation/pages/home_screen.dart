import 'package:flutter/material.dart';
import 'package:minimalist_social_app/core/widgets/text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const Center(child: Text('Home Page')),
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
      body: _pages[_selectedIndex],
      backgroundColor: theme.background,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: theme.inversePrimary,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            label: "",
            icon: AnimatedContainer(
              padding:
                  EdgeInsets.symmetric(vertical: _selectedIndex == 0 ? 3 : 0),
              width: _selectedIndex == 0 ? 100 : 0,
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: _selectedIndex == 0
                      ? theme.secondary
                      : Colors.transparent),
              child: Column(
                children: [
                  Icon(
                    Icons.home_rounded,
                    color: theme.inversePrimary,
                  ),
                  const TextWidget(text: "Home")
                ],
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: AnimatedContainer(
              padding:
                  EdgeInsets.symmetric(vertical: _selectedIndex == 1 ? 3 : 0),
              width: _selectedIndex == 1 ? 100 : 0,
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: _selectedIndex == 1
                      ? theme.secondary
                      : Colors.transparent),
              child: Column(
                children: [
                  Icon(
                    Icons.home_rounded,
                    color: theme.inversePrimary,
                  ),
                  const TextWidget(text: "Home")
                ],
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: AnimatedContainer(
              padding:
                  EdgeInsets.symmetric(vertical: _selectedIndex == 2 ? 3 : 0),
              width: _selectedIndex == 2 ? 100 : 0,
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: _selectedIndex == 2
                      ? theme.secondary
                      : Colors.transparent),
              child: Column(
                children: [
                  Icon(
                    Icons.settings,
                    color: theme.inversePrimary,
                  ),
                  const TextWidget(text: "Settings")
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
