import 'package:flutter/material.dart';
import 'package:krishajdealer/screens/sidebar/sidebar_drawer.dart';
class ProductWiseSalesReportScreen extends StatelessWidget {
  const ProductWiseSalesReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Wise Sales Report')),
            drawer: const DrawerWidget(  ),
      body: const Center(child: Text('Product Wise Sales Report Screen')),
    );
  }
}