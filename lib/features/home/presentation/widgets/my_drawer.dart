import 'package:flutter/material.dart';
import 'package:minimalist_social_app/core/widgets/text_widget.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const DrawerHeader(child: CircleAvatar()),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              title: TextWidget(
                text: "HOME",
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
              onTap: () => Navigator.pop(context),
            )
          ],
        ),
      ),
    );
  }
}
