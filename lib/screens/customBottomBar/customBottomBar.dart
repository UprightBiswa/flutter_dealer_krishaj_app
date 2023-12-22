import 'package:flutter/material.dart';
import 'package:krishajdealer/screens/basic_information/basic-information_screen.dart';
import 'package:krishajdealer/screens/dashboard/dashboard_screen.dart';
import 'package:krishajdealer/screens/home/home_screen.dart';
import 'package:krishajdealer/screens/orders/submitted-order_list_screen.dart';
import 'package:krishajdealer/screens/sidebar/sidebar_drawer.dart';
import 'package:krishajdealer/utils/colors.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 1;

  // Define the widgets for each tab
  static final List<Widget> _widgetOptions = <Widget>[
    HomeWidget(),
    const DashboardWidget(),
    const SubmittedOrderListScreen(), // Added the new screen
    const ProfileWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kAppBackground,
      appBar: AppBar(
        backgroundColor: AppColors.kAppBackground,
        title: Text(getAppBarTitle(_selectedIndex)),
      ),
      drawer: const DrawerWidget(),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
            icon: Icon(Icons.shopping_cart),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green, // Set selected color to green
        unselectedItemColor: Colors.grey, // Set unselected color to grey
        onTap: _onItemTapped,
        selectedIconTheme: const IconThemeData(
          color: Colors.green, // Set selected icon color to green
          size: 30.0, // Adjust the selected icon size
        ),
        unselectedIconTheme: const IconThemeData(
          color: Colors.grey, // Set unselected icon color to grey
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
        return 'Orders';
      case 3:
        return 'Profile';
      default:
        return 'KRISHAJ';
    }
  }
}
