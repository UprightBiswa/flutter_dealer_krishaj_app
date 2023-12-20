import 'package:flutter/material.dart';
import 'package:krishajdealer/screens/customBottomBar/customBottomBar.dart';
import 'package:krishajdealer/screens/dispatch_order/dispatch_order_details_screen.dart';
import 'package:krishajdealer/screens/ledger/ledger_screen.dart';
import 'package:krishajdealer/screens/orders/order_placement_screen.dart';
import 'package:krishajdealer/screens/orders/special_order_screen.dart';
import 'package:krishajdealer/screens/orders/submitted-order_list_screen.dart';
import 'package:krishajdealer/screens/reports/aging-report_screen.dart';
import 'package:krishajdealer/screens/reports/aging_report_bill_wise_screen.dart';
import 'package:krishajdealer/screens/reports/credit_note_details_screen.dart';
import 'package:krishajdealer/screens/reports/material_requirment_planning_screen.dart';
import 'package:krishajdealer/screens/reports/order_placement_through_mrp_screen.dart';
import 'package:krishajdealer/screens/reports/mrp_vs_order_placement_report_screen.dart';
import 'package:krishajdealer/screens/reports/product_wise_sales_report_screen.dart';
import 'package:krishajdealer/screens/sales_team/sales_team_info_screen.dart';

class Section {
  final String name;
  final IconData icon;
  final Widget screen;

  Section({
    required this.name,
    required this.icon,
    required this.screen,
  });
}

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  int _selectedTabIndex = -1;

  final List<Section> salesSections = [
    Section(
      name: 'Sales Team',
      icon: Icons.people,
      screen: const SalesTeamInfoScreen(),
    ),
  ];
  final List<Section> orderSections = [
    Section(
      name: 'Orders',
      icon: Icons.shopping_cart,
      screen: const SubmittedOrderListScreen(),
    ),
    Section(
      name: 'Orders Placement',
      icon: Icons.note_add,
      screen: const OrderPlacementScreen(),
    ),
    Section(
      name: 'Dispatch Order',
      icon: Icons.local_shipping,
      screen: const DispatchOrderDetailsScreen(),
    ),
    Section(
      name: 'Special Order',
      icon: Icons.star,
      screen: const SpecialOrderScreen(),
    ),
  ];

  final List<Section> reportSections = [
    Section(
      name: 'Product Wise Sales Report',
      icon: Icons.analytics,
      screen: const ProductWiseSalesReportScreen(),
    ),
    Section(
      name: 'Credit Note Detail',
      icon: Icons.receipt,
      screen: const CreditNoteDetailScreen(),
    ),
    Section(
      name: 'Aging Report',
      icon: Icons.access_time,
      screen: const AgingReportScreen(),
    ),
    Section(
      name: 'Aging Report Bill Wise',
      icon: Icons.access_time,
      screen: const AgingReportBillWiseScreen(),
    ),
    Section(
      name: 'Material Requirement Planning',
      icon: Icons.format_list_numbered,
      screen: const MaterialRequirementPlanningScreen(),
    ),
    Section(
      name: 'Order Placement Through MRP',
      icon: Icons.note_add,
      screen: const OrderPlacementThroughMRPScreen(),
    ),
    Section(
      name: 'MRP vs Order Placement Report',
      icon: Icons.analytics,
      screen: const MRPvsOrderPlacementReportScreen(),
    ),
  ];

  final List<Section> otherSections = [
    Section(
      name: 'Ledger',
      icon: Icons.account_balance_wallet,
      screen: const LedgerScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Text(
              'Welcome, DealerName',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text(
              'Home',
              style: TextStyle(
                fontWeight: _selectedTabIndex == -1
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
            onTap: () {
              setState(() {
                _selectedTabIndex = -1;
              });
              Navigator.pop(context);
              // Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const CustomBottomNavigationBar(),
                ),
              );
            },
          ),
          const Divider(),
          _buildGroup("Team Group", salesSections),
          const Divider(),
          _buildGroup("Order Group", orderSections),
          const Divider(),
          _buildGroup("Report Group", reportSections),
          const Divider(),
          _buildGroup("Other Group", otherSections),
          const Divider(),
        ],
      ),
    );
  }

  Widget _buildGroup(String groupName, List<Section> sections) {
    List<Widget> widgets = [];
    widgets.add(ListTile(
      title: Text(
        groupName,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ));
    widgets.addAll(sections.map((section) {
      return ListTile(
        leading: Icon(section.icon),
        title: Text(
          section.name,
          style: TextStyle(
            fontWeight: _selectedTabIndex == sections.indexOf(section)
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
        onTap: () {
          setState(() {
            _selectedTabIndex = sections.indexOf(section);
          });
          Navigator.pop(context);
          // Navigator.pushReplacement(
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => section.screen,
            ),
          );
        },
      );
    }));
    return Column(
      children: widgets,
    );
  }
}
