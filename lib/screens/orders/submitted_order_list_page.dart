import 'package:flutter/material.dart';
import 'package:krishajdealer/utils/colors.dart';

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

class _SubmittedOrderListPageState extends State<SubmittedOrderListPage>
    with SingleTickerProviderStateMixin {
  List<Order> _pendingOrders = [];
  List<Order> _dispatchedOrders = [];
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _loadDummyData();
    _tabController = TabController(length: 2, vsync: this);
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
        title: Text('Submitted Order List'),
        bottom: TabBar(
          dividerColor: Colors.green,
          labelColor: Colors.green,
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          indicatorColor: Colors.green,
          controller: _tabController,
          tabs: [
            Tab(text: 'Pending'),
            Tab(text: 'Dispatched'),
          ],
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            child: SizedBox(height: 8), // Add some spacing above the TabBarView
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildOrderSection(_pendingOrders),
            _buildOrderSection(_dispatchedOrders),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSection(List<Order> orders) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (orders.isEmpty)
            Center(
              child: Text('No  orders available'),
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
    bool isDispatched = order.status == 'Dispatched';

    return Column(
      children: [
        Container(
          color: order.orderNo.isOdd
              ? Colors.grey.withOpacity(0.1)
              : Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Leading Image
              Container(
                width: 100,
                height: 100,
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.only(right: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Image.network(
                  order.image,
                  width: 50,
                  height: 50,
                  fit: BoxFit.contain,
                ),
              ),

              // Order Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order No: ${order.orderNo}'),
                    SizedBox(height: 4.0),
                    Text('SKU: ${order.sku}'),
                    Text('Quantity: ${order.quantity}'),
                    Text('Price Before GST: ${order.priceBeforeGST}'),
                    Text('Amount Before GST: ${order.amountBeforeGST}'),
                    Row(
                      // Status and Cancel Button in the same row
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Status: ${order.status}'),
                        if (!isDispatched)
                          TextButton(
                            onPressed: () {
                              // Handle cancel action
                              print('Cancel Order No: ${order.orderNo}');
                            },
                            child: Text('Cancel'),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.grey,
          height: 1.0,
        ),
      ],
    );
  }
}
