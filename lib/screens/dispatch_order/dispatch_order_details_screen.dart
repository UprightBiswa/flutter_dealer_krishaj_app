import 'package:flutter/material.dart';
import 'package:krishajdealer/screens/sidebar/sidebar_drawer.dart';
class DispatchOrderDetailsScreen extends StatelessWidget {
  const DispatchOrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dispatch Order Details')),
            drawer: const DrawerWidget(  ),
      body: const Center(child: Text('Dispatch Order Details Screen')),
    );
  }
}