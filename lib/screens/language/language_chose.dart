

import 'package:flutter/material.dart';
import 'package:krishajdealer/classes/language.dart';
import 'package:krishajdealer/classes/language_constrants.dart';
import 'package:krishajdealer/main.dart';
import 'package:krishajdealer/screens/authentication/logn_screen.dart';
import 'package:krishajdealer/screens/customBottomBar/customBottomBar.dart';
import 'package:krishajdealer/screens/onboarding/onboarding_screen.dart';
import 'package:krishajdealer/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  List<Language> languageList = Language.languageList();
  Language? selectedLanguage;

  void navigateToOnboarding() async {
    if (selectedLanguage == null) {
      // Show a snackbar if no language is selected
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select a language."),
        ),
      );
      return;
    }

    // Set the app's locale based on the selected language
    Locale locale = await setLocale(selectedLanguage!.languageCode);
    MyApp.setLocale(context, locale);

    // Check if it's the first-time installation
    bool isFirstInstallation = await checkFirstInstallation();
    bool isLoggedIn = await checkLoggedIn();

    if (isFirstInstallation) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const FoochiOnboardingView()),
      );
    } else {
      if (isLoggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  const CustomBottomNavigationBar()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const FoochiSignInView()),
        );
      }
    }
  }

  Future<bool> checkFirstInstallation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstInstallation = prefs.getBool('firstInstallation') ?? true;
    if (isFirstInstallation) {
      prefs.setBool('firstInstallation', false);
    }
    return isFirstInstallation;
  }

  Future<bool> checkLoggedIn() async {
    // Implement your logic to check if the user is logged in
    return false; // Replace with your actual logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackground,
      body: SafeArea(
        child: Builder(
          builder: (context) {
            return Stack(
              children: <Widget>[
                Positioned(
                  top: 100,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 150,
                      height: 150,
                    ),
                  ),
                ),
                Positioned(
                  top: 300,
                  left: 0,
                  right: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Center(
                        child: Text(
                          'Choose your preferred language:',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Radio buttons to select the language
                      const Divider(),
                      ...languageList
                          .map(
                            (language) => ListTile(
                              title: Text(
                                language.name,
                                style: TextStyle(
                                  color: selectedLanguage == language
                                      ? AppColors.kPrimary
                                      : Colors.black,
                                ),
                              ),
                              leading: Radio<Language>(
                                value: language,
                                groupValue: selectedLanguage,
                                onChanged: (Language? value) {
                                  setState(() {
                                    selectedLanguage = value;
                                  });
                                  // Debug print statements
                                  print(
                                      'Selected language changed to: ${selectedLanguage?.name}');
                                },
                              ),
                            ),
                          )
                          .toList(),
                      const Divider(),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      onTap: () => navigateToOnboarding(),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: selectedLanguage != null
                              ? AppColors
                                  .kPrimary // Green when language is selected
                              : Colors.grey,
                        ),
                        child: Center(
                          child: Text(
                            selectedLanguage != null
                                ? 'SELECT LANGUAGE'
                                : 'Please select a language',
                            style: const TextStyle(
                              color: AppColors.kBackground,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
