import 'package:flutter/material.dart';
import 'package:krishajdealer/screens/customBottomBar/customBottomBar.dart';
import 'package:krishajdealer/screens/dispatch_order/dispatch_order_details_screen.dart';
import 'package:krishajdealer/screens/ledger/ledger_screen.dart';
import 'package:krishajdealer/screens/orders/special_order_screen.dart';
import 'package:krishajdealer/screens/orders/submitted_order_list_page.dart';
import 'package:krishajdealer/screens/reports/aging-report_screen.dart';
import 'package:krishajdealer/screens/reports/aging_report_bill_wise_screen.dart';
import 'package:krishajdealer/screens/reports/credit_note_details_screen.dart';
import 'package:krishajdealer/screens/reports/material_requirment_planning_screen.dart';
import 'package:krishajdealer/screens/reports/order_placement_through_mrp_screen.dart';
import 'package:krishajdealer/screens/reports/mrp_vs_order_placement_report_screen.dart';
import 'package:krishajdealer/screens/reports/product_wise_sales_report_screen.dart';
import 'package:krishajdealer/screens/sales_team/sales_team_info_screen.dart';
import 'package:krishajdealer/screens/support/complaint.dart';
import 'package:krishajdealer/screens/support/feedback.dart';
import 'package:krishajdealer/screens/support/helpscreen.dart';
import 'package:krishajdealer/screens/support/support.dart';
import 'package:krishajdealer/screens/support/videotutorial.dart';
import 'package:krishajdealer/utils/colors.dart';

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
      name: 'Submitted Order List',
      icon: Icons.shopping_bag,
      screen: const SubmittedOrderListPage(),
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
      name: 'Ageing Report',
      icon: Icons.access_time,
      screen: const AgingReportScreen(),
    ),
    Section(
      name: 'Ageing Report Bill Wise',
      icon: Icons.access_time,
      screen: const AgingReportBillWiseScreen(),
    ),
    Section(
      name: 'Demand Plan',
      icon: Icons.format_list_numbered,
      screen: const MaterialRequirementPlanningScreen(),
    ),
    Section(
      name: 'Order Placement Through Demand Plan',
      icon: Icons.note_add,
      screen: const OrderPlacementThroughMRPScreen(),
    ),
    Section(
      name: 'Demand Plan vs Order Placement Report',
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

  final List<Section> supportSections = [
    Section(
      name: 'Help',
      icon: Icons.help,
      screen: HelpScreen(),
    ),
    Section(
      name: 'Video Tutorial',
      icon: Icons.video_library,
      screen: VideoTutorialScreen(),
    ),
    Section(
      name: 'Feedback',
      icon: Icons.feedback,
      screen: FeedbackScreen(),
    ),
    Section(
      name: 'Complaint',
      icon: Icons.report_problem,
      screen: ComplaintScreen(),
    ),
    Section(
      name: 'Support',
      icon: Icons.support,
      screen: SupportScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        elevation: 16.0,
        shadowColor: AppColors.kOrange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green, Colors.lightGreen.withOpacity(0.5)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Circular Logo
                      Container(
                        width: 25.0,
                        height: 25.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 20.0,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      // Vendor Name
                      const Expanded(
                        child: Text(
                          'Welcome, Biswajit Das',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),

                  // Vendor Number
                  const Text(
                    'Business Partner Id: 1234',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black38,
                    ),
                  ),
                ],
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
                  fontSize: 16, // Adjust font size
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
            const Divider(
              height: 1,
            ),
            _buildGroup("Team Group", salesSections),
            const Divider(
              height: 1,
            ),
            _buildGroup("Order Group", orderSections),
            const Divider(
              height: 1,
            ),
            _buildGroup("Report Group", reportSections),
            const Divider(
              height: 1,
            ),
            _buildGroup("Other Group", otherSections),
            const Divider(
              height: 1,
            ),
            _buildGroup("Support group", supportSections)
          ],
        ),
      ),
    );
  }

  Widget _buildGroup(String groupName, List<Section> sections) {
    List<Widget> widgets = [];
    widgets.add(Container(
      padding:
          const EdgeInsets.only(left: 16, top: 8, bottom: 4), // Adjust padding
      child: Text(
        groupName,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14, // Adjust font size
        ),
      ),
    ));
    widgets.addAll(sections.map((section) {
      return ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16), // Adjust padding
        leading: Container(
          width: 30.0,
          height: 30.0,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.kPrimary, // Adjusted circle color
          ),
          child: Icon(
            section.icon, size: 18, // Adjust icon size
            color: Colors.white,
          ), // You can customize the icon color
        ),
        title: Text(
          section.name,
          style: TextStyle(
            fontWeight: _selectedTabIndex == sections.indexOf(section)
                ? FontWeight.bold
                : FontWeight.normal,
            fontSize: 16, // Adjust font size
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: widgets,
    );
  }
}
