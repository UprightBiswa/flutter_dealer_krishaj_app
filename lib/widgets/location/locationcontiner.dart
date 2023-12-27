import 'package:flutter/material.dart';
import 'package:krishajdealer/screens/locationsearch/locationsearchpage.dart';
import 'package:krishajdealer/utils/colors.dart';

class TappableContainer extends StatefulWidget {
  final String username;

  const TappableContainer({Key? key, required this.username}) : super(key: key);

  @override
  _TappableContainerState createState() => _TappableContainerState();
}

class _TappableContainerState extends State<TappableContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.kPrimary.withOpacity(0.5),
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          // Navigate to the new page when tapped
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LocationSearchPage(),
            ),
          );
        },
        child: Row(
          children: [
            const Icon(
              Icons.pin_drop,
              color: Colors.white,
              size: 20.0,
            ),
            const SizedBox(
              width: 4.0,
            ),
            Expanded(
              child: SizedBox(
                height: 25.0,
                child: Text(
                  'Delivery to ${widget.username} - location', // Use the provided username
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
