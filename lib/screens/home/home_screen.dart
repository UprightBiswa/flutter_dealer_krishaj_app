import 'package:flutter/material.dart';
import 'package:krishajdealer/screens/dispatch_order/dispatch_order_details_screen.dart';
import 'package:krishajdealer/screens/ledger/ledger_screen.dart';
import 'package:krishajdealer/screens/orders/special_order_screen.dart';
import 'package:krishajdealer/screens/orders/submitted_order_list_page.dart';
import 'package:krishajdealer/screens/productspage/product_cart_page.dart';
import 'package:krishajdealer/screens/productspage/products_search_page.dart';
import 'package:krishajdealer/screens/reports/aging-report_screen.dart';
import 'package:krishajdealer/screens/reports/aging_report_bill_wise_screen.dart';
import 'package:krishajdealer/screens/reports/credit_note_details_screen.dart';
import 'package:krishajdealer/screens/reports/material_requirment_planning_screen.dart';
import 'package:krishajdealer/screens/reports/mrp_vs_order_placement_report_screen.dart';
import 'package:krishajdealer/screens/reports/order_placement_through_mrp_screen.dart';
import 'package:krishajdealer/screens/reports/product_wise_sales_report_screen.dart';
import 'package:krishajdealer/screens/sales_team/sales_team_info_screen.dart';
import 'package:krishajdealer/screens/support/complaint.dart';
import 'package:krishajdealer/screens/support/feedback.dart';
import 'package:krishajdealer/screens/support/helpscreen.dart';
import 'package:krishajdealer/screens/support/support.dart';
import 'package:krishajdealer/screens/support/videotutorial.dart';
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
    Section(
      name: 'Product Search',
      icon: Icons.search,
      screen: SearchPage(),
    ),
    Section(
      name: 'Submitted Order List',
      icon: Icons.shopping_bag,
      screen: const SubmittedOrderListPage(),
    ),
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
      name: 'Ageing Report',
      icon: Icons.hourglass_full,
      screen: const AgingReportScreen(),
    ),
    Section(
      name: 'Ageing Report Bill Wise',
      icon: Icons.hourglass_empty,
      screen: const AgingReportBillWiseScreen(),
    ),
    Section(
      name: 'Demand Plan',
      icon: Icons.build,
      screen: const MaterialRequirementPlanningScreen(),
    ),
    Section(
      name: 'Order Placement Through Demand Plan',
      icon: Icons.add_shopping_cart,
      screen: const OrderPlacementThroughMRPScreen(),
    ),
    Section(
      name: 'Demand Plan vs Order Placement Report',
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
                        text:
                            "Special offer is open from 1.12.2024 to 2.12.2024.",
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
            // Green Container
            Container(
              color: AppColors.kWhite, // Set the green color
              padding: const EdgeInsets.all(8.0), // Adjust padding as needed
              child: const Column(
                children: [
                  // Row with Vendor Name and Circular Logo
                  Row(
                    children: [
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
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
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

                      // Action Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // _buildActionButton(
                          //   Icons.group,
                          //   'Sales Team',
                          //   AppColors.kBackground,
                          //   AppColors.kOrange,
                          //   buttonWidth,
                          //   context,
                          //   const SalesTeamInfoScreen(),
                          // ),
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
                            Icons.shopping_cart,
                            'Cart',
                            AppColors.kBackground,
                            AppColors.klightgreen,
                            buttonWidthlow,
                            context,
                            const ShoppingCartPage(),
                          ),
                          _buildActionButton(
                            Icons.shopping_bag,
                            'Submitted Order List',
                            AppColors.kBackground,
                            AppColors.klightgreenmore,
                            buttonWidthlow,
                            context,
                            const SubmittedOrderListPage(),
                          ),
                          // _buildActionButton(
                          //   Icons.insert_chart,
                          //   'Reports',
                          //   AppColors.kBackground,
                          //   AppColors.kSecondary,
                          //   buttonWidth, // Adjust the width as needed
                          //   context,
                          //   const ProductWiseSalesReportScreen(),
                          // ),
                          _buildActionButton(
                            Icons.local_shipping,
                            'Dispatch Order',
                            AppColors.kBackground,
                            AppColors.klightgreenmoremore,
                            buttonWidth, // Adjust the width as needed
                            context,
                            const DispatchOrderDetailsScreen(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
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
                    'assets/images/bannerhome.jpg', // Replace with your image path
                width: width, // Set the desired width
                height: 150.0, // Set the desired height
                borderRadius:
                    12.0, // Optional: Set the border radius, default is 12.0
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchPage(),
                    ),
                  );
                },
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
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                                Icons.hourglass_full,
                                'Ageing Report',
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
                          const SizedBox(height: 16.0),

                          // Second Row of Action Buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                              _buildActionButton(
                                Icons.shopping_bag,
                                'Submitted Order List',
                                AppColors.kBackground,
                                AppColors.kPrimary,
                                buttonWidthlow,
                                context,
                                const SubmittedOrderListPage(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
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
                        colors: [AppColors.kLine, AppColors.kWhite],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              width: double.infinity,
              color: AppColors.kLine,
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
                            'Support ',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // First Row of Action Buttons
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildActionSupport(
                            Icons.help,
                            'Help',
                            Colors.white,
                            AppColors.kOrange,
                            buttonWidthlow,
                            context,
                            // Replace with your Help screen widget
                            HelpScreen(),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          _buildActionSupport(
                            Icons.video_library,
                            'Video Tutorial',
                            Colors.white,
                            Colors.red,
                            buttonWidthlow,
                            context,
                            // Replace with your Video Tutorial screen widget
                            VideoTutorialScreen(),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          _buildActionSupport(
                            Icons.feedback,
                            'Feedback',
                            Colors.white,
                            Colors.blueGrey,
                            buttonWidthlow,
                            context,
                            // Replace with your Feedback screen widget
                            FeedbackScreen(),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          _buildActionSupport(
                            Icons.report_problem,
                            'Complaint',
                            Colors.white,
                            AppColors.kPrimary,
                            buttonWidthlow,
                            context,
                            // Replace with your Complaint screen widget
                            ComplaintScreen(),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          _buildActionSupport(
                            Icons.support,
                            'Support',
                            Colors.white,
                            AppColors.kSecondary,
                            buttonWidthlow,
                            context,
                            // Replace with your Support screen widget
                            SupportScreen(),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 8.0),
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
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
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

  Widget _buildActionSupport(
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => destinationScreen),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12.5),
                border: Border.all(color: Colors.grey),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(10, 20),
                    blurRadius: 10,
                    spreadRadius: 0,
                    color: Colors.grey.withOpacity(.05),
                  ),
                ],
              ),
              child: Icon(icon,
                  color: iconColor, size: 30), // Adjust the size as needed
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
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
