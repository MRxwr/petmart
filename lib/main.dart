import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:http/http.dart' as http;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';


import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/model/token_model.dart';
import 'package:pet_mart/providers/model_hud.dart';
import 'package:pet_mart/providers/notification_count.dart';
import 'package:pet_mart/screens/adaption_screen.dart';
import 'package:pet_mart/screens/add_advertise_screen.dart';
import 'package:pet_mart/screens/auction_details_screen.dart';
import 'package:pet_mart/screens/change_password_screen.dart';
import 'package:pet_mart/screens/contact_us_screen.dart';
import 'package:pet_mart/screens/forget_password_screen.dart';
import 'package:pet_mart/screens/languagee_screen.dart';
import 'package:pet_mart/screens/login_screen.dart';
import 'package:pet_mart/screens/lost_screen.dart';
import 'package:pet_mart/screens/main_sceen.dart';
import 'package:pet_mart/screens/my_account_screen.dart';
import 'package:pet_mart/screens/my_auction_screen.dart';
import 'package:pet_mart/screens/my_message_screen.dart';
import 'package:pet_mart/screens/my_post_screen.dart';
import 'package:pet_mart/screens/notification_details_screen.dart';
import 'package:pet_mart/screens/orders_screen.dart';
import 'package:pet_mart/screens/privacy_main_screen.dart';
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
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  // description
  importance: Importance.high,
);

/// Initialize the [FlutterLocalNotificationsPlugin] package.
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
void main() async{
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );

  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );


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
int _messageCount = 0;

/// The API endpoint here accepts a raw FCM payload for demonstration purposes.
String constructFCMPayload(String token) {
  _messageCount++;
  return jsonEncode({
    'token': token,
    'data': {
      'via': 'FlutterFire Cloud Messaging!!!',
      'count': _messageCount.toString(),
    },
    'notification': {
      'title': 'Hello FlutterFire!',
      'body': 'This notification (#$_messageCount) was created via FCM!',
    },
  });
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: "Main Navigator");

  String messageTitle = "Empty";
  String notificationAlert = "alert";
  String _token;

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

  Future <void> getToken() async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String mToken =_preferences.getString("token")??"";
    if(mToken ==""){
      String toke = await FirebaseMessaging.instance.getToken(vapidKey: "BEp83hChFvm1ckxAt291kepX_T43rkk1e6j3ltN_tyxmk6CICMvnGN0BISLDX6VWjR46QaYuX0OJ51VS7Wy1b6M");
      print('token --> ${toke}');
      SharedPreferences _preferences = await SharedPreferences.getInstance();


      String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
      _preferences.setString("token", toke);
      print('Token Saved!');
      PetMartService petMartService  = PetMartService();
      String deviceType = "";
      if(Platform.isAndroid){
        deviceType = "a";
      }else{
        deviceType = "i";
      }
      Map<String,String> map = Map();
      map['device_token'] = toke;
      map['language']= languageCode;
      map['device_type']= deviceType;
      print(map);

      TokenModel tokenModel = await petMartService.registerToken(map);
      print('message ----> ${tokenModel.message}');
    }

  }
  Future<void> init() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isLoggedIn = sharedPreferences.getBool(kIsLogin)??false;


  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if(message != null){
        print('remoteMessgae sss${message.toString()}');
        dynamic dataObject=  message.data;

        print('dataObject ---> ${dataObject.toString()}');
        String type = dataObject['push_type'];

        print('type ---> ${type}');
        if (type .contains('chatuser')){

          Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
            return new MyMessagesScreen();
          }));



        }else if(type .contains('rateonuser')){
          String auctionId = dataObject['auction_id'];
          Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
            return new NotificationDetailsScreen(id:auctionId,name: 'Auction Details',);
          }));
        }
      }




    });
    getToken().then((value) {

    });


    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;

      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,

                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      String remoteMessgae = message.data.toString();
      dynamic dataObject=  message.data;
      print('dataObject ---> ${dataObject.toString()}');
      String type = dataObject['push_type'];
      if (type .contains('chatuser') ){
        Navigator.of(navigatorKey.currentContext,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
          return new MyMessagesScreen();
        }));
      }else if(type .contains('rateonuser') ){
        String auctionId = dataObject['auction_id'];
        Navigator.of(navigatorKey.currentContext,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
          return new NotificationDetailsScreen(id:auctionId,name: 'Auction Details',);
        }));
      }

      print('remoteMessgae ${remoteMessgae}');

      // Navigator.pushNamed(context, '/message',
      //     arguments: MessageArguments(message, true));
    });


  }

  Stream<String> _tokenStream;

  void setToken(String token) {
    print('FCM Token: $token');
    setState(() {
      _token = token;
    });
  }
  Future<void> sendPushMessage() async {
    if (_token == null) {
      print('Unable to send FCM message, no token exists.');
      return;
    }

    try {
      await http.post(
        Uri.parse('https://api.rnfirebase.io/messaging/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: constructFCMPayload(_token),
      );
      print('FCM request for device sent!');
    } catch (e) {
      print(e);
    }
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
      return FutureBuilder(  future: Firebase.initializeApp(),
        builder: (context,snapShot){
          if(snapShot.hasError){
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }else{
            return

              ScreenUtilInit(


                  builder:(child) =>

                      MultiProvider(
                        providers: [
                          ChangeNotifierProvider<ModelHud>(create: (context) => ModelHud()),
                          ChangeNotifierProvider<NotificationNotifier>(create: (context) => NotificationNotifier()),
                        ],
                        child:

                        OverlaySupport(

                          child: MaterialApp(
                            navigatorKey: navigatorKey ,


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
                              AdaptionScreen.id: (context) => AdaptionScreen(),
                              LostScreen.id: (context) => LostScreen(),
                              PrivacyMainScreen.id: (context) => PrivacyMainScreen(),
                            },

                          ),
                        ),
                      )
              );
          }

        },);





    }
  }
}