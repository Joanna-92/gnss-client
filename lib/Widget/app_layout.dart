import 'custom_drawer.dart';
import 'package:flutter/material.dart';

class AppLayout extends StatelessWidget {
  final Widget child;
  final String? title;

  const AppLayout({super.key, required this.child, this.title});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: FittedBox(
            child: Text(
              title ?? "GNSS Logger",
              style: TextStyle(color: Colors.black, fontSize: 36),
            ),
          ),
        ),
        drawer: const CustomDrawer(),
        body: Center(child: child),
      ),
    );
  }
}
