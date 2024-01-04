import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:krishajdealer/providers/authentication/auth_token.dart';
import 'package:krishajdealer/providers/productProvider/cartProvidercount.dart';
import 'package:krishajdealer/providers/productProvider/cartincrementdecrementprovider.dart';
import 'package:krishajdealer/providers/productProvider/cartproductviewprovider.dart';
import 'package:krishajdealer/screens/orders/order_placement_screen.dart';
import 'package:krishajdealer/screens/productspage/products_search_page.dart';
import 'package:krishajdealer/services/api/card_api_responce_model.dart';
import 'package:krishajdealer/utils/colors.dart';
import 'package:krishajdealer/widgets/common/custom_button.dart';
import 'package:krishajdealer/widgets/location/locationcontiner.dart';
import 'package:provider/provider.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({Key? key});

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  ApiResponseModelCartItem? _cartData; // Change type to nullable

  @override
  void initState() {
    super.initState();
    _loadCartData();
  }

  Future<void> _loadCartData() async {
    CartProvider cartProvider = context.read<CartProvider>();
    final provider =
        Provider.of<CartProductViewProvider>(context, listen: false);
    // Retrieve the user's token
    String? token = await AuthState().getToken();
    final ApiResponseModelCartItem cartData =
        await provider.viewCartDetails(token!, context);
    cartProvider.addToCart(cartData.totalProducts);
    setState(() {
      _cartData = cartData;
    });
  }

  Future<void> _removeCartItem(int cartId) async {
    CartProvider cartProvider = context.read<CartProvider>();
    final removecartProvider = context.read<CartProductViewProvider>();
    String? token = await AuthState().getToken();

    final response =
        await removecartProvider.removeCartItem(context, token!, cartId);

    if (response.success) {
      _showToast('Item removed successfully', isError: false);
      await _loadCartData(); // Reload the cart data
      if (response.totalProducts > 0) {
        cartProvider.addToCart(response.totalProducts);
      } else {
        // Reset the cart count to 0 if there are no products in the cart
        cartProvider.resetCart();
      }
    } else {
      print('Failed to remove item: ' + response.data);
      _showToast('Failed to remove item', isError: true);
    }
  }

  void _showToast(String message, {bool isError = false}) {
    Flushbar(
      message: message,
      duration: Duration(seconds: 3),
      backgroundColor: isError ? Colors.red : Colors.green,
    )..show(context); // Pass the context to the show method.
  }

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
        title: const Text('Shopping Cart'),
      ),
      body: SafeArea(
        child: _cartData != null && _cartData!.success
            ? SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TappableContainer(username: 'John'),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        color: Colors.white,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Bag (total products ${_cartData?.totalProducts ?? 0})',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: CustomButton(
                                onPressed: () {
                                  // Navigate to the search page or perform your desired action
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          SearchPage(), // Replace YourSearchPage with the actual page you want to navigate to
                                    ),
                                  );
                                },
                                text: 'Add More',
                                icon: Icons.add,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _cartData?.cartItems.length ?? 0,
                        separatorBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: Divider(
                            thickness: 1,
                            height: 0,
                            color: Colors.black12,
                          ),
                        ), // Divider line
                        itemBuilder: (context, index) => _buildCartItem(
                          _cartData!.cartItems[index],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      _buildTotalSection(),
                      SizedBox(
                        height: 8,
                      ),
                      _buildInformation(),
                      SizedBox(
                        height: 100,
                      )
                    ],
                  ),
                ),
              )
            : _cartData != null && _cartData!.message == 'No data available'
                ? Center(
                    child: Text('No data available'),
                  )
                : _cartData != null &&
                        _cartData!.message == 'No internet connection'
                    ? Center(
                        child: Text('No internet connection'),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
      ),
      bottomSheet: Container(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            child: _cartData != null &&
                    (_cartData!.message == 'No data available' ||
                        _cartData!.message == 'No internet connection')
                ? CustomButton(
                    onPressed: () {}, // Disabled button
                    text: 'Proceed to Order',
                    icon: Icons.shopping_bag,
                  )
                : CustomButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderPlacementScreen(
                            totalProducts: _cartData?.totalProducts ?? 0,
                            totalPricesSum: _parseTotalPricesSum(_cartData?.totalPricesSum),
                              
                          ),
                        ),
                      );
                    },
                    text: 'Proceed to Order',
                    icon: Icons.shopping_bag,
                  ),
          ),
        ),
      ),
    );
  }
double _parseTotalPricesSum(dynamic totalPricesSum) {
  if (totalPricesSum is String) {
    return double.tryParse(totalPricesSum) ?? 0.0;
  } else if (totalPricesSum is num) {
    return totalPricesSum.toDouble();
  } else {
    return 0.0; // Handle other cases or return a default value
  }
}

  Widget _buildCartItem(CartItem cartItem) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Container(
        // decoration: BoxDecoration(
        //   gradient: const LinearGradient(
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight,
        //     colors: [AppColors.kAppBackground, AppColors.kBackground],
        //   ),
        // ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 100,
                height: 100,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    bottomLeft: Radius.circular(12.0),
                    bottomRight: Radius.circular(12.0),
                    topRight: Radius.circular(12.0),
                  ),
                  border: Border.all(color: Colors.black12),
                ),
                child: Image.network(
                  cartItem.productImage ?? '',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Technical name: ${cartItem.productName}',
                      style: TextStyle(
                        fontSize: 14, // Adjusted font size
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Brand Name : ${cartItem.brandName}',
                      style: TextStyle(
                        fontSize: 12, // Adjusted font size
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'company: ${cartItem.company}',
                      style: TextStyle(
                        fontSize: 12, // Adjusted font size
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  if (int.tryParse(cartItem.quantity)! > 1) {
                                    await _updateCartQuantitydecrement(
                                      cartItem.id,
                                    );
                                  } else {
                                    _showToast(
                                        'Cannot decrement quantity below 1',
                                        isError: true);
                                    // Optionally show a message or perform another action
                                    print('Cannot decrement quantity below 1');
                                  }
                                },
                                icon: Icon(Icons.remove),
                                color: Colors.black,
                              ),
                              Text(
                                '${cartItem.quantity}', // Replace with actual quantity variable
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  await _updateCartQuantityincremnt(
                                      cartItem.id);
                                },
                                icon: Icon(Icons.add),
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.0),
                        GestureDetector(
                          onTap: () => _removeCartItem(
                              cartItem.id), // Pass the cart item ID
                          child: Text(
                            'Remove',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalSection() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bill Details (${_cartData?.totalProducts} products)',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Price:', // Replace with the actual total price
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                '\u20B9${_cartData?.totalPricesSum}',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Row(
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
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Net Price:', // Replace with the actual total price
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                '\u20B9${_cartData?.totalPricesSum}', // Use actual net price
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
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

  Future<void> _updateCartQuantityincremnt(int cartItemId) async {
    final updateCartProvider = context.read<CartIncrementDecrementProvider>();
    String? token = await AuthState().getToken();

    final response = await updateCartProvider.cartIncrement(
      context: context,
      token: token!,
      quantity: 1,
      cartId: cartItemId,
    );

    if (response.success) {
      _showToast('Quantity updated successfully', isError: false);
      await _loadCartData(); // Reload the cart data
    } else {
      _showToast('Failed to update quantity', isError: true);
    }
  }

  Future<void> _updateCartQuantitydecrement(int cartItemId) async {
    final updateCartProvider = context.read<CartIncrementDecrementProvider>();
    String? token = await AuthState().getToken();

    final response = await updateCartProvider.cartDecrement(
      context: context,
      token: token!,
      quantity: 1,
      cartId: cartItemId,
    );

    if (response.success) {
      _showToast('Quantity updated successfully', isError: false);
      await _loadCartData(); // Reload the cart data
    } else {
      _showToast('Failed to update quantity', isError: true);
    }
  }
}
