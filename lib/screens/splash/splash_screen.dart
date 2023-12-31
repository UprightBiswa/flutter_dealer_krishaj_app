import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:krishajdealer/providers/authentication/auth_token.dart';
import 'package:krishajdealer/screens/authentication/logn_screen.dart';
import 'package:krishajdealer/screens/customBottomBar/customBottomBar.dart';
import 'package:krishajdealer/screens/language/language_chose.dart';
import 'package:krishajdealer/utils/colors.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

void showToast(String message, BuildContext context) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _logoAnimation = Tween<double>(begin: -300, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward().whenComplete(
      () async {
        bool isFirstLaunch = await checkFirstLaunch();
        if (isFirstLaunch) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LanguageScreen()),
          );
        } else {
          // Check if the user is logged in
          bool isLoggedIn =
              (await Provider.of<AuthState>(context, listen: false).getToken())
                      ?.isNotEmpty ??
                  false;

          if (isLoggedIn) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const CustomBottomNavigationBar(),
              ),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const FoochiSignInView()),
            );
          }
        }
      },
    );
  }

  Future<bool> checkFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('firstLaunch') ?? true;
    if (isFirstLaunch) {
      prefs.setBool('firstLaunch', false);
    }
    return isFirstLaunch;
  }

  @override
  void dispose() {
    // Restore the system overlays when the screen is disposed
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackground,
      appBar: AppBar(
        backgroundColor: AppColors.kBackground,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: AnimatedBuilder(
                animation: _logoAnimation,
                builder: (context, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Your company logo image goes here
                      Transform.translate(
                        offset: Offset(0, _logoAnimation.value),
                        child: Image.asset(
                          'assets/images/logo.png',
                          width: 180,
                          height: 180,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'KRISHAJ',
                        style: TextStyle(
                            color: AppColors.kPrimary,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      const SpinKitWaveSpinner(
                        color: AppColors.kPrimary,
                        size: 40,
                      ),
                    ],
                  );
                },
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height *
                    0.4, // 60% of the screen height
                decoration: const BoxDecoration(
                  color: Colors.transparent, // Transparent background
                ),
                child: Lottie.asset(
                  'assets/annimations/splash.json',
                  width: double.infinity, // Cover full screen width
                  height: double.infinity,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.kBackground,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Your text goes here
            Text(
              'Powered by:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 8), // Add spacing between image and text
            // Your image goes here
            Image.asset(
              'assets/images/indigi.png',
              width: 50, // Adjust the width as needed
              height: 50, // Adjust the height as needed
            ),
          ],
        ),
      ),
    );
  }
}
