import 'package:flutter/material.dart';
import 'package:krishajdealer/screens/productspage/product_cart_page.dart';
import 'package:krishajdealer/screens/productspage/products_search_page.dart';
import 'package:krishajdealer/utils/colors.dart';
import 'package:krishajdealer/widgets/common/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;

  const ProductDetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int quantity = 1; // Initial quantity
  String selectedOption = 'Agro'; // Initial selected option
  late ValueNotifier<int> cartCountNotifier;
  @override
  void initState() {
    super.initState();
    cartCountNotifier = ValueNotifier<int>(0);
    _updateCartCount();
  }

  Future<void> _updateCartCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentCount = prefs.getInt('cartCount') ?? 0;
    cartCountNotifier.value = currentCount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kAppBackground,
      appBar: AppBar(
        backgroundColor: AppColors.kAppBackground,
        title: const Text('Product Details'),
        actions: [
          ValueListenableBuilder<int>(
            valueListenable: cartCountNotifier,
            builder: (context, count, _) {
              return IconButton(
                icon: Stack(
                  children: [
                    const Icon(Icons.shopping_cart),
                    if (count > 0)
                      Positioned(
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            count.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
                onPressed: () async {
                  // Navigate to the shopping cart page
                  // You can implement this part based on your navigation setup
                  // Here, I'm just pushing a MaterialPageRoute as an example
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ShoppingCartPage(),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          // Ensure constraints for the SingleChildScrollView
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize:
                  MainAxisSize.min, // Set mainAxisSize to MainAxisSize.min
              children: [
                // Image container with border
                Container(
                  width: double.infinity,
                  height: 300, // Adjust the height as needed
                  decoration: BoxDecoration(
                    color: Colors.white, // Change the background color to white
                    // borderRadius: const BorderRadius.only(
                    //   topLeft: Radius.circular(12.5),
                    //   topRight: Radius.circular(12.5),
                    //   bottomRight: Radius.circular(12.5),
                    // ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.kBackground.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Hero(
                          tag: 'product-image-${widget.product.brand}',
                          child: Image.asset(
                            widget.product.imageUrl,
                            width: 150, // Set the desired width for the image
                            height: 150, // Set the desired height for the image
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.kPrimary,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12.5),
                              topRight: Radius.circular(12.5),
                              bottomRight: Radius.circular(12.5),
                            ),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(1, 1),
                                blurRadius: 10,
                                spreadRadius: 0,
                                color: AppColors.kPrimary.withOpacity(.40),
                              ),
                            ],
                          ),
                          child: const Text(
                            '100 liter',
                            style: TextStyle(
                              color: AppColors.kWhite,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(8.0),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Brand: ${widget.product.brand}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.product.technical,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Features: It’s a systemic fungicide with preventive & curative action and Highly effective for paddy sheath blight',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Size: ',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '100 liter',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Price: ',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '\u20B9100',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),

                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(8.0),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select Company',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Flexible(
                            fit: FlexFit.tight,
                            child: buildOption('Agro'),
                          ),
                          const SizedBox(width: 16),
                          Flexible(
                            fit: FlexFit.tight,
                            child: buildOption('Krishaj'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(8.0),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Price display
                      Container(
                        width: double.infinity,
                        // decoration: BoxDecoration(
                        //   border: Border.all(color: Colors.grey, width: 2),
                        //   borderRadius: BorderRadius.circular(8),
                        // ),
                      ),

                      // Quantity selection
                      Container(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Quantity',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () {
                                      // Decrease quantity logic
                                      if (quantity > 1) {
                                        setState(() {
                                          quantity--;
                                        });
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    '$quantity',
                                    style: const TextStyle(color: Colors.white),
                                  ), // Display selected quantity
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      // Increase quantity logic
                                      setState(() {
                                        quantity++;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // // Total price display
                      // Container(
                      //   padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      //   child: Container(
                      //     width: double.infinity,
                      //     decoration: BoxDecoration(
                      //       border: Border.all(color: Colors.grey, width: 2),
                      //       borderRadius: BorderRadius.circular(8),
                      //     ),
                      //     padding: const EdgeInsets.all(16),
                      //     margin: const EdgeInsets.symmetric(vertical: 16),
                      //     child: Text(
                      //       'Total Price: \u20B9${quantity * 100}', // Assuming price is 100
                      //       style: const TextStyle(
                      //         fontSize: 18,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
        ),
      ),
      // Button to add to bag
      bottomSheet: Container(
        color: Colors.grey[200], // Add your desired background color here
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            child: CustomButton(
              onPressed: () {
                // Add to bag logic
                _addToBag();
              },
              icon: Icons.add_shopping_cart,
              text: 'Save to Bag',
            ),
          ),
        ),
      ),
    );
  }

  Widget buildOption(String option) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = option;
        });
      },
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: selectedOption == option ? Colors.green : Colors.transparent,
          border: Border.all(
            color: selectedOption == option ? Colors.green : Colors.black12,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            option,
            style: TextStyle(
              fontSize: 16,
              color: selectedOption == option ? Colors.white : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  void _addToBag() async {
    // Save the number of products to SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentCount = prefs.getInt('cartCount') ?? 0;
    int newCount = currentCount + quantity;
    prefs.setInt('cartCount', newCount);
    // Update the cart count notifier
    cartCountNotifier.value = newCount;

    // Show a Snackbar instead of a dialog
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Product Added to Bag\n'
          'Total Quantity: $quantity\n'
          'Total Price: ${quantity * 100}\n'
          'Selected Option: $selectedOption\n\n'
          'Items in Cart: $newCount',
        ),
        action: SnackBarAction(
          label: 'View Cart',
          onPressed: () {
            // Navigate to the shopping cart page
            // You can implement this part based on your navigation setup
            // Here, I'm just pushing a MaterialPageRoute as an example
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ShoppingCartPage(),
              ),
            );
          },
        ),
      ),
    );
  }
}
