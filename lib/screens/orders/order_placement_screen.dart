import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:krishajdealer/providers/authentication/auth_token.dart';
import 'package:krishajdealer/providers/productProvider/cartProvidercount.dart';
import 'package:krishajdealer/providers/productProvider/cartproductviewprovider.dart';
import 'package:krishajdealer/screens/orders/ordersuccess.dart';
import 'package:krishajdealer/utils/colors.dart';
import 'package:krishajdealer/widgets/common/custom_button.dart';
import 'package:krishajdealer/widgets/location/locationcontiner.dart';
import 'package:provider/provider.dart';

class OrderPlacementScreen extends StatelessWidget {
  final int totalProducts;
  final double totalPricesSum;
  const OrderPlacementScreen({
    Key? key,
    required this.totalProducts,
    required this.totalPricesSum,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kAppBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green, Colors.lightGreen.withOpacity(0.5)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        title: const Text(
          'Order Placement',
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TappableContainer(username: 'John'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Order now',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            // const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                  border: Border.all(color: Colors.black12),
                ),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text('Shipping to:'),
                          SizedBox(width: 8.0),
                          Text(
                            'Biswajit Das',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ), // Replace with the actual user name
                        ],
                      ),
                    ),
                    const Divider(
                      height: 0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Items:'),
                              SizedBox(width: 8.0),
                              Text(
                                  '$totalProducts'), // Replace with the actual item count
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Discount:', // Replace with the actual total price
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '\u20B9-0.00',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Order Total:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                '₹${totalPricesSum.toStringAsFixed(2)}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.green),
                              ), // Replace with the actual price
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8.0),
            _buildInformation(),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
      bottomSheet: Container(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            child: CustomButton(
              onPressed: () async {
                await _placeOrder(context);
              },
              text: 'Place your Order',
              icon: Icons.shopping_bag,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _placeOrder(BuildContext context) async {
    try {
      // Check for internet connectivity
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        // No internet connection, show a message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No internet connection. Please try again later.'),
            duration: Duration(seconds: 3),
          ),
        );
        return;
      }
      // Show loading indicator
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      String? token = await AuthState().getToken();
      double totalPricesSumAsDouble = double.parse(totalPricesSum.toString());
      print('₹${totalPricesSumAsDouble.toStringAsFixed(2)}');

      final response = await context
          .read<CartProductViewProvider>()
          .placeOrder(context, token!, totalPricesSum);

      // Check if the widget is not in the process of being popped
      if (Navigator.canPop(context)) {
        // Check if the widget is still mounted before proceeding
        if (context != null && context.findRenderObject() != null) {
          // Do your processing here
          if (response.success) {
            CartProvider cartProvider = context.read<CartProvider>();
            cartProvider.addToCart(response.cartCount);

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => OrderSuccessScreen(
                  orderId: response.orderId ?? '',
                ),
              ),
              (route) => false,
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(response.message),
                duration: Duration(seconds: 3),
              ),
            );
            Navigator.pop(context);
          }
        }
      }
    } catch (e) {
      print('Error during order placement: $e');
      // Handle the error as needed
    }
  }
}

Widget _buildInformation() {
  return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Additional Information',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Actual Price will be applicable on the date of dispatch',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: AppColors.kPrimary,
            ),
          ),
        ],
      ));
}
