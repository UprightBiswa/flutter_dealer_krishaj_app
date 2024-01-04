import 'package:flutter/material.dart';
import 'package:krishajdealer/screens/sidebar/sidebar_drawer.dart';
class MRPvsOrderPlacementReportScreen extends StatelessWidget {
  const MRPvsOrderPlacementReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Demand Plan vs Order Placement Report')),
            drawer: const DrawerWidget(  ),
      body: const Center(child: Text('Demand Plan vs Order Placement Report Screen')),
    );
  }
}
