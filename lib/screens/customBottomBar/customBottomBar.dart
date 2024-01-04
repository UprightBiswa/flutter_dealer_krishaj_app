import 'package:flutter/material.dart';
import 'package:krishajdealer/providers/productProvider/cartProvidercount.dart';
import 'package:krishajdealer/providers/productProvider/cartcountwidget.dart';
import 'package:krishajdealer/screens/basic_information/basic-information_screen.dart';
import 'package:krishajdealer/screens/dashboard/dashboard_screen.dart';
import 'package:krishajdealer/screens/home/home_screen.dart';
import 'package:krishajdealer/screens/orders/submitted-order_list_screen.dart';
import 'package:krishajdealer/screens/productspage/product_cart_page.dart';
import 'package:krishajdealer/screens/setting/setting_screen.dart';
import 'package:krishajdealer/screens/sidebar/sidebar_drawer.dart';
import 'package:krishajdealer/utils/colors.dart';
import 'package:provider/provider.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;
  DateTime? currentBackPressTime;

  // Define the widgets for each tab
  static final List<Widget> _widgetOptions = <Widget>[
    HomeWidget(),
    const DashboardWidget(),
    const SubmittedOrderListScreen(), // Added the new screen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // late ValueNotifier<int> cartCountNotifier;
  @override
  void initState() {
    super.initState();
    context.read<CartProvider>().updateCartCount();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentBackPressTime == null ||
            DateTime.now().difference(currentBackPressTime!) >
                Duration(seconds: 2)) {
          currentBackPressTime = DateTime.now();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Press back again to exit'),
            ),
          );
          return false;
        }
        return true;
      },
      child: Scaffold(
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
          title: Text(
            getAppBarTitle(_selectedIndex),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Consumer<CartProvider>(
              builder: (context, cartProvider, _) {
                return IconButton(
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
                ); // Use the CartCountWidget here
              },
            ),
            IconButton(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileWidget(),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsPage(),
                  ),
                );
              },
            ),
          ],
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu, // Replace with your custom icon
                  color: Colors.white, // Replace with your custom color
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ),
        drawer: const DrawerWidget(),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.lightGreen.withOpacity(0.5),
                Colors.green,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_outlined),
                label: 'Product',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            selectedFontSize: 14,
            unselectedFontSize: 12,
            selectedItemColor: Colors.white, // Set selected color to green
            unselectedItemColor:
                Colors.grey[700], // Set unselected color to grey
            onTap: _onItemTapped,
            selectedIconTheme: const IconThemeData(
              color: Colors.white, // Set selected icon color to green
              size: 30.0, // Adjust the selected icon size
            ),
            unselectedIconTheme: IconThemeData(
              color: Colors.grey[700], // Set unselected icon color to grey
            ),
            backgroundColor:
                Colors.transparent, // Make the background transparent
            type: BottomNavigationBarType.fixed, // Ensure all items are visible
            elevation: 0, // Remove the shadow
            showSelectedLabels: true,
            showUnselectedLabels: true,
          ),
        ),
      ),
    );
  }

  String getAppBarTitle(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Dashboard';
      case 2:
        return 'Product';
      default:
        return 'KRISHAJ';
    }
  }
}
