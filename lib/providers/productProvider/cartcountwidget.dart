import 'package:flutter/material.dart';
import 'package:krishajdealer/providers/productProvider/cartProvidercount.dart';
import 'package:provider/provider.dart';

class CartCountWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Container(
      child: Stack(
        children: [
          Icon(
            Icons.shopping_cart,
            color: Colors.white,
          ),
          if (cartProvider.cartCount > 0)
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
                  cartProvider.cartCount.toString(),
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
    );
  }
}
