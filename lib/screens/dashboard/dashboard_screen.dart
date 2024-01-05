// import 'package:flutter/material.dart';
// import 'package:krishajdealer/providers/Dashboard/announcement_provider.dart';
// import 'package:krishajdealer/services/api/announcement_model.dart';
// import 'package:krishajdealer/utils/assets.dart';
// import 'package:krishajdealer/utils/colors.dart';
// import 'package:marquee/marquee.dart';
// import 'package:fl_chart/fl_chart.dart';

// class DashboardWidget extends StatefulWidget {
//   const DashboardWidget({super.key});

//   @override
//   State<DashboardWidget> createState() => _DashboardWidgetState();
// }

// enum DashboardState {
//   Loading,
//   Data,
//   Error,
//   NoData,
// }

// String getCategoryImage(String category) {
//   switch (category) {
//     case 'gold':
//       return AppAssets.gold;
//     case 'silver':
//       return AppAssets.silver;
//     case 'bronze':
//       return AppAssets.bronze;
//     default:
//       return ''; // Provide a default image path or handle accordingly
//   }
// }

// class _DashboardWidgetState extends State<DashboardWidget> {
//   // Initially show 2 items in the list
//   int itemCountToShow = 2;
//   // List of announcements
//   List<String> announcementTexts = <String>[];
//   List<String> announcements = [];
//   DashboardState _dashboardState = DashboardState.Loading;
//   @override
//   void initState() {
//     super.initState();
//     _loadAnnouncements();
//   }

//   Future<void> _loadAnnouncements() async {
//     try {
//       AnnouncementModel announcementModel =
//           await AnnouncementProvider().getAnnouncements(context);
//       announcementTexts = announcementModel.message
//           .map((announcement) => announcement.announcement)
//           .toList();
//       _dashboardState =
//           announcements.isEmpty ? DashboardState.NoData : DashboardState.Data;
//     } catch (e) {
//       _dashboardState = DashboardState.Error;
//       // Handle errors
//     } finally {
//       setState(() {}); // Trigger a rebuild after getting the announcements
//     }
//   }

//   Widget _buildDashboardState(BuildContext context) {
//     switch (_dashboardState) {
//       case DashboardState.Loading:
//         return _buildLoadingState();
//       case DashboardState.Data:
//         return _buildDataState(context);
//       case DashboardState.Error:
//         return _buildErrorState();
//       case DashboardState.NoData:
//         return _buildNoDataState();
//       default:
//         return _buildLoadingState();
//     }
//   }

//   Widget _buildLoadingState() {
//     return Scaffold(
//       body: Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }

//   Widget _buildErrorState() {
//     return Scaffold(
//       body: Center(
//         child: Text('Error loading data. Please try again.'),
//       ),
//     );
//   }

//   Widget _buildNoDataState() {
//     return Scaffold(
//       body: Center(
//         child: Text('No announcements available.'),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _buildDashboardState( context);
//   }
// }

// Widget _buildDataState(BuildContext context) {
//   return Scaffold(
//     backgroundColor: AppColors.kAppBackground,
//     body: SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Notification Bell and Marquee Container
//           Container(
//             color: AppColors.kPrimary, // Set the background color
//             padding: const EdgeInsets.all(8.0), // Adjust padding as needed
//             child: Row(
//               children: [
//                 // Notification Bell Icon
//                 const Icon(
//                   Icons.notifications,
//                   color: Colors.white, // Adjust icon color
//                   size: 20.0, // Adjust icon size
//                 ),
//                 const SizedBox(
//                   width: 4.0, // Adjust spacing between icon and marquee
//                 ),

//                 // Marquee Widget
//                 Expanded(
//                   child: SizedBox(
//                     height: 25.0, // Set a specific height or adjust as needed
//                     child: Marquee(
//                       text:
//                           "Your ledger has not confirm. Your dispatch has not confirmed.",
//                       style: const TextStyle(
//                         color: Colors.white, // Adjust text color
//                         fontWeight: FontWeight.w200,
//                         fontSize: 14.0, // Adjust font size
//                         fontFamily: 'Roboto', // Set your desired font family
//                       ),
//                       scrollAxis: Axis.horizontal,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       blankSpace: 20.0,
//                       velocity: 100.0,
//                       pauseAfterRound: const Duration(seconds: 1),
//                       startPadding: 10.0,
//                       accelerationDuration: const Duration(seconds: 1),
//                       accelerationCurve: Curves.linear,
//                       decelerationDuration: const Duration(milliseconds: 500),
//                       decelerationCurve: Curves.easeOut,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 8.0),
//           Container(
//             height: 140,
//             color: AppColors.kWhite,
//             padding: const EdgeInsets.all(8.0),
//             child: Stack(
//               children: [
//                 // CircleAvatar aligned to top left
//                 Align(
//                   alignment: Alignment.topLeft,
//                   child: CircleAvatar(
//                     radius: 30,
//                     backgroundColor: Colors.green.withOpacity(0.1),
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.center,
//                   child: CircleAvatar(
//                     radius: 30,
//                     backgroundColor: Colors.green.withOpacity(0.1),
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.bottomRight,
//                   child: CircleAvatar(
//                     radius: 30,
//                     backgroundColor: Colors.green.withOpacity(0.1),
//                   ),
//                 ),

//                 // Row containing text and image
//                 Row(
//                   children: [
//                     // First child in the row
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Text: 'Business Partner'
//                           Flexible(
//                             child: Text(
//                               'Business Partner: Biswajit Das',
//                               style: TextStyle(
//                                 fontSize: 20.0,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w300,
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 8.0), // Adjust spacing

//                           // Text: 'Business Id' and 'Club gold'
//                           Text(
//                             'Business Id: 1234',
//                             style: TextStyle(
//                               fontSize: 12.0,
//                               color: Colors.black38,
//                             ),
//                           ),
//                           Text(
//                             'Club: Gold',
//                             style: TextStyle(
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.amber,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     // Second child in the row
//                     Image.asset(
//                       getCategoryImage('gold'), // Pass the actual category
//                       width: 100,
//                       height: 100,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 8.0),

//           // First Container (Sales Chart)
//           buildChartContainer(
//             title: 'Sales',
//             data: [
//               FlSpot(0, 0),
//               FlSpot(1, 105),
//               FlSpot(2, 100),
//               FlSpot(3, 21),
//               FlSpot(4, 20),
//               FlSpot(5, 1),
//               FlSpot(6, 1.25),
//             ],
//           ),
//           const SizedBox(height: 8.0),

//           // Second Container (Collection Chart)
//           buildChartContainer(
//             title: 'Collection',
//             data: [
//               FlSpot(0, 0),
//               FlSpot(1, 85),
//               FlSpot(2, 80),
//               FlSpot(3, 11),
//               FlSpot(4, 10),
//               FlSpot(5, 1),
//               FlSpot(6, 1.25),
//             ],
//           ),
//           const SizedBox(height: 8.0),
//           // Announcement Container
//           Container(
//             color: AppColors.kWhite,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ColoredBox(
//                   color: Colors.green.shade300,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Announcements',
//                           style: TextStyle(
//                             fontSize: 20.0,
//                             fontWeight: FontWeight.normal,
//                             color: Colors.white,
//                           ),
//                         ),
//                         // Show more/less button
//                         TextButton(
//                           onPressed: () {
//                             // Handle the see more/less button press to toggle the list
//                             setState(() {
//                               itemCountToShow = itemCountToShow == 2
//                                   ? announcementTexts.length
//                                   : 2;
//                             });
//                           },
//                           child: Text(
//                             itemCountToShow == 2 ? 'See more' : 'See less',
//                             style: TextStyle(
//                               fontSize: 14.0,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 // Use a ListView.builder to dynamically build the list
//                 ListView.builder(
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   itemCount: itemCountToShow,
//                   itemBuilder: (context, index) {
//                     return AnnouncementItem(
//                       index: index + 1,
//                       text: announcements[index],
//                       date: '2022-01-01',
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 8.0),
//         ],
//       ),
//     ),
//   );
// }

// Widget buildChartContainer(
//     {required String title, required List<FlSpot> data}) {
//   return Container(
//     padding: const EdgeInsets.all(8.0),
//     decoration: BoxDecoration(
//       color: Colors.white,
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: TextStyle(
//             fontSize: 20.0,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(height: 10),
//         Container(
//           height: 200, // Adjust the height as needed
//           child: LineChart(
//             LineChartData(
//               backgroundColor: Colors.blueAccent[100],
//               gridData: FlGridData(show: true),
//               titlesData: FlTitlesData(show: true),
//               borderData: FlBorderData(
//                 show: true,
//                 border: Border.all(color: Colors.black),
//               ),
//               minX: 0,
//               maxX: 6,
//               minY: 0,
//               maxY: 140,
//               lineBarsData: [
//                 LineChartBarData(
//                   spots: data,
//                   isCurved: true,
//                   color: Colors.green,
//                   belowBarData: BarAreaData(show: false),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

// class AnnouncementItem extends StatelessWidget {
//   final Announcement announcement;
//   const AnnouncementItem({
//     Key? key,
//     required this.announcement,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           width: double.infinity,
//           padding: const EdgeInsets.all(8.0),
//           decoration: BoxDecoration(
//             color: announcement.id.isEven
//                 ? Colors.greenAccent.withOpacity(.2)
//                 : Colors.blueAccent.withOpacity(.2),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 '${announcement.id}. ${announcement.announcement}',
//                 style: TextStyle(
//                   fontSize: 16.0,
//                   color: Colors.black,
//                 ),
//               ),
//               SizedBox(height: 4.0),
//               Text(
//                 'Date: ${announcement.createdAt}',
//                 style: TextStyle(
//                   fontSize: 12.0,
//                   color: Colors.black38,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: 0.0),
//         Divider(
//           color: Colors.grey,
//           height: 1.0,
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:marquee/marquee.dart';
import 'package:krishajdealer/providers/Dashboard/announcement_provider.dart';
import 'package:krishajdealer/services/api/announcement_model.dart';
import 'package:krishajdealer/utils/assets.dart';
import 'package:krishajdealer/utils/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({Key? key}) : super(key: key);

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

enum DashboardState {
  Loading,
  Data,
  Error,
  NoData,
}

String getCategoryImage(String category) {
  switch (category) {
    case 'gold':
      return AppAssets.gold;
    case 'silver':
      return AppAssets.silver;
    case 'bronze':
      return AppAssets.bronze;
    default:
      return ''; // Provide a default image path or handle accordingly
  }
}

class _DashboardWidgetState extends State<DashboardWidget> {
  int itemCountToShow = 2;
  List<String> announcementTexts = <String>[];
  List<String> announcements = [];
  DashboardState _dashboardState = DashboardState.Loading;

  @override
  void initState() {
    super.initState();
    _loadAnnouncements();
  }

  Future<void> _loadAnnouncements() async {
    try {
      setState(() {
        _dashboardState = DashboardState.Loading;
      });

      AnnouncementModel announcementModel =
          await AnnouncementProvider().getAnnouncements(context);

      setState(() {
        announcements = announcementModel.message
            .map((announcement) => announcement.announcement)
            .toList();
        _dashboardState =
            announcements.isEmpty ? DashboardState.NoData : DashboardState.Data;
      });
    } catch (e) {
      setState(() {
        _dashboardState = DashboardState.Error;
      });
    }
  }

  Widget _buildDashboardState(BuildContext context) {
    switch (_dashboardState) {
      case DashboardState.Loading:
        return _buildLoadingState();
      case DashboardState.Data:
        return _buildDataState(context);
      case DashboardState.Error:
        return _buildErrorState();
      case DashboardState.NoData:
        return _buildNoDataState();
      default:
        return _buildLoadingState();
    }
  }

  Widget _buildLoadingState() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildErrorState() {
    return Scaffold(
      body: Center(
        child: Text('Error loading data. Please try again.'),
      ),
    );
  }

  Widget _buildNoDataState() {
    return Scaffold(
      body: Center(
        child: Text('No announcements available.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildDashboardState(context);
  }

  Widget _buildDataState(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kAppBackground,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notification Bell and Marquee Container
            _buildNotificationWidget(),

            const SizedBox(height: 8.0),

            // Business Details Container
            _buildBusinessDetails(),

            const SizedBox(height: 8.0),

            // Sales Chart Container
            // buildChartContainer(
            //   title: 'Sales',
            //   data: [
            //     FlSpot(0, 0),
            //     FlSpot(1, 105),
            //     FlSpot(2, 100),
            //     FlSpot(3, 21),
            //     FlSpot(4, 20),
            //     FlSpot(5, 1),
            //     FlSpot(6, 1.25),
            //   ],
            // ),
            SalesComparisonChart(
              title1: 'Sales-Last Year YTD',
              title2: 'Sales-Curt Year YTD',
              data1: [FlSpot(0, 85)],
              data2: [FlSpot(0, 79)],
              year1: '2024',
              year2: '2023',
              color1: Colors.green,
              color2: Colors.red,
            ),

            SalesComparisonChart(
              title1: 'Sales-Last Year YTD',
              title2: 'Sales-Curt Year YTD',
              data1: [FlSpot(0, 47)],
              data2: [FlSpot(0, 39)],
              year1: '2024',
              year2: '2023',
              color1: Colors.green,
              color2: Colors.red,
            ),

            SalesComparisonChart(
              title1: 'Sales-Last Year YTD',
              title2: 'Sales-Curt Year YTD',
              data1: [FlSpot(0, 35)],
              data2: [FlSpot(0, 20)],
              year1: '2024',
              year2: '2023',
              color1: Colors.green,
              color2: Colors.red,
            ),
            const SizedBox(height: 8.0),

            // Collection Chart Container
            buildChartContainer(
              title: 'Collection',
              data: [
                FlSpot(0, 0),
                FlSpot(1, 85),
                FlSpot(2, 80),
                FlSpot(3, 11),
                FlSpot(4, 10),
                FlSpot(5, 1),
                FlSpot(6, 1.25),
              ],
            ),

            const SizedBox(height: 8.0),

            // Announcements Container
            _buildAnnouncements(),

            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationWidget() {
    return Container(
      color: AppColors.kPrimary,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Icon(
            Icons.notifications,
            color: Colors.white,
            size: 20.0,
          ),
          const SizedBox(
            width: 4.0,
          ),
          Expanded(
            child: SizedBox(
              height: 25.0,
              child: Marquee(
                text:
                    "Your ledger has not confirmed. Your dispatch has not confirmed.",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w200,
                  fontSize: 14.0,
                  fontFamily: 'Roboto',
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
    );
  }

  Widget _buildBusinessDetails() {
    return Container(
      height: 140,
      color: AppColors.kWhite,
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.green.withOpacity(0.1),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.green.withOpacity(0.1),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.green.withOpacity(0.1),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        'Business Partner: Biswajit Das',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Business Id: 1234',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.black38,
                      ),
                    ),
                    Text(
                      'Club: Gold',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(
                getCategoryImage('gold'),
                width: 100,
                height: 100,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnnouncements() {
    return Container(
      color: AppColors.kWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ColoredBox(
            color: Colors.green.shade300,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Announcements',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        itemCountToShow =
                            itemCountToShow == 2 ? announcementTexts.length : 2;
                      });
                    },
                    child: Text(
                      itemCountToShow == 2 ? 'See more' : 'See less',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: itemCountToShow,
            itemBuilder: (context, index) {
              return AnnouncementItem(
                announcement: Announcement(
                  id: index + 1,
                  announcement: announcements[index],
                  userId: '123', // Replace with actual user id
                  createdAt: '2022-01-01', // Replace with actual date
                  updatedAt: '2022-01-01', // Replace with actual date
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildChartContainer(
      {required String title, required List<FlSpot> data}) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 200,
            child: LineChart(
              LineChartData(
                backgroundColor: Colors.blueAccent[100],
                gridData: FlGridData(show: true),
                titlesData: FlTitlesData(show: true),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: Colors.black),
                ),
                minX: 0,
                maxX: 6,
                minY: 0,
                maxY: 140,
                lineBarsData: [
                  LineChartBarData(
                    spots: data,
                    isCurved: true,
                    color: Colors.green,
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnnouncementItem extends StatelessWidget {
  final Announcement announcement;
  const AnnouncementItem({
    Key? key,
    required this.announcement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: announcement.id.isEven
                ? Colors.greenAccent.withOpacity(.2)
                : Colors.blueAccent.withOpacity(.2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${announcement.id}. ${announcement.announcement}',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Date: ${announcement.createdAt}',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.black38,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 0.0),
        Divider(
          color: Colors.grey,
          height: 1.0,
        ),
      ],
    );
  }
}

class SalesComparisonChart extends StatelessWidget {
  final String title1;
  final String title2;
  final List<FlSpot> data1;
  final List<FlSpot> data2;
  final String year1;
  final String year2;
  final Color color1;
  final Color color2;

  SalesComparisonChart({
    required this.title1,
    required this.title2,
    required this.data1,
    required this.data2,
    required this.year1,
    required this.year2,
    required this.color1,
    required this.color2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title1,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 200,
            child: SfCartesianChart(
              series: <CartesianSeries>[
                BarSeries<FlSpot, String>(
                  dataSource: data1,
                  xValueMapper: (FlSpot spot, _) => year1,
                  yValueMapper: (FlSpot spot, _) => spot.y,
                  color: color1,
                  dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                  ),
                ),
                BarSeries<FlSpot, String>(
                  dataSource: data2,
                  xValueMapper: (FlSpot spot, _) => year2,
                  yValueMapper: (FlSpot spot, _) => spot.y,
                  color: color2,
                  dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                  ),
                ),
              ],
              primaryXAxis: CategoryAxis(),
              primaryYAxis: NumericAxis(),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
