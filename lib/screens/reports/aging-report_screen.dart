import 'package:flutter/material.dart';
import 'package:krishajdealer/screens/sidebar/sidebar_drawer.dart';
class AgingReportScreen extends StatelessWidget {
  const AgingReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ageing Report')),
            drawer: const DrawerWidget(  ),
      body: const Center(child: Text('Ageing Report Screen')),
    );
  }
}