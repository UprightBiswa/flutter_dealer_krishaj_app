import 'package:flutter/material.dart';
import 'package:krishajdealer/screens/sidebar/sidebar_drawer.dart';
class AgingReportBillWiseScreen extends StatelessWidget {
  const AgingReportBillWiseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aging Report Bill Wise')),
            drawer: const DrawerWidget(  ),
      body: const Center(child: Text('Aging Report Bill Wise Screen')),
    );
  }
}