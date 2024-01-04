import 'package:flutter/material.dart';

class Order {
  final int orderNo;
  final String productName;
  final String sku;
  final int quantity;
  final double priceBeforeGST;
  final double amountBeforeGST;
  final String status;
  final String image;

  Order({
    required this.orderNo,
    required this.productName,
    required this.sku,
    required this.quantity,
    required this.priceBeforeGST,
    required this.amountBeforeGST,
    required this.status,
    required this.image,
  });
}

class SubmittedOrderListPage extends StatefulWidget {
  const SubmittedOrderListPage({Key? key}) : super(key: key);

  @override
  _SubmittedOrderListPageState createState() => _SubmittedOrderListPageState();
}

class _SubmittedOrderListPageState extends State<SubmittedOrderListPage> {
  List<Order> _pendingOrders = [];
  List<Order> _dispatchedOrders = [];

  @override
  void initState() {
    super.initState();
    _loadDummyData();
  }

  void _loadDummyData() {
    // Load dummy data for pending orders
    _pendingOrders = List.generate(
      5,
      (index) => Order(
        orderNo: index + 1,
        productName: 'Product $index',
        sku: 'SKU $index',
        quantity: 10,
        priceBeforeGST: 1400,
        amountBeforeGST: 14000,
        status: 'Pending',
        image:
            'https://krepl.indigidigital.in/products/2.png', // Replace 'assets/product$image.png' with your actual image path
      ),
    );

    // Load dummy data for dispatched orders
    _dispatchedOrders = List.generate(
      5,
      (index) => Order(
        orderNo: index + 6,
        productName: 'Product $index',
        sku: 'SKU $index',
        quantity: 24,
        priceBeforeGST: 112,
        amountBeforeGST: 2688,
        status: 'Dispatched',
        image:
            'https://krepl.indigidigital.in/products/7.png', // Replace 'assets/product$image.png' with your actual image path
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submitted Order List'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildOrderSection('Pending', _pendingOrders),
            _buildOrderSection('Dispatched', _dispatchedOrders),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSection(String sectionName, List<Order> orders) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sectionName,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          if (orders.isEmpty)
            Center(
              child: Text('No $sectionName orders available'),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return _buildOrderItem(order);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(Order order) {
    return ListTile(
      leading: Image.network(
        order.image,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      ),
      title: Text('Order No: ${order.orderNo}'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('SKU: ${order.sku}'),
          Text('Quantity: ${order.quantity}'),
          Text('Price Before GST: ${order.priceBeforeGST}'),
          Text('Amount Before GST: ${order.amountBeforeGST}'),
          Text('Status: ${order.status}'),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {
              // Handle cancel action
              print('Cancel Order No: ${order.orderNo}');
            },
            child: Text('Cancel'),
          ),
          SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              // Handle save action
              print('Save Order No: ${order.orderNo}');
            },
            child: Text('Save'),
          ),
          SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              // Handle dispatch action
              print('Dispatch Order No: ${order.orderNo}');
            },
            child: Text('Dispatch'),
          ),
        ],
      ),
    );
  }
}
