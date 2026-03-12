import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.red),
            child: Text('Menu', style: TextStyle(fontSize: 40)),
          ),
          ListTile(
            title: const Text('Hole Koordinaten'),
            onTap: () {
              Navigator.pushNamed(context, '/SaveCoordinats'); // ...
            },
          ),
          ListTile(
            title: const Text('Sehe Sateliten und Rohdaten'),
            onTap: () {
              Navigator.pushNamed(context, '/Satelites');
            },
          ),
        ],
      ),
    );
  }
}
