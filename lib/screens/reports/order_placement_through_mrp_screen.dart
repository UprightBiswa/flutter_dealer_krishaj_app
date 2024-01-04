import 'package:flutter/material.dart';
import 'package:krishajdealer/screens/sidebar/sidebar_drawer.dart';
class OrderPlacementThroughMRPScreen extends StatelessWidget {
  const OrderPlacementThroughMRPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Placement Through Demand Plan')),
            drawer: const DrawerWidget(  ),
      body: const Center(child: Text('Order Placement Through Demand Plan Screen')),
    );
  }
}