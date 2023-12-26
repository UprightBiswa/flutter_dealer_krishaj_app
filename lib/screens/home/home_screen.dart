import 'package:flutter/material.dart';
import 'package:krishajdealer/screens/dispatch_order/dispatch_order_details_screen.dart';
import 'package:krishajdealer/screens/ledger/ledger_screen.dart';
import 'package:krishajdealer/screens/orders/order_placement_screen.dart';
import 'package:krishajdealer/screens/orders/special_order_screen.dart';
import 'package:krishajdealer/screens/productspage/products_search_page.dart';
import 'package:krishajdealer/screens/reports/aging-report_screen.dart';
import 'package:krishajdealer/screens/reports/aging_report_bill_wise_screen.dart';
import 'package:krishajdealer/screens/reports/credit_note_details_screen.dart';
import 'package:krishajdealer/screens/reports/material_requirment_planning_screen.dart';
import 'package:krishajdealer/screens/reports/mrp_vs_order_placement_report_screen.dart';
import 'package:krishajdealer/screens/reports/order_placement_through_mrp_screen.dart';
import 'package:krishajdealer/screens/reports/product_wise_sales_report_screen.dart';
import 'package:krishajdealer/screens/sales_team/sales_team_info_screen.dart';
import 'package:krishajdealer/utils/colors.dart';
import 'package:krishajdealer/widgets/custombanner/custombanner.dart';
import 'package:marquee/marquee.dart';

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

class HomeWidget extends StatelessWidget {
  final List<Section> sections = [
    Section(
      name: 'Sales Team',
      icon: Icons.people,
      screen: const SalesTeamInfoScreen(),
    ),
    // Section(
    //   name: 'Orders',
    //   icon: Icons.shopping_cart,
    //   screen: const SubmittedOrderListScreen(),
    // ),
    Section(
      name: 'Ledger',
      icon: Icons.account_balance_wallet,
      screen: const LedgerScreen(),
    ),
    Section(
      name: 'Dispatch Order',
      icon: Icons.local_shipping,
      screen: const DispatchOrderDetailsScreen(),
    ),
    Section(
      name: 'Reports',
      icon: Icons.insert_chart,
      screen: const ProductWiseSalesReportScreen(),
    ),
    Section(
      name: 'Special Order',
      icon: Icons.star,
      screen: const SpecialOrderScreen(),
    ),
    Section(
      name: 'Credit Note Detail',
      icon: Icons.description,
      screen: const CreditNoteDetailScreen(),
    ),
    Section(
      name: 'Aging Report',
      icon: Icons.hourglass_full,
      screen: const AgingReportScreen(),
    ),
    Section(
      name: 'Aging Report Bill Wise',
      icon: Icons.hourglass_empty,
      screen: const AgingReportBillWiseScreen(),
    ),
    Section(
      name: 'Material Requirement Planning',
      icon: Icons.build,
      screen: const MaterialRequirementPlanningScreen(),
    ),
    Section(
      name: 'Order Placement Through MRP',
      icon: Icons.add_shopping_cart,
      screen: const OrderPlacementThroughMRPScreen(),
    ),
    Section(
      name: 'MRP vs Order Placement Report',
      icon: Icons.compare_arrows,
      screen: const MRPvsOrderPlacementReportScreen(),
    ),
  ];
  HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 1.0;
    double buttonWidthlow = MediaQuery.of(context).size.width * 0.20;
    double buttonWidth =
        MediaQuery.of(context).size.width * 0.20; // 22% of screen width
    return Scaffold(
      backgroundColor: AppColors.kAppBackground,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Green Container
            Container(
              color: AppColors.kAppBackground, // Set the green color
              padding: const EdgeInsets.all(8.0), // Adjust padding as needed
              child: const Column(
                children: [
                  // Row with Vendor Name and Circular Logo
                  Row(
                    children: [
                      // Circular Logo (You can replace this with your logo)
                      // Container(
                      //   width: 25.0,
                      //   height: 25.0,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(
                      //         8.0), // Adjust the border radius for rounded corners
                      //     color: Colors.white, // Adjust the background color
                      //   ),
                      //   child: Icon(
                      //     Icons.person,
                      //     size: 20.0,
                      //     color: Colors.green, // Adjust the icon color
                      //   ),
                      // ),

                      // const SizedBox(width: 8.0), // Adjust spacing
                      // Vendor Name
                      Text(
                        'Business Partner: Biswajit Das', //business partner
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black, // Adjust text color
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0), // Adjust spacing

                  // Row with Vendor Number
                  Row(
                    children: [
                      // Vendor Number
                      Text(
                        'Business Id: 1234',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.black38, // Adjust text color
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Notification Bell and Marquee Container
            Container(
              color: AppColors.kPrimary, // Set the background color
              padding: const EdgeInsets.all(8.0), // Adjust padding as needed
              child: Row(
                children: [
                  // Notification Bell Icon
                  const Icon(
                    Icons.notifications,
                    color: Colors.white, // Adjust icon color
                    size: 20.0, // Adjust icon size
                  ),
                  const SizedBox(
                    width: 4.0, // Adjust spacing between icon and marquee
                  ),

                  // Marquee Widget
                  Expanded(
                    child: SizedBox(
                      height: 25.0, // Set a specific height or adjust as needed
                      child: Marquee(
                        text: 'Your Marquee Text Here',
                        style: const TextStyle(
                          color: Colors.white, // Adjust text color
                          fontWeight: FontWeight.w200,
                          fontSize: 14.0, // Adjust font size
                          fontFamily: 'Roboto', // Set your desired font family
                        ),
                        scrollAxis: Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        blankSpace: 20.0,
                        velocity: 100.0,
                        pauseAfterRound: const Duration(seconds: 1),
                        startPadding: 10.0,
                        accelerationDuration: const Duration(seconds: 1),
                        accelerationCurve: Curves.linear,
                        decelerationDuration: const Duration(milliseconds: 500),
                        decelerationCurve: Curves.easeOut,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            // Quick Access and Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  gradient: const LinearGradient(
                    colors: [AppColors.kLine, AppColors.kWhite],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment
                        .stretch, // Make the column stretch to the full width
                    children: [
                      // Quick Access
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: const Row(
                          children: [
                            SizedBox(width: 8.0),
                            Text(
                              'Quick Access',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16.0),

                      // Action Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildActionButton(
                            Icons.group,
                            'Sales Team',
                            AppColors.kBackground,
                            AppColors.kPrimary,
                            buttonWidth,
                            context,
                            const SalesTeamInfoScreen(),
                          ),
                          _buildActionButton(
                            Icons.search,
                            'Product Search',
                            AppColors.kBackground,
                            AppColors.kPrimary,
                            buttonWidth, // Adjust the width as needed
                            context,
                            const SearchPage(),
                          ),
                          _buildActionButton(
                            Icons.insert_chart,
                            'Reports',
                            AppColors.kBackground,
                            AppColors.kPrimary,
                            buttonWidth, // Adjust the width as needed
                            context,
                            const ProductWiseSalesReportScreen(),
                          ),
                          _buildActionButton(
                            Icons.local_shipping,
                            'Dispatch Order',
                            AppColors.kBackground,
                            AppColors.kPrimary,
                            buttonWidth, // Adjust the width as needed
                            context,
                            const DispatchOrderDetailsScreen(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CustomBanner(
                imagePath:
                    'assets/images/bannerhome.png', // Replace with your image path
                width: width, // Set the desired width
                height: 150.0, // Set the desired height
                borderRadius:
                    12.0, // Optional: Set the border radius, default is 12.0
              ),
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        gradient: const LinearGradient(colors: [
                          AppColors.kLine,
                          AppColors.kWhite
                        ]) // Adjust border radius
                        ),
                    // elevation: 2.0, // Add elevation for a card-like effect
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          // Move the Container inside the Card
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: const Row(
                              children: [
                                Text(
                                  'Sales ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // First Row of Action Buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildActionButton(
                                Icons.group,
                                'Sales Team',
                                AppColors.kBackground,
                                AppColors.kPrimary,
                                buttonWidthlow,
                                context,
                                const SalesTeamInfoScreen(),
                              ),
                              _buildActionButton(
                                Icons.note_add,
                                'Orders Placement',
                                AppColors.kBackground,
                                AppColors.kPrimary,
                                buttonWidthlow,
                                context,
                                const OrderPlacementScreen(),
                              ),
                              _buildActionButton(
                                Icons.hourglass_full,
                                'Aging Report',
                                AppColors.kBackground,
                                AppColors.kPrimary,
                                buttonWidthlow,
                                context,
                                const AgingReportScreen(),
                              ),
                              _buildActionButton(
                                Icons.local_shipping,
                                'Dispatch Order',
                                AppColors.kBackground,
                                AppColors.kPrimary,
                                buttonWidthlow,
                                context,
                                const DispatchOrderDetailsScreen(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),

                          // Second Row of Action Buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildActionButton(
                                Icons.star,
                                'Special Order',
                                AppColors.kBackground,
                                AppColors.kPrimary,
                                buttonWidthlow,
                                context,
                                const SpecialOrderScreen(),
                              ),
                              _buildActionButton(
                                Icons.insert_chart,
                                'Reports',
                                AppColors.kBackground,
                                AppColors.kPrimary,
                                buttonWidthlow,
                                context,
                                const ProductWiseSalesReportScreen(),
                              ),
                              // Add more action buttons as needed
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        gradient: const LinearGradient(
                            colors: [AppColors.kLine, AppColors.kWhite])),
                    //elevation: 2.0,

                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: const Row(
                              children: [
                                Text(
                                  'All ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Action Buttons based on sections list, 4 buttons per row
                          for (int i = 0; i < sections.length; i += 4)
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for (int j = i;
                                        j < i + 4 && j < sections.length;
                                        j++)
                                      _buildActionButton(
                                        sections[j]
                                            .icon, // Replace with your desired default icon
                                        sections[j].name,
                                        AppColors.kBackground,
                                        AppColors.kPrimary,
                                        buttonWidthlow,
                                        context,
                                        sections[j].screen,
                                      ),
                                  ],
                                ),
                                const SizedBox(
                                    height: 16.0), // Add space between rows
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    IconData icon,
    String text,
    Color iconColor,
    Color bgColor,
    double width,
    BuildContext context,
    Widget destinationScreen,
  ) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.center, // Align items in the center
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => destinationScreen),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: bgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w100,
              // fontFamily: AutofillHints.addressCity,
              fontSize: 12.0,
              fontStyle: FontStyle.normal,
            ),
            textAlign: TextAlign.center,
            // Align text in the center
          ),
        ],
      ),
    );
  }
}
