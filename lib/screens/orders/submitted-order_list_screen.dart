
import 'package:flutter/material.dart';
import 'package:krishajdealer/screens/sidebar/sidebar_drawer.dart';
class SubmittedOrderListScreen extends StatelessWidget {
  const SubmittedOrderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Submitted Order List')),
      drawer: const DrawerWidget(  ),
      body: const Center(child: Text('Submitted Order List Screen')),
    );
  }
}