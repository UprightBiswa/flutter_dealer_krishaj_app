import 'package:flutter/material.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:krishajdealer/classes/language.dart';
import 'package:krishajdealer/classes/language_constrants.dart';
import 'package:krishajdealer/main.dart';
import 'package:krishajdealer/screens/authentication/logn_screen.dart';
import 'package:krishajdealer/screens/basic_information/basic-information_screen.dart';
import 'package:krishajdealer/utils/colors.dart';
import 'package:krishajdealer/widgets/common/custom_button.dart';
import 'package:krishajdealer/widgets/version/versioncard.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Language? selectedLanguage; // Add this line to store the selected language
  String selectedLanguageCode = ""; // Declare selectedLanguageCode here
  String appVersion = ""; // Declare appVersion here
  @override
  void initState() {
    super.initState();
    _loadSelectedLanguage();
    getAppVersion();
  }

  Future<void> getAppVersion() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        appVersion = packageInfo.version;
      });
      print('app version: $appVersion');
    } catch (e) {
      print('Error getting app version: $e');
      setState(() {
        appVersion = 'Unknown';
      });
    }
  }

  Future<void> _logout() async {
    bool confirmLogout = await _showLogoutConfirmationDialog();
    if (confirmLogout) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('userPhoneNumber'); // Remove only the phone number
      prefs.remove('userName'); // Remove only the username
      // Navigate to the login screen
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) =>
              const FoochiSignInView(), // Replace with your login screen
        ),
        (route) => false, // Remove all previous routes
      );
    }
  }

  Future<bool> _showLogoutConfirmationDialog() async {
    bool? result = await showModalBottomSheet<bool>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.warning,
                size: 48,
                color: Colors.orange,
              ),
              SizedBox(height: 16),
              Text(
                translation(context).confirm_logout,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                translation(context).do_you_really_want_to_log_out,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    text: translation(context).no,
                    icon: Icons.warning,
                  ),
                  SizedBox(width: 16),
                  CustomButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    text:translation(context).yes,
                    icon: Icons.warning,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
    return result ?? false;
  }

  Future<void> _loadSelectedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    selectedLanguageCode = prefs.getString(LAGUAGE_CODE) ?? ENGLISH;

    if (!Language.languageList()
        .any((lang) => lang.languageCode == selectedLanguageCode)) {
      selectedLanguageCode = ENGLISH;
    }

    setState(() {
      selectedLanguage = Language.languageList().firstWhere(
        (lang) => lang.languageCode == selectedLanguageCode,
        orElse: () => Language(2, "English", "en"),
      );
    });

    MyApp.setLocale(context, Locale(selectedLanguageCode));
  }

  void showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: [
            ListTile(
              title: Text(
                '${translation(context).please_select_your_language}: ${selectedLanguage?.name ?? ''}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(),
            ...Language.languageList()
                .map((e) => Column(
                      children: [
                        RadioListTile<Language>(
                          title: Text(e.name),
                          groupValue: selectedLanguage,
                          value: e,
                          onChanged: (Language? value) async {
                            setState(() {
                              selectedLanguage = value;
                            });

                            // Debug print statements
                            print(
                                'Selected language changed to: ${selectedLanguage?.name}');

                            // Save the selected language code to shared preferences
                            await setLocale(e.languageCode);

                            // Change the app's language locally
                            MyApp.setLocale(context, Locale(e.languageCode));

                            Navigator.pop(context); // Close the BottomSheet
                          },
                          // Set the 'selected' property to check if this language matches the selected language
                          selected: selectedLanguage == e,
                        ),
                        const Divider(),
                      ],
                    ))
                .toList(),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kAppBackground,
      appBar: AppBar(
        backgroundColor: AppColors.kAppBackground,
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            // User card
            BigUserCard(
              backgroundColor: Colors.green,
              userName: "Biswajit Das",
              userProfilePic: AssetImage("assets/images/logo.png"),
              cardActionWidget: SettingsItem(
                icons: Icons.edit,
                iconStyle: IconStyle(
                  withBackground: true,
                  borderRadius: 50,
                  backgroundColor: Colors.yellow[600],
                ),
                title: "Modify",
                subtitle: "Tap to change your data",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileWidget(),
                    ),
                  );
                },
              ),
            ),
            SettingsGroup(
              settingsGroupTitle: "Language",
              items: [
                SettingsItem(
                  onTap: () {
                    showLanguageBottomSheet(context);
                  },
                  icons: Icons.language,
                  iconStyle: IconStyle(),
                  title: 'Change Language',
                  subtitle: selectedLanguage?.name ?? '',
                ),
              ],
            ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: Icons.info_rounded,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.purple,
                  ),
                  title: 'About',
                  subtitle: "Learn more about Dealer'App",
                ),
              ],
            ),

            // Support
            SettingsGroup(
              settingsGroupTitle: "Support",
              items: [
                SettingsItem(
                  onTap: () {
                    // Add logic for Help
                    print("Help");
                  },
                  icons: Icons.help,
                  title: 'Help',
                ),
                SettingsItem(
                  onTap: () {
                    // Add logic for Video Tutorial
                    print("Video Tutorial");
                  },
                  icons: Icons.video_library,
                  title: 'Video Tutorial',
                ),
                SettingsItem(
                  onTap: () {
                    // Add logic for Feedback
                    print("Feedback");
                  },
                  icons: Icons.feedback,
                  title: 'Feedback',
                ),
                SettingsItem(
                  onTap: () {
                    // Add logic for Complaint
                    print("Complaint");
                  },
                  icons: Icons.report_problem,
                  title: 'Complaint',
                ),
                SettingsItem(
                  onTap: () {
                    // Add logic for Support
                    print("Support");
                  },
                  icons: Icons.support,
                  title: 'Support',
                ),
              ],
            ),
            // Account
            SettingsGroup(
              settingsGroupTitle: "Account",
              items: [
                SettingsItem(
                  onTap: () {
                    _logout();
                  },
                  icons: Icons.exit_to_app_rounded,
                  title: "Sign Out",
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.privacy_tip,
                  title: "Privacy Policy",
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.file_copy,
                  title: "Terms & Conditions",
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.delete,
                  title: "Delete account",
                  titleStyle: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.info,
                  title: "App Version",
                  subtitle: appVersion,
                  trailing: AppVersionWidget(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
