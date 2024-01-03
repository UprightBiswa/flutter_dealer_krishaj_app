import 'package:flutter/material.dart';
import 'package:krishajdealer/utils/assets.dart';
import 'package:krishajdealer/utils/colors.dart';
import 'package:marquee/marquee.dart';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({super.key});

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
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
  // Initially show 2 items in the list
  int itemCountToShow = 2;
  // List of announcements
  List<String> announcements = [
    'Your first announcement here Your first announcement here Your first announcement here',
    'Your second announcement here',
    'Your third announcement here',
    'Your fourth announcement here',
    'Your fifth announcement here',
    'Your third announcement here',
    'Your fourth announcement here',
    'Your fifth announcement here',
    'Your third announcement here',
    'Your fourth announcement here',
    'Your fifth announcement here',
  ];
  @override
  Widget build(BuildContext context) {
    var mediaQueryHeight = MediaQuery.of(context).size.height;
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
                            "Your ledger has not confirm. Your dispatch has not confirmed. Special offer is open from 1.12.2023 to 2.12.2023. Price going to be change from…….",
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                height: mediaQueryHeight / 6,
                decoration: BoxDecoration(
                  color: AppColors.kWhite,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.green.withOpacity(0.1),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.greenAccent.withOpacity(0.05),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Replace 'gold' with the actual club category from your data
                          Text(
                            'Club gold',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber,
                            ),
                          ),
                          SizedBox(width: 8.0),
                          // Dynamically load image based on the category
                          Image.asset(
                            getCategoryImage(
                                'gold'), // Pass the actual category
                            width: 100,
                            height: 100,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8.0),

            // Announcement Container
            Container(
              padding: const EdgeInsets.all(16.0),
              color: AppColors.kWhite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Announcements',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Show more/less button
                      TextButton(
                        onPressed: () {
                          // Handle the see more/less button press to toggle the list
                          setState(() {
                            itemCountToShow =
                                itemCountToShow == 2 ? announcements.length : 2;
                          });
                        },
                        child: Text(
                          itemCountToShow == 2 ? 'See more' : 'See less',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  // Use a ListView.builder to dynamically build the list
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: itemCountToShow,
                    itemBuilder: (context, index) {
                      return AnnouncementItem(
                        index: index + 1,
                        text: announcements[index],
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}

class AnnouncementItem extends StatelessWidget {
  final int index;
  final String text;

  const AnnouncementItem({Key? key, required this.index, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$index. $text',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8.0),
      ],
    );
  }
}
