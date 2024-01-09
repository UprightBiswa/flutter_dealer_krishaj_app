import 'package:flutter/material.dart';
import 'package:krishajdealer/providers/authentication/auth_token.dart';
import 'package:krishajdealer/providers/productProvider/addtocart.dart';
import 'package:krishajdealer/providers/productProvider/allproducts.dart';
import 'package:krishajdealer/providers/productProvider/cartProvidercount.dart';
import 'package:krishajdealer/providers/productProvider/cartcountwidget.dart';
import 'package:krishajdealer/screens/productspage/product_cart_page.dart';
import 'package:krishajdealer/screens/productspage/products_search_page.dart';
import 'package:krishajdealer/services/api/api_responce_moodel.dart';
import 'package:krishajdealer/services/api/peoducts_api_responce_model.dart';
import 'package:krishajdealer/utils/assets.dart';
import 'package:krishajdealer/utils/colors.dart';
import 'package:krishajdealer/widgets/common/custom_button.dart';
import 'package:krishajdealer/widgets/location/locationcontiner.dart';

import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerSection extends StatelessWidget {
  final double width;

  const ShimmerSection({Key? key, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 16,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

class ShimmerBannerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Add this key
  LoadProductDetailsState _productDetailsState =
      LoadProductDetailsState.Loading;
  ProductDetails? _productDetails; // Store the product details
  // MaterialInfo? _materialInfo; // Store the material
  String _customerNumber = '';
  String _regionCode = '';
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
      AuthState authState = AuthState();
      _customerNumber = await authState.getCustomerNumnber() ?? '';
      _regionCode = await authState.getRegionCode() ?? '';
      // Log the values before making the API call
      print('Customer Number: $_customerNumber');
      print('Region Code: $_regionCode');
      print('Material Number: ${widget.product.materialNumber}');
      ApiResponseModelProductDetails productDetails =
          await context.read<AllProductViewProvider>().getProductDetails(
                context: context,
                regionCode: _regionCode,
                customerNumber: _customerNumber,
                materialNumber: widget.product.materialNumber,
              );
      if (productDetails.success) {
        setState(() {
          _productDetails = productDetails.message;
          print('Company code: ${_productDetails!.companyCodes}');
          _productDetailsState = LoadProductDetailsState.Data;
        });
      } else {
        setState(() {
          _productDetailsState = LoadProductDetailsState.Error;
        });
      }
    } catch (e) {
      print('Error loading product details: $e');
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
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(8.0),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerSection(width: 100),
                    const SizedBox(height: 8),
                    ShimmerSection(width: 200),
                    const SizedBox(height: 8),
                    ShimmerSection(width: 150),
                    const SizedBox(height: 8),
                    ShimmerSection(width: 120),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(8.0),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerSection(width: 200),
                    const SizedBox(height: 8),
                    ShimmerSection(width: 150),
                    const SizedBox(height: 8),
                    ShimmerSection(width: 120),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Divider(thickness: 4, color: Colors.green),
              SizedBox(height: 8),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.only(top: 8.0),
                width: double.infinity,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ShimmerSection(width: 100),
                    ),
                    ShimmerBannerCard(),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Divider(thickness: 4, color: Colors.green),
              SizedBox(height: 90),
            ],
          ),
        ),
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
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: AppColors.kBackground.withOpacity(0.5),
                    //     spreadRadius: 5,
                    //     blurRadius: 7,
                    //     offset: const Offset(0, 3),
                    //   ),
                    // ],
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
                                fit: BoxFit.contain,
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
                          child: Text(
                            '${widget.product.mseht}',
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
                        'Brand: ${_productDetails?.materialGroupDescription ?? ''}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      const SizedBox(height: 8),
                      Text(
                        'Technical Name: ${widget.product.materialGroupDescriptionShort} ',
                        style: const TextStyle(
                          fontSize: 18,
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
                            'Unit: ',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors
                                  .black, // You can set the color to black or any other color you prefer
                            ),
                          ),
                          Text(
                            '${_productDetails?.umrez} ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // Set the color to yellow
                            ),
                          ),
                          Text(
                            '${_productDetails?.baseUnitOfMeasure}',
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
                            '\u20B9${_productDetails?.price ?? 0}',
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Select Company: ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Check if companyCodes is not empty before accessing the first code
                      if (_productDetails?.companyCodes.isNotEmpty ?? false)
                        Column(
                          children: [
                            buildOption(_productDetails!.companyCodes),
                          ],
                        ),
                      const SizedBox(width: 8),
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
                            Text(
                              'Quantity: ${_productDetails?.mseht}', //case
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
                                    if (newQuantity != 0) {
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
                Divider(
                  thickness: 4,
                  color: Colors.green,
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(top: 8.0),
                  width: double.infinity,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                        ),
                        child: SHeadline(),
                      ),
                      BannerCard(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Divider(
                  thickness: 4,
                  color: Colors.green,
                ),
                SizedBox(
                  height: 90,
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

  String getCompanyName(String companyCode) {
    switch (companyCode) {
      case '1000':
        return 'KREPL';
      case '2000':
        return 'AGRO';
      // Add more cases for other company codes if needed
      default:
        return '';
    }
  }

  Widget buildOption(String companyCode) {
    String companyName = getCompanyName(companyCode);
    print('companyName: ' + companyName);
    return GestureDetector(
      onTap: () {
        // Handle onTap logic here
        print('Company Code tapped: $companyCode');
        print('Selected Company Name: $companyName');
      },
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.green, // Adjust the color as needed
          border: Border.all(
            color: Colors.green,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            companyName,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white, // Adjust the color as needed
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
      productNumber: _productDetails!.materialNumber,
      quantity: quantity,
      price: double.parse(_productDetails!.price),
      token: token ?? '',
      company: _productDetails!.companyCodes,
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
              Text(
                  'Total Price: ${quantity * double.parse(_productDetails!.price)}'),
              Text('Selected Option: ${_productDetails!.companyCodes}'),
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

  Widget BannerCard() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchPage(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(
            top: 16.0, bottom: 16.0, left: 16.0, right: 16.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: AssetImage(AppAssets.banner),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget SHeadline() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Shop More",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchPage(),
              ),
            );
          },
          child: Text(
            "View More",
            style: TextStyle(
              color: Color(0xff15BE77),
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
