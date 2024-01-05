import 'package:flutter/material.dart';
import 'package:krishajdealer/providers/Dashboard/announcement_provider.dart';
import 'package:krishajdealer/providers/authentication/auth_token.dart';
import 'package:krishajdealer/providers/authentication/otprequestProvider.dart';
import 'package:krishajdealer/providers/productProvider/addtocart.dart';
import 'package:krishajdealer/providers/productProvider/allproducts.dart';
import 'package:krishajdealer/providers/productProvider/cartProvidercount.dart';
import 'package:krishajdealer/providers/productProvider/cartincrementdecrementprovider.dart';
import 'package:krishajdealer/providers/productProvider/cartproductviewprovider.dart';
import 'package:krishajdealer/screens/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'classes/language_constrants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<ProductProvider>(
            create: (context) => ProductProvider(),
          ),
          ChangeNotifierProvider<CartProvider>(
            create: (context) => CartProvider(),
          ),
          ChangeNotifierProvider<CartProductViewProvider>(
            create: (context) => CartProductViewProvider(),
          ),
          ChangeNotifierProvider<RequestOtpProvider>(
            create: (context) => RequestOtpProvider(),
          ),
          ChangeNotifierProvider<AuthState>(
            create: (context) => AuthState(),
          ),
          ChangeNotifierProvider<AllProductViewProvider>(
            create: (context) => AllProductViewProvider(),
          ),
          ChangeNotifierProvider<CartIncrementDecrementProvider>(
            create: (context) => CartIncrementDecrementProvider(),
          ),
          ChangeNotifierProvider<AnnouncementProvider>(
            create: (context) => AnnouncementProvider(),
          ),
        ],
        child: const MyApp(),
      ),
    );
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DEALER APP',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      home: const SplashScreen(),
    );
  }
}
