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
                            "Your ledger has not confirm. Your dispatch has not confirmed.",
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
            Container(
              height: 140,
              color: AppColors.kWhite,
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  // CircleAvatar aligned to top left
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
                      radius: 50,
                      backgroundColor: Colors.green.withOpacity(0.1),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.green.withOpacity(0.1),
                    ),
                  ),

                  // Row containing text and image
                  Row(
                    children: [
                      // First child in the row
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text: 'Business Partner'
                            Text(
                              'Business Partner: Biswajit Das',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(height: 8.0), // Adjust spacing

                            // Text: 'Business Id' and 'Club gold'
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

                      // Second child in the row
                      Image.asset(
                        getCategoryImage('gold'), // Pass the actual category
                        width: 100,
                        height: 100,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8.0),
            // Announcement Container
            Container(
              color: AppColors.kWhite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
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
                              itemCountToShow = itemCountToShow == 2
                                  ? announcements.length
                                  : 2;
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
                  ),

                  // Use a ListView.builder to dynamically build the list
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: itemCountToShow,
                    itemBuilder: (context, index) {
                      return AnnouncementItem(
                        index: index + 1,
                        text: announcements[index],
                        date: '2022-01-01',
                      );
                    },
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnnouncementItem extends StatelessWidget {
  final int index;
  final String text;
  final String date;

  const AnnouncementItem({
    Key? key,
    required this.index,
    required this.text,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: index.isEven
                ? Colors.greenAccent.withOpacity(.2)
                : Colors.blueAccent.withOpacity(.2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$index. $text',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Date: $date',
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
