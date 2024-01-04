import 'package:flutter/material.dart';
import 'package:krishajdealer/screens/customBottomBar/customBottomBar.dart';
import 'package:krishajdealer/screens/productspage/products_search_page.dart';

class OrderSuccessScreen extends StatelessWidget {
  final String orderId;

  const OrderSuccessScreen({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Navigate to the homepage when the back button is pressed
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => CustomBottomNavigationBar(),
          ),
          (route) => false,
        );

        // Return true to allow the back button press
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Order Success'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Green circle with check icon
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 50,
                ),
              ),
              const SizedBox(height: 16.0),
              // Thank you message
              Text(
                'Thank you for your purchase!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8.0),
              // Order confirmation text
              Text(
                'You will receive an order confirmation\nwith details of your order.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              // Order ID
              Text(
                'Order ID: #$orderId',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              // Continue shopping button
              ElevatedButton(
                onPressed: () {
                  // Navigate to the SearchPage and remove all previous routes
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchPage(),
                    ),
                    (route) => false,
                  );
                },
                child: Text('Continue Shopping'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
