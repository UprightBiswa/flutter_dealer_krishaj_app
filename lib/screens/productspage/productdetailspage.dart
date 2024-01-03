import 'package:flutter/material.dart';
import 'package:krishajdealer/providers/authentication/auth_token.dart';
import 'package:krishajdealer/providers/productProvider/addtocart.dart';
import 'package:krishajdealer/providers/productProvider/allproducts.dart';
import 'package:krishajdealer/providers/productProvider/cartProvidercount.dart';
import 'package:krishajdealer/providers/productProvider/cartcountwidget.dart';
import 'package:krishajdealer/screens/orders/submitted-order_list_screen.dart';
import 'package:krishajdealer/screens/productspage/product_cart_page.dart';
import 'package:krishajdealer/screens/productspage/products_search_page.dart';
import 'package:krishajdealer/services/api/api_responce_moodel.dart';
import 'package:krishajdealer/services/api/peoducts_api_responce_model.dart';
import 'package:krishajdealer/utils/colors.dart';
import 'package:krishajdealer/widgets/common/custom_button.dart';
import 'package:krishajdealer/widgets/location/locationcontiner.dart';

import 'package:provider/provider.dart';

enum LoadProductDetailsState {
  Loading,
  Data,
  Error,
}

class ProductDetailsPage extends StatefulWidget {
  final ProductItem product;
  final int index; // Add index property
  const ProductDetailsPage(
      {Key? key, required this.product, required this.index})
      : super(key: key);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int quantity = 1; // Initial quantity
  String selectedOption = 'AGRO'; // Initial selected option
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Add this key
  LoadProductDetailsState _productDetailsState =
      LoadProductDetailsState.Loading;
  ProductDetailsData? _productDetails; // Store the product details
  @override
  void initState() {
    super.initState();
    _loadProductDetails();
    context.read<CartProvider>().updateCartCount();
  }

  Future<void> _loadProductDetails() async {
    try {
      setState(() {
        _productDetailsState = LoadProductDetailsState.Loading;
      });

      ApiResponseModelProductDetails productDetails =
          await context.read<AllProductViewProvider>().getProductDetails(
                context: context,
                productId: widget.product.id,
              );

      setState(() {
        _productDetails = productDetails.productDetails;
        _productDetailsState = LoadProductDetailsState.Data;
      });
    } catch (e) {
      setState(() {
        _productDetailsState = LoadProductDetailsState.Error;
      });
      // Handle the error state
      print('Error loading product details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (_productDetailsState) {
      case LoadProductDetailsState.Loading:
        return LoadingState();
      case LoadProductDetailsState.Data:
        return DataState();
      case LoadProductDetailsState.Error:
        return ErrorState(retryCallback: _loadProductDetails);
    }
  }

  Widget LoadingState() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget ErrorState({required VoidCallback retryCallback}) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error occurred'),
            ElevatedButton(
              onPressed: retryCallback,
              child: Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget DataState() {
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
        title: const Text('Product Details'),
        actions: [
          IconButton(
            icon: CartCountWidget(), // Use the new widget here
            onPressed: () {
              // Navigate to the shopping cart page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ShoppingCartPage(),
                ),
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
                // Location  Container
                TappableContainer(username: 'John'),

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
                        child: _productDetails != null &&
                                _productDetails!.productImageUrl.isNotEmpty
                            ? Image.network(
                                _productDetails!.productImageUrl,
                                width:
                                    150, // Set the desired width for the image
                                height:
                                    150, // Set the desired height for the image
                                fit: BoxFit.cover,
                              )
                            : Placeholder(), // You can replace Placeholder() with any widget you prefer for no image
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
                            'Case',
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
                        'Brand: ${_productDetails?.productName ?? ''}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 8),
                      Text(
                        widget.product.userId,
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
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     Text(
                      //       'Size: ',
                      //       style: const TextStyle(
                      //         fontSize: 16,
                      //       ),
                      //     ),
                      //     Text(
                      //       '1 liter',
                      //       style: const TextStyle(
                      //         fontSize: 16,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Unit of Measure: ',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors
                                  .black, // You can set the color to black or any other color you prefer
                            ),
                          ),
                          Text(
                            ' Case',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // Set the color to yellow
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
                            '\u20B9200',
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          for (String companyCode
                              in _productDetails?.companyCodes ?? [])
                            Flexible(
                              fit: FlexFit.tight,
                              child: Column(
                                children: [
                                  buildOption(companyCode),
                                  const SizedBox(
                                      height: 8), // Add space between options
                                ],
                              ),
                            ),
                          const SizedBox(width: 8),
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

                      Container(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Quantity', //case
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              //input type: Text and +/- buttons
                              children: [
                                Container(
                                  width:
                                      28.0, // Adjusted width for the circular container
                                  height: 28.0,
                                  decoration: const BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    icon: Center(
                                      child: const Icon(
                                        Icons.remove,
                                        size: 12,
                                      ),
                                    ),
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
                                TextButton(
                                  onPressed: () async {
                                    int? newQuantity =
                                        await _showQuantityInputDialog();
                                    if (newQuantity != null) {
                                      setState(() {
                                        quantity = newQuantity.clamp(1, 100);
                                      });
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.kAppBackground,
                                      shape: BoxShape.rectangle,
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    padding: const EdgeInsets.all(8),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Text(
                                      '$quantity',
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ), // Display selected quantity
                                  ),
                                ),
                                Container(
                                  width:
                                      28.0, // Adjusted width for the circular container
                                  height: 28.0,
                                  decoration: const BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    icon: Center(
                                      child: const Icon(
                                        Icons.add,
                                        size: 12,
                                      ),
                                    ),
                                    onPressed: () {
                                      // Increase quantity logic
                                      setState(() {
                                        quantity = (quantity + 1).clamp(1, 100);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                // Container(
                //   color: Colors.white,
                //   padding: const EdgeInsets.all(8.0),
                //   width: double.infinity,
                //   child: Column(
                //     children: [
                //       SHeadline(),
                //       CardListView(products: products3),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 60,
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
              onPressed: () async {
                await _addToBag();
              },
              icon: Icons.add_shopping_cart,
              text: 'Save to Bag',
            ),
          ),
        ),
      ),
    );
  }

  Widget buildOption(String companyCode) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = companyCode;
        });
      },
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color:
              selectedOption == companyCode ? Colors.green : Colors.transparent,
          border: Border.all(
            color:
                selectedOption == companyCode ? Colors.green : Colors.black12,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            companyCode,
            style: TextStyle(
              fontSize: 16,
              color: selectedOption == companyCode ? Colors.white : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addToBag() async {
    // Your API call logic
    ProductProvider productProvider = context.read<ProductProvider>();
    CartProvider cartProvider = context.read<CartProvider>();
    // Get the token from SharedPreferences
    String? token = await AuthState().getToken();
     print('Token saved: $token');
    ApiResponseModel response = await productProvider.addToCart(
      context: context, // Pass the context here
      productId: _productDetails!.id,
      quantity: quantity,
      price: 200,
      token: token ?? '',
      company: selectedOption,
    );

    if (response.success) {
      await cartProvider.addToCart(response.totalProducts);

      // Show a Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Text('Product: ${response.message}'),
              Text('Product Added to Bag'),
              Text('Total Quantity: $quantity'),
              Text('Total Price: ${quantity * 200}'),
              Text('Selected Option: $selectedOption'),
              Text('Items in Cart: ${response.totalProducts}'),
              SizedBox(height: 8), // Add some spacing
              Container(
                width: double.infinity,
                child: CustomButton(
                  icon: Icons.add_shopping_cart,
                  text: 'View Cart',
                  onPressed: () {
                    // Navigate to the shopping cart page
                    // You can implement this part based on your navigation setup
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ShoppingCartPage(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          backgroundColor: Colors.green[600], // Set color for success
        ),
      );
    } else {
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${response.message}'),
          backgroundColor: Colors.red, // Set color for error
        ),
      );
    }
  }

  Future<int> _showQuantityInputDialog() async {
    int? newQuantity = quantity;

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Quantity'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Quantity'),
              initialValue: quantity.toString(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a quantity.';
                }
                int? parsedValue = int.tryParse(value);
                if (parsedValue == null) {
                  return 'Please enter a valid number.';
                }
                if (parsedValue < 1 || parsedValue > 100) {
                  return 'Quantity must be between 1 and 100.';
                }
                return null;
              },
              onChanged: (value) {
                newQuantity = int.tryParse(value) ?? quantity;
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  Navigator.of(context).pop(newQuantity);
                }
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Validate the form before closing the dialog
                if (_formKey.currentState?.validate() ?? false) {
                  Navigator.of(context).pop(newQuantity);
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );

    return newQuantity ?? quantity;
  }
}
