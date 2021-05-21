import 'dart:async';
import 'dart:io';


import 'package:flutter/material.dart';


import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pet_mart/providers/model_hud.dart';
import 'package:pet_mart/screens/add_advertise_screen.dart';
import 'package:pet_mart/screens/auction_details_screen.dart';
import 'package:pet_mart/screens/change_password_screen.dart';
import 'package:pet_mart/screens/contact_us_screen.dart';
import 'package:pet_mart/screens/forget_password_screen.dart';
import 'package:pet_mart/screens/languagee_screen.dart';
import 'package:pet_mart/screens/login_screen.dart';
import 'package:pet_mart/screens/main_sceen.dart';
import 'package:pet_mart/screens/my_account_screen.dart';
import 'package:pet_mart/screens/my_auction_screen.dart';
import 'package:pet_mart/screens/my_post_screen.dart';
import 'package:pet_mart/screens/orders_screen.dart';
import 'package:pet_mart/screens/privacy_screen.dart';
import 'package:pet_mart/screens/push_notification_screen.dart';
import 'package:pet_mart/screens/register_screen.dart';

import 'package:pet_mart/screens/splash_screen.dart';
import 'package:pet_mart/screens/terms_screen.dart';
import 'package:pet_mart/screens/verify_otp_screen.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'localization/localization_methods.dart';
import 'localization/set_localization.dart';
import 'package:intl/intl.dart';

import 'utilities/service_locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}



class MyApp extends StatefulWidget {

  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() {

    var f = new NumberFormat("###,###", "en_US");
    print(f.format(245315));

    return _MyAppState();
  }

}

class _MyAppState extends State<MyApp> {
  String messageTitle = "Empty";
  String notificationAlert = "alert";


  Locale _local;
  void setLocale(Locale locale) {
    setState(() {
      _local = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {

        this._local = locale;
        print('LanguageCode = ${_local.languageCode}');
      });
    }).whenComplete((){
      setDefaultLang(_local.languageCode);
    });
    super.didChangeDependencies();
  }
  void setDefaultLang(String code) async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString(LANG_CODE, code);

  }

  String _messageText = "Waiting for message...";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }



  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    if (_local == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return

        ScreenUtilInit(


          builder:() =>

              MultiProvider(
                providers: [
                  ChangeNotifierProvider<ModelHud>(create: (context) => ModelHud()),

                ],
                child:

                MaterialApp(


                  theme: ThemeData(


                      fontFamily: 'Cairo',
                      accentColor: kSecondaryColor,
                      primaryColor: kSecondaryColor



                  ) ,
                  builder: (context, child) {
                    return MediaQuery(
                      child: child,
                      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    );
                  },



                  locale: _local,

                  supportedLocales: [
                    Locale('en', 'US'),
                    Locale('ar', 'KW')
                  ],
                  localizationsDelegates: [
                    SetLocalization.localizationsDelegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  localeResolutionCallback: (deviceLocal, supportedLocales) {
                    for (var local in supportedLocales) {
                      if (local.languageCode == deviceLocal.languageCode &&
                          local.countryCode == deviceLocal.countryCode) {
                        return deviceLocal;
                      }
                    }
                    print(supportedLocales.first.countryCode);
                    return supportedLocales.first;
                  }
                  ,
                  debugShowCheckedModeBanner: false,
                  initialRoute: SplashScreen.id,
                  routes: {
                    SplashScreen.id: (context) => SplashScreen(),
                    MainScreen.id: (context) => MainScreen(),
                    LanguageScreen.id: (context) => LanguageScreen(),
                    AddAdvertiseScreen.id: (context) => AddAdvertiseScreen(),
                    ContactUsScreen.id: (context) => ContactUsScreen(),
                    TermsScreen.id: (context) => TermsScreen(),
                    PrivacyScreen.id: (context) => PrivacyScreen(),
                    LoginScreen.id: (context) => LoginScreen(),
                    ForgetPasswordScreen.id: (context) => ForgetPasswordScreen(),
                    RegisterScreen.id: (context) => RegisterScreen(),
                    VerifyOtpScreen.id: (context) => VerifyOtpScreen(),
                    MyAccountScreen.id: (context) => MyAccountScreen(),
                    MyPostScreen.id: (context) => MyPostScreen(),
                    MyAuctionScreen.id: (context) => MyAuctionScreen(),
                    OrdersScreen.id: (context) => OrdersScreen(),
                    PushNotificationScreen.id: (context) => PushNotificationScreen(),
                    AuctionDetailsScreen.id: (context) => AuctionDetailsScreen(),
                    ChangePasswordScreen.id: (context) => ChangePasswordScreen(),
                  },

                ),
              )
      );



    }
  }
}