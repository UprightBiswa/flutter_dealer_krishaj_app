import 'package:flutter/material.dart';
import 'package:krishajdealer/providers/authentication/auth_token.dart';
import 'package:krishajdealer/providers/productProvider/cartProvidercount.dart';
import 'package:krishajdealer/providers/productProvider/cartproductviewprovider.dart';
import 'package:krishajdealer/screens/orders/ordersuccess.dart';
import 'package:krishajdealer/services/api/orderplacementresponce.dart';
import 'package:krishajdealer/utils/colors.dart';
import 'package:krishajdealer/widgets/common/custom_button.dart';
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order now',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 8.0),
              Container(
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
                            'John Doe',
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
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            child: Builder(
              builder: (BuildContext builderContext) {
                return CustomButton(
                  onPressed: () async {
                    try {
                      // Show loading indicator
                      showDialog(
                        barrierDismissible: false,
                        context: builderContext,
                        builder: (BuildContext context) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      );

                      String? token = await AuthState().getToken();
                      double totalPricesSumAsDouble =
                          double.parse(totalPricesSum.toString());

                      print('₹${totalPricesSumAsDouble.toStringAsFixed(2)}');

                      final response = await builderContext
                          .read<CartProductViewProvider>()
                          .placeOrder(builderContext, token!, totalPricesSum);

                      // Check if the widget is not in the process of being popped
                      if (Navigator.canPop(builderContext)) {
                        // Check if the widget is still mounted before proceeding
                        if (context != null &&
                            context.findRenderObject() != null) {
                          // Do your processing here
                          if (response.success) {
                            CartProvider cartProvider =
                                builderContext.read<CartProvider>();
                            cartProvider.addToCart(response.cartCount);

                            Navigator.push(
                              builderContext,
                              MaterialPageRoute(
                                builder: (context) => OrderSuccessScreen(
                                  orderId: response.orderId ?? '',
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(builderContext).showSnackBar(
                              SnackBar(
                                content: Text(response.message),
                                duration: Duration(seconds: 3),
                              ),
                            );
                          }
                        }
                      }
                    } catch (e) {
                      print('Error during order placement: $e');
                      // Handle the error as needed
                    }
                  },
                  text: 'Place your Order',
                  icon: Icons.shopping_bag,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
