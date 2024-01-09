import 'package:flutter/material.dart';
import 'package:krishajdealer/providers/Profile/basic_info_provider.dart';
import 'package:krishajdealer/providers/authentication/auth_token.dart';
import 'package:krishajdealer/screens/basic_information/edit_profile_page.dart';
import 'package:krishajdealer/screens/locationsearch/locationsearchpage.dart';
import 'package:krishajdealer/services/api/user_basic_info_responce_model.dart';
import 'package:krishajdealer/utils/colors.dart';
import 'package:krishajdealer/widgets/common/custom_button.dart';
import 'package:provider/provider.dart';

enum ProfileState {
  Loading,
  Data,
  Error,
}

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<ProfileWidget> {
  // Sample user data
  UserInfoMessage? userData;
  ProfileState _profileState = ProfileState.Loading;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      // Retrieve the user's token
      String? token = await AuthState().getToken();
      if (token == null) {
        // Handle the case where token is null (maybe show an error message)
        setState(() {
          _profileState = ProfileState.Error;
        });
        return;
      }
      // Assume you have a user token
      String userToken = token;
      UserInfoResponse userInfoResponse = await context
          .read<UserInfoProvider>()
          .getUserInfo(context, userToken);
      if (userInfoResponse.success) {
        setState(() {
          userData = userInfoResponse.message as UserInfoMessage;
          _profileState = ProfileState.Data;
        });
      } else {
        setState(() {
          _profileState = ProfileState.Error;
        });
      }
    } catch (e) {
      setState(() {
        _profileState = ProfileState.Error;
      });
      // Handle the error state
      print('Error loading user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (_profileState) {
      case ProfileState.Loading:
        return LoadingState();
      case ProfileState.Data:
        return DataState(
            userData: userData, onEditPressed: _navigateToEditPage);
      case ProfileState.Error:
        return ErrorState(retryCallback: _loadUserData);
    }
  }

  void _navigateToEditPage() {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => EditProfilePage(userData: userData),
    ),
  );
}

}

class LoadingState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

class ErrorState extends StatelessWidget {
  final VoidCallback retryCallback;

  const ErrorState({required this.retryCallback});

  @override
  Widget build(BuildContext context) {
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
}

class DataState extends StatelessWidget {
  final UserInfoMessage? userData;
  final VoidCallback onEditPressed;

  const DataState({required this.userData, required this.onEditPressed});

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
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Non-editable fields card
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: _buildProfileCard(context),
            ),
            SizedBox(height: 8),
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
                        color: Colors.green,
                      ),
                    ),
                  ),
                  // Divider line after 'Basic Information:'
                  Divider(
                    height: 0,
                    thickness: 1,
                    color: Colors.grey[300],
                  ),
                  _buildBasicInfoFields(
                    context,
                  ),
                  const SizedBox(height: 8.0),
                  // Edit button below the Basic Information fields
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: 'Edit',
                      icon: Icons.edit,
                      onPressed: onEditPressed,
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

  Widget _buildProfileCard(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 100.0,
          height: 100.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.kAppBackground,
          ),
          child: const Icon(
            Icons.person,
            color: AppColors.kPrimary,
            size: 100,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          'User Name: ${userData?.customerName ?? ''}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          'User Code: ${userData?.customerNumber ?? ''}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildBasicInfoFields(BuildContext context) {
    final dataFields = [
      {
        'field': 'Mobile',
        'icon': Icons.phone,
        'value': userData?.mobileNumber,
      },
      {
        'field': 'E-mail',
        'icon': Icons.email,
        'value': userData?.email,
      },
      {
        'field': 'Alternative Mobile no',
        'icon': Icons.phone_android,
        'value': userData?.customerName,
      },
      {
        'field': 'Total Cr Limit',
        'icon': Icons.monetization_on,
        'value': userData?.customerCreditLimit,
      },
      {
        'field': 'Available Cr. Limit',
        'icon': Icons.account_balance_wallet,
        'value': userData?.customerAvailableCredit,
      },
      {
        'field': 'Overdue',
        'icon': Icons.warning,
        'value': 'Overdue Value', // Replace with actual value
      },
      {
        'field': 'Outstanding',
        'icon': Icons.attach_money,
        'value': 'Outstanding Value', // Replace with actual value
      },
      {
        'field': 'PAN',
        'icon': Icons.credit_card,
        'value': userData?.panNumber,
      },
      {
        'field': 'GSTIN',
        'icon': Icons.receipt,
        'value': userData?.customerTaxNumber,
      },
      {
        'field': 'Region',
        'icon': Icons.location_on,
        'value': userData?.regionDescription,
      },
      {
        'field': 'Geotag',
        'icon': Icons.location_on,
        'value': userData?.geotag,
      },
      {
        'field': 'DOB',
        'icon': Icons.cake,
        'value': userData?.dateOfBirth,
      },
      {
        'field': 'Anniversary Date',
        'icon': Icons.event,
        'value': userData?.anniversaryDate,
      },
      {
        'field': 'ITR Submit',
        'icon': Icons.assignment_turned_in,
        'value': userData?.itrSubmit,
      },
    ];

    return Column(
      children: dataFields.map((item) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 16.0,
              ),
              child: Row(
                children: [
                  Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.kAppBackground,
                    ),
                    child: Center(
                      child: Icon(
                        item['icon'] as IconData,
                        color: AppColors.kPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Flexible(
                    child: Text(
                      '${item['field']}: ${item['value'] ?? 'N/A'}',
                      maxLines:
                          2, // Set the number of lines you want to display
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (item['field'] == 'Geotag')
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: AppColors.kPrimary,
                      ),
                      onPressed: () {
                        // Navigate to the location search page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LocationSearchPage(),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
            // Divider line after each text
            Divider(
              height: 0,
              thickness: 1,
              color: Colors.grey[300],
            ),
          ],
        );
      }).toList(),
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.kAppBackground,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.green, Colors.lightGreen.withOpacity(0.5)],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//         ),
//         title: Text(
//           'Profile',
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Non-editable fields card
//             Container(
//               width: double.infinity,
//               height: 200,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 // boxShadow: [
//                 //   BoxShadow(
//                 //     color: AppColors.kBackground.withOpacity(0.5),
//                 //     spreadRadius: 5,
//                 //     blurRadius: 7,
//                 //     offset: const Offset(0, 3),
//                 //   ),
//                 // ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     width: 100.0,
//                     height: 100.0,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: AppColors.kAppBackground,
//                     ),
//                     child: const Icon(
//                       Icons.person,
//                       color: AppColors.kPrimary,
//                       size: 100,
//                     ),
//                   ),
//                   const SizedBox(height: 8.0),
//                   Text(
//                     'User Name: ${userData['User Name']}',
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black, // Change the text color
//                     ),
//                   ),
//                   const SizedBox(height: 8.0),
//                   Text(
//                     'User Code: ${userData['User Code']}',
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black, // Change the text color
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 8,
//             ),
//             // Basic Information card
//             Container(
//               color: Colors.white,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text(
//                       'Basic Information:',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18.0,
//                         color: Colors.green, // Adjusted font color
//                       ),
//                     ),
//                   ),
//                   // Divider line after 'Basic Information:'
//                   Divider(
//                     height: 0,
//                     thickness: 1,
//                     color: Colors.grey[300],
//                   ),

//                   ...[
//                     {
//                       'field': 'Mobile',
//                       'icon': Icons.phone,
//                     },
//                     {
//                       'field': 'E-mail',
//                       'icon': Icons.email,
//                     },
//                     {
//                       'field': 'Alternative Mobile no',
//                       'icon': Icons.phone_android,
//                     },
//                     {
//                       'field': 'Total Cr Limit',
//                       'icon': Icons.monetization_on,
//                     },
//                     {
//                       'field': 'Available Cr. Limit',
//                       'icon': Icons.account_balance_wallet,
//                     },
//                     {
//                       'field': 'Overdue',
//                       'icon': Icons.warning,
//                     },
//                     {
//                       'field': 'Outstanding',
//                       'icon': Icons.attach_money,
//                     },
//                     {
//                       'field': 'PAN',
//                       'icon': Icons.credit_card,
//                     },
//                     {
//                       'field': 'GSTIN',
//                       'icon': Icons.receipt,
//                     },
//                     {
//                       'field': 'Address',
//                       'icon': Icons.location_on,
//                     },
//                     {
//                       'field': 'Geotag',
//                       'icon': Icons.location_on,
//                     },
//                     {
//                       'field': 'DOB',
//                       'icon': Icons.cake,
//                     },
//                     {
//                       'field': 'Anniversary Date',
//                       'icon': Icons.event,
//                     },
//                     {
//                       'field': 'ITR Submit',
//                       'icon': Icons.assignment_turned_in,
//                     },
//                   ].map((item) {
//                     return Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 16.0, horizontal: 16.0),
//                           child: Row(
//                             children: [
//                               Container(
//                                 width:
//                                     40.0, // Adjusted width for the circular container
//                                 height:
//                                     40.0, // Adjusted height for the circular container
//                                 decoration: const BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: AppColors
//                                       .kAppBackground, // Adjusted circle color
//                                 ),
//                                 child: Center(
//                                   child: Icon(
//                                     item['icon'] as IconData,
//                                     color: AppColors
//                                         .kPrimary, // Adjusted icon color
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(width: 8.0),
//                               Text(
//                                 '${item['field']}: ',
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Expanded(
//                                 child: item['field'] == 'Geotag'
//                                     ? LocationGeotagWidget()
//                                     : Text(
//                                         userData[item['field']] ?? '',
//                                         style: TextStyle(
//                                           color: Colors.grey[800],
//                                         ),
//                                       ),
//                               ),
//                               if (item['field'] ==
//                                   'Geotag') // Add an edit button for Geotag Address
//                                 IconButton(
//                                   icon: Icon(
//                                     Icons.edit,
//                                     color: AppColors.kPrimary,
//                                   ),
//                                   onPressed: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) =>
//                                             LocationSearchPage(),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                             ],
//                           ),
//                         ),
//                         // Divider line after each text
//                         Divider(
//                           height: 0,
//                           thickness: 1,
//                           color: Colors.grey[300],
//                         ),
//                       ],
//                     );
//                   }).toList(),
//                   const SizedBox(height: 8.0),
//                   // Edit button below the Basic Information fields
//                   SizedBox(
//                     width: double.infinity,
//                     child: CustomButton(
//                       text: 'Edit',
//                       icon: Icons.edit,
//                       onPressed: () {
//                         setState(() {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => EditProfilePage(
//                                 userData: userData,
//                                 onUpdate: (updatedData) {
//                                   setState(() {
//                                     userData = updatedData;
//                                   });
//                                 },
//                               ),
//                             ),
//                           );
//                         });
//                       },
//                     ),
//                   ),
//                   const SizedBox(height: 8.0),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
