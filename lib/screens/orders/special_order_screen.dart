import 'package:flutter/material.dart';
import 'package:krishajdealer/screens/sidebar/sidebar_drawer.dart';
class SpecialOrderScreen extends StatelessWidget {
  const SpecialOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Special Order')),
            drawer: const DrawerWidget(  ),
      body: const Center(child: Text('Special Order Screen')),
    );
  }
}