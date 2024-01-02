import 'package:flutter/material.dart';
import 'package:krishajdealer/providers/productProvider/cartProvidercount.dart';
import 'package:krishajdealer/providers/productProvider/cartcountwidget.dart';
import 'package:krishajdealer/screens/basic_information/basic-information_screen.dart';
import 'package:krishajdealer/screens/dashboard/dashboard_screen.dart';
import 'package:krishajdealer/screens/home/home_screen.dart';
import 'package:krishajdealer/screens/orders/submitted-order_list_screen.dart';
import 'package:krishajdealer/screens/productspage/product_cart_page.dart';
import 'package:krishajdealer/screens/productspage/products_search_page.dart';
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

  // Define the widgets for each tab
  static final List<Widget> _widgetOptions = <Widget>[
    HomeWidget(),
    const DashboardWidget(),
    const SearchPage(), // Added the new screen
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
    // cartCountNotifier = ValueNotifier<int>(0);
    // _updateCartCount();
     context.read<CartProvider>().updateCartCount();
  }

  // Future<void> _updateCartCount() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   int currentCount = prefs.getInt('cartCount') ?? 0;
  //   cartCountNotifier.value = currentCount;
  // }

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
          // ValueListenableBuilder<int>(
          //   valueListenable: cartCountNotifier,
          //   builder: (context, count, _) {
          //     return IconButton(
          //       icon: Stack(
          //         children: [
          //           const Icon(
          //             Icons.shopping_cart,
          //             color: Colors.white,
          //           ),
          //           if (count > 0)
          //             Positioned(
          //               right: 0,
          //               top: 0,
          //               child: Container(
          //                 padding: const EdgeInsets.all(2),
          //                 decoration: BoxDecoration(
          //                   color: Colors.red,
          //                   borderRadius: BorderRadius.circular(8),
          //                 ),
          //                 constraints: const BoxConstraints(
          //                   minWidth: 16,
          //                   minHeight: 16,
          //                 ),
          //                 child: Text(
          //                   count.toString(),
          //                   style: const TextStyle(
          //                     color: Colors.white,
          //                     fontSize: 10,
          //                   ),
          //                   textAlign: TextAlign.center,
          //                 ),
          //               ),
          //             ),
          //         ],
          //       ),
          //       onPressed: () async {
          //         // Navigate to the shopping cart page
          //         // You can implement this part based on your navigation setup
          //         // Here, I'm just pushing a MaterialPageRoute as an example
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => const ShoppingCartPage(),
          //           ),
          //         );
          //       },
          //     );
          //   },
          // ),
          IconButton(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            onPressed: () {
              // Navigate to the user profile page
              // You can implement this part based on your navigation setup
              // Here, I'm just pushing a MaterialPageRoute as an example
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
              // Navigate to the user profile page
              // You can implement this part based on your navigation setup
              // Here, I'm just pushing a MaterialPageRoute as an example
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
          selectedItemColor: Colors.yellowAccent, // Set selected color to green
          unselectedItemColor: Colors.white, // Set unselected color to grey
          onTap: _onItemTapped,
          selectedIconTheme: const IconThemeData(
            color: Colors.yellowAccent, // Set selected icon color to green
            size: 30.0, // Adjust the selected icon size
          ),
          unselectedIconTheme: const IconThemeData(
            color: Colors.white, // Set unselected icon color to grey
          ),
          backgroundColor:
              Colors.transparent, // Make the background transparent
          type: BottomNavigationBarType.fixed, // Ensure all items are visible
          elevation: 0, // Remove the shadow
          showSelectedLabels: true,
          showUnselectedLabels: true,
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
