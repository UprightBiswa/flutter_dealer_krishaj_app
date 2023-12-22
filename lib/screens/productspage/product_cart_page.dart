import 'package:flutter/material.dart';
import 'package:krishajdealer/utils/colors.dart';
import 'package:krishajdealer/widgets/common/custom_button.dart';

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kAppBackground,
      appBar: AppBar(
        backgroundColor: AppColors.kAppBackground,
        title: const Text('Shopping Cart'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Bag (total products 3)',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount:
                      5, // Replace with the actual count of saved products
                  separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Divider(
                      thickness: 1,
                      height: 0,
                      color: Colors.black12,
                    ),
                  ), // Divider line
                  itemBuilder: (context, index) => _buildCartItem(),
                ),
                SizedBox(
                  height: 8,
                ),
                _buildTotalSection(),
                SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            child: CustomButton(
              onPressed: () {
                // Proceed to order logic
              },
              text: 'Proceed to Order',
              icon: Icons.shopping_bag,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCartItem() {
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
                child: Image.asset(
                  'assets/images/Direct.jpg',
                  fit: BoxFit.cover,
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
                      'Product Name with a Very Long Title',
                      style: TextStyle(
                        fontSize: 14, // Adjusted font size
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Brand Name',
                      style: TextStyle(
                        fontSize: 12, // Adjusted font size
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Total Quantity: 3', // Replace with actual quantity
                      style: TextStyle(
                        fontSize: 12, // Adjusted font size
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Unit of Measure: 100g',
                      style: TextStyle(
                        fontSize: 12, // Adjusted font size
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: MaterialButton(
                onPressed: () {
                  // Remove product logic
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                color: Colors.red,
                shape: CircleBorder(),
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
            'Bill Details', // Replace with the actual count of products
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Total Price: \500', // Replace with the actual total price
            style: TextStyle(
              fontSize: 16,
            ),
          ),
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
      ),
    );
  }
}
