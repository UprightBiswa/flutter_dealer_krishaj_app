import 'package:flutter/material.dart';
import 'package:krishajdealer/screens/sidebar/sidebar_drawer.dart';
class MaterialRequirementPlanningScreen extends StatelessWidget {
  const MaterialRequirementPlanningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Material Requirement Planning')),
            drawer: const DrawerWidget(  ),
      body: const Center(child: Text('Material Requirement Planning Screen')),
    );
  }
}