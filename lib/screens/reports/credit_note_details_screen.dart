import 'package:flutter/material.dart';
import 'package:krishajdealer/screens/sidebar/sidebar_drawer.dart';
class CreditNoteDetailScreen extends StatelessWidget {
  const CreditNoteDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Credit Note Detail')),
            drawer: const DrawerWidget(  ),
      body: const Center(child: Text('Credit Note Detail Screen')),
    );
  }
}