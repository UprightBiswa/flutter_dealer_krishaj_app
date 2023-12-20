import 'package:flutter/material.dart';
import 'package:krishajdealer/screens/dispatch_order/dispatch_order_details_screen.dart';
import 'package:krishajdealer/screens/ledger/ledger_screen.dart';
import 'package:krishajdealer/screens/orders/order_placement_screen.dart';
import 'package:krishajdealer/screens/orders/special_order_screen.dart';
import 'package:krishajdealer/screens/orders/submitted-order_list_screen.dart';
import 'package:krishajdealer/screens/reports/aging-report_screen.dart';
import 'package:krishajdealer/screens/reports/aging_report_bill_wise_screen.dart';
import 'package:krishajdealer/screens/reports/credit_note_details_screen.dart';
import 'package:krishajdealer/screens/reports/material_requirment_planning_screen.dart';
import 'package:krishajdealer/screens/reports/mrp_vs_order_placement_report_screen.dart';
import 'package:krishajdealer/screens/reports/order_placement_through_mrp_screen.dart';
import 'package:krishajdealer/screens/reports/product_wise_sales_report_screen.dart';
import 'package:krishajdealer/screens/sales_team/sales_team_info_screen.dart';

class Section {
  final String name;
  final String imagePath;
  final Widget screen;

  Section({
    required this.name,
    required this.imagePath,
    required this.screen,
  });
}

class HomeWidget extends StatelessWidget {
  final List<Section> sections = [
    Section(
      name: 'Sales Team',
      imagePath: 'assets/images/logo.png',
      screen: const SalesTeamInfoScreen(),
    ),
    Section(
      name: 'Orders Placement',
      imagePath: 'assets/images/logo.png',
      screen: const OrderPlacementScreen(),
    ),
    Section(
      name: 'Orders',
      imagePath: 'assets/images/logo.png',
      screen: const SubmittedOrderListScreen(),
    ),
    Section(
      name: 'Ledger',
      imagePath: 'assets/images/logo.png',
      screen: const LedgerScreen(),
    ),
    Section(
      name: 'Dispatch Order',
      imagePath: 'assets/images/logo.png',
      screen: const DispatchOrderDetailsScreen(),
    ),
    Section(
      name: 'Reports',
      imagePath: 'assets/images/logo.png',
      screen: const ProductWiseSalesReportScreen(),
    ),
    Section(
      name: 'Special Order',
      imagePath: 'assets/images/logo.png',
      screen: const SpecialOrderScreen(),
    ),
    Section(
      name: 'Credit Note Detail',
      imagePath: 'assets/images/logo.png',
      screen: const CreditNoteDetailScreen(),
    ),
    Section(
      name: 'Aging Report',
      imagePath: 'assets/images/logo.png',
      screen: const AgingReportScreen(),
    ),
    Section(
      name: 'Aging Report Bill Wise',
      imagePath: 'assets/images/logo.png',
      screen: const AgingReportBillWiseScreen(),
    ),
    Section(
      name: 'Material Requirement Planning',
      imagePath: 'assets/images/logo.png',
      screen: const MaterialRequirementPlanningScreen(),
    ),
    Section(
      name: 'Order Placement Through MRP',
      imagePath: 'assets/images/logo.png',
      screen: const OrderPlacementThroughMRPScreen(),
    ),
    Section(
      name: 'MRP vs Order Placement Report',
      imagePath: 'assets/images/logo.png',
      screen: const MRPvsOrderPlacementReportScreen(),
    ),
  ];

  HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Build your grid here using the sections
    // Each section can be displayed with an image, name, and onTap functionality
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: sections.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => sections[index].screen),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.grey[200],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    sections[index].imagePath,
                    height: 64,
                    width: 64,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    sections[index].name,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
