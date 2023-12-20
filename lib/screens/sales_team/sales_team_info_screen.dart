import 'package:flutter/material.dart';
import 'package:krishajdealer/screens/sidebar/sidebar_drawer.dart';
// Placeholder classes for the screens
class SalesTeamInfoScreen extends StatelessWidget {
  const SalesTeamInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sales Team Info')),
      drawer: const DrawerWidget(  ),
      body: const Center(child: Text('Sales Team Info Screen')),
    );
  }
}