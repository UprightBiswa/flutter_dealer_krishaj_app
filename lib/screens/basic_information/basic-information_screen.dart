import 'package:flutter/material.dart';
import 'package:krishajdealer/screens/basic_information/edit_profile_page.dart';
import 'package:krishajdealer/utils/colors.dart';
import 'package:krishajdealer/widgets/common/custom_button.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<ProfileWidget> {
  // Sample user data
  Map<String, String> userData = {
    'User Code': '12345',
    'User Name': 'John Doe',
    'Mobile': '9876543210',
    'E-mail': 'john.doe@example.com',
    'Alternative Mobile no': '9876543211',
    'DOB': '01-Jan-1990',
    'Anniversary Date': '05-Feb',
    'ITR Submit': 'No',
    'Total Cr Limit': '10000',
    'Available Cr. Limit': '5000',
    'Overdue': '2000',
    'Outstanding': '3000',
    'PAN': 'ABCDE1234F',
    'GSTIN': '27ABCDE1234F1Z5',
    'Address': '123, Street Name, City',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kAppBackground,
      appBar: AppBar(
        backgroundColor: AppColors.kAppBackground,
        title: Text(
          'Profile',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Non-editable fields card
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.kBackground.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.kBackground,
                    ),
                    child: const Icon(
                      Icons.person,
                      color: AppColors.kPrimary,
                      size: 100,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'User Name: ${userData['User Name']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Change the text color
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'User Code: ${userData['User Code']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Change the text color
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            // Basic Information card
            Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Basic Information:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.green, // Adjusted font color
                      ),
                    ),
                  ),
                  // Divider line after 'Basic Information:'
                  Divider(
                    height: 0,
                    thickness: 1,
                    color: Colors.grey[300],
                  ),

                  ...[
                    {
                      'field': 'Mobile',
                      'icon': Icons.phone,
                    },
                    {
                      'field': 'E-mail',
                      'icon': Icons.email,
                    },
                    {
                      'field': 'Alternative Mobile no',
                      'icon': Icons.phone_android,
                    },
                    {
                      'field': 'Total Cr Limit',
                      'icon': Icons.monetization_on,
                    },
                    {
                      'field': 'Available Cr. Limit',
                      'icon': Icons.account_balance_wallet,
                    },
                    {
                      'field': 'Overdue',
                      'icon': Icons.warning,
                    },
                    {
                      'field': 'Outstanding',
                      'icon': Icons.attach_money,
                    },
                    {
                      'field': 'PAN',
                      'icon': Icons.credit_card,
                    },
                    {
                      'field': 'GSTIN',
                      'icon': Icons.receipt,
                    },
                    {
                      'field': 'Address',
                      'icon': Icons.location_on,
                    },
                    {
                      'field': 'DOB',
                      'icon': Icons.cake,
                    },
                    {
                      'field': 'Anniversary Date',
                      'icon': Icons.event,
                    },
                    {
                      'field': 'ITR Submit',
                      'icon': Icons.assignment_turned_in,
                    },
                  ].map((item) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 8.0),
                          child: Row(
                            children: [
                              Container(
                                width:
                                    40.0, // Adjusted width for the circular container
                                height:
                                    40.0, // Adjusted height for the circular container
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors
                                      .kBackground, // Adjusted circle color
                                ),
                                child: Center(
                                  child: Icon(
                                    item['icon'] as IconData,
                                    color: AppColors
                                        .kPrimary, // Adjusted icon color
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                '${item['field']}: ',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                userData[item['field']] ?? '',
                                style: TextStyle(
                                  color: Colors.grey[800],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Divider line after each text
                        Divider(
                          thickness: 1,
                          color: Colors.grey[300],
                        ),
                      ],
                    );
                  }).toList(),
                  const SizedBox(height: 8.0),
                  // Edit button below the Basic Information fields
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: 'Edit',
                      icon: Icons.edit,
                      onPressed: () {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfilePage(
                                userData: userData,
                                onUpdate: (updatedData) {
                                  setState(() {
                                    userData = updatedData;
                                  });
                                },
                              ),
                            ),
                          );
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 8.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
