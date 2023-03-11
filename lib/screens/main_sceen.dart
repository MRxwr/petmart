

import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/DeleteUserModel.dart';
import 'package:pet_mart/model/check_credit_model.dart';
import 'package:pet_mart/model/home_model.dart';

import 'package:pet_mart/model/login_model.dart';
import 'package:pet_mart/model/notification_model.dart';
import 'package:pet_mart/providers/model_hud.dart';
import 'package:pet_mart/providers/notification_count.dart';
import 'package:pet_mart/providers/title_provider.dart';
import 'package:pet_mart/screens/privacy_main_screen.dart';
import 'package:pet_mart/screens/search_screen.dart';
import 'package:pet_mart/screens/adaption_screen.dart';
import 'package:pet_mart/screens/add_advertise_screen.dart';
import 'package:pet_mart/screens/change_password_screen.dart';
import 'package:pet_mart/screens/contact_us_screen.dart';
import 'package:pet_mart/screens/home_screen.dart';
import 'package:pet_mart/screens/login_screen.dart';
import 'package:pet_mart/screens/lost_screen.dart';
import 'package:pet_mart/screens/my_account_screen.dart';
import 'package:pet_mart/screens/my_auction_screen.dart';
import 'package:pet_mart/screens/my_message_screen.dart';
import 'package:pet_mart/screens/my_post_screen.dart';
import 'package:pet_mart/screens/orders_screen.dart';
import 'package:pet_mart/screens/privacy_screen.dart';
import 'package:pet_mart/screens/push_notification_screen.dart';
import 'package:pet_mart/screens/terms_screen.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:pet_mart/utilities/shared_prefs.dart';
import 'package:pet_mart/widgets/action_icon.dart';
import 'package:pet_mart/widgets/fab_bottom_app_bar.dart';
import 'package:pet_mart/widgets/fab_with_icons.dart';
import 'package:pet_mart/widgets/layout.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unique_identifier/unique_identifier.dart';

import '../main.dart';
import 'auction_screen.dart';
class MainScreen extends StatefulWidget {
  static String id = 'MainScreen';
  String? title;
  MainScreen({Key? key, this.title}): super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>  with AutomaticKeepAliveClientMixin{
  String _lastSelected = 'TAB: 0';
  final  _homeScreen = GlobalKey<NavigatorState>();
  final _competitionNewsScreen = GlobalKey<NavigatorState>();
  final _amateursNews = GlobalKey<NavigatorState>();
  final _vediosScreen = GlobalKey<NavigatorState>();
  final _salesScreen = GlobalKey<NavigatorState>();

  ScreenUtil screenUtil = ScreenUtil();
  bool isLogIn = false;
  LoginModel? loginModel;
  int index =0;
  final navigatorKey = GlobalKey<NavigatorState>();
  bool isStart = true;

  String languageCode="";
  String mLangaugeCode ="";

  void _selectedTab(int index) {
    setState(() {
      _lastSelected = 'TAB: $index';
    });
  }

  void _selectedFab(int index) {
    setState(() {
      _lastSelected = 'FAB: $index';
    });
  }
  int notificationCount = 0;

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();



    isLoggedIn().then((value){
      isLogIn = value;
      mLangaugeCode = languageCode;

      if(languageCode == "en"){
        _title = 'Home';
      }else{
        _title = 'الرئيسية';
      }
      print('title---> ${_title}');
    }).whenComplete(() {
      if(isLogIn){
        getLoginModel().then((value){
          setState(() {
            mLangaugeCode = languageCode;

            if(languageCode == "en"){
              _title = 'Home';
            }else{
              _title = 'الرئيسية';
            }
            print('title---> ${_title}');
            loginModel = value;

          });

        });
      }else{
        mLangaugeCode = languageCode;

        if(languageCode == "en"){
          _title = 'Home';
        }else{
          _title = 'الرئيسية';
        }
        print('title---> ${_title}');
        loginModel = null;
        setState(() {

        });
      }

    });
  }
  Future<bool> isLoggedIn() async{
    SharedPreferences sharedPref =await SharedPreferences.getInstance();
    bool isLoggedIn =  sharedPref.getBool(kIsLogin)??false;
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;

    if(languageCode == "en"){
      _title = 'Home';
    }else{
      _title = 'الرئيسية';
    }
    Provider.of<TitleProvider>(context,listen: false).addCount(_title);
    print('isLogIn ${isLoggedIn}');
    return isLoggedIn;
  }
  Future<LoginModel?> getLoginModel() async{

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String loginData = sharedPreferences.getString(kUserModel)??"";
    String languageCode = sharedPreferences.getString(LANG_CODE) ?? ENGLISH;
    if(languageCode == "en"){
      _title = 'Home';
    }else{
      _title = 'الرئيسية';
    }
    Provider.of<TitleProvider>(context,listen: false).addCount(_title);
if(loginData != null) {
  final body = json.decode(loginData);
  print('body --->${body}');

   loginModel = LoginModel.fromJson(body);
}
    SharedPreferences _preferences = await SharedPreferences.getInstance();

    int count = _preferences.getInt("notificationCount")??0;
    String appBadgeSupported;
    // Map mapped = {
    //   "id":loginModel.data.id,
    //   "language":languageCode
    // };

    // PetMartService petMartService = PetMartService();
    // NotificationModel notificationModel =await petMartService.notification(mapped);
    // int  notificationNumber = notificationModel.data.length;

    // notificationCount = notificationNumber-count;
    notificationCount =0;
    // try {
    //   bool res = await FlutterAppBadger.isAppBadgeSupported();
    //   if (res) {
    //     FlutterAppBadger.updateBadgeCount(notificationCount);
    //     appBadgeSupported = 'Supported';
    //   } else {
    //     appBadgeSupported = 'Not supported';
    //   }
    // } on PlatformException {
    //   appBadgeSupported = 'Failed to get badge support.';
    // }
    Provider.of<NotificationNotifier>(context,listen: false).addCount(notificationCount);
    print("notificationCount ---->${notificationCount}");
    return loginModel;
  }
  Future<HomeModel?> home() async{

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? loginData = sharedPreferences.getString(kUserModel);
    String deviceToken =sharedPreferences.getString("token")??"";
    print('loginData --> ${loginData}');
    LoginModel?  loginModel ;
    bool isLoggedIn =  sharedPreferences.getBool(kIsLogin)??false;
    String? uniqueId;
    if(isLoggedIn){

      String token =deviceToken;
      final body = json.decode(loginData!);
      String? fullName = sharedPreferences.getString('email');
      String? password= sharedPreferences.getString('password');
      SharedPreferences _preferences = await SharedPreferences.getInstance();
      String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;



      PetMartService petMartService = PetMartService();
      String deviceType="";

      if(Platform.isAndroid){
        deviceType = "a";
        uniqueId = await UniqueIdentifier.serial;
      }else{
        deviceType = "i";
        final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
        var data = await deviceInfoPlugin.iosInfo;
        uniqueId = data.identifierForVendor;
      }

      Map<String,dynamic> map = {
        'email':fullName,
        'password':password,
        'device_token':token,
        'imei_number': uniqueId,
        'device_type': deviceType,
        'language':languageCode


      };
      loginModel = await petMartService.loginModel(map);
      String? mStatus = loginModel!.status;
      if(mStatus!.trim() == 'success') {
        SharedPref sharedPref = SharedPref();
        await sharedPref.save(kUserModel, loginModel);
        await sharedPref.saveBool(kIsLogin, true);
        await sharedPref.saveString("emil", fullName);
        await sharedPref.saveString("password", password);
      }







    }

    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
    Map map ;
    String? id ="";
    if(loginModel == null){
     id ="";
    }else{
      id= loginModel.data!.id;

    }


    PetMartService petMartService = PetMartService();

    HomeModel? home = await petMartService.home(id!);
    return home;
  }
  String _title = '' ;


  @override
  Widget build(BuildContext context) {

    if(isStart){

      isStart = false;
    }
    // _title = getTranslated(context, 'home');
    return
      ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Scaffold(
        appBar:
        AppBar(
          centerTitle: true,
          title:
          Consumer<TitleProvider>(
            builder: (context, count, child){
              return   Text(

                count.title,
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: screenUtil.setSp(16),
                    fontWeight: FontWeight.bold
                ),
              );
            },
          ),

          backgroundColor: kMainColor,
           leading: Builder(
            builder: (BuildContext context) {
    return
        IconButton(
    icon: const Icon(Icons.menu,color: Color(0xFFFFFFFFF),),
    onPressed: () {
    Scaffold.of(context).openDrawer();
    },
    tooltip: MaterialLocalizations
          .of(context)
          .openAppDrawerTooltip,
    );
    },
    ),
          actions: [
            GestureDetector(
              onTap: (){
                Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
                  return new SearcgScreen();
                }));
              },
              child: Padding(
                padding: EdgeInsets.all(4.h),
                child: ImageIcon(
                  AssetImage('assets/images/img_search.png'
                  ),
                  color: Colors.white,
                ),
              ),
            ),
            Consumer<NotificationNotifier>(
              builder: (context, count, child){
                return   GestureDetector(
                  onTap: ()async{

                    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                    bool isLoggedIn = sharedPreferences.getBool(kIsLogin)??false;
                    int notifcationCount = 0;
                    if(isLoggedIn){

                      Navigator.pushNamed(context, PushNotificationScreen.id);
                    }else{
                      ShowLoginAlertDialog(context,getTranslated(context, 'not_login')!);
                    }

                  },
                  child: Padding(
                      padding: EdgeInsets.all(4.h),
                      child: NamedIcon(notificationCount: isLogIn?count.notifcationCount:0,)
                  ),
                );
              },
            )



          ],

        ),
        drawer: isLogIn?
            loginModel!= null?loggedDrawer(context,loginModel!):

        Container():visitorDrawer(context),

        body:
         IndexedStack(
          index: index,
          children: [




            Navigator(
              key: _homeScreen,
              onGenerateRoute: (route) => MaterialPageRoute(
                settings: route,
                maintainState: false,
                builder: (context) => HomeScreen(),
              ),

            ),
            Navigator(
              key: _competitionNewsScreen,
              onGenerateRoute: (route) => MaterialPageRoute(
                settings: route,
                maintainState: false,
                builder: (context) => AdaptionScreen(),
              ),
            ),

            Navigator(
              key: _amateursNews,
              onGenerateRoute: (route) => MaterialPageRoute(
                settings: route,
                maintainState: false,
                builder: (context) => LostScreen(),
              ),
            ),
            Navigator(
              key: _vediosScreen,
              onGenerateRoute: (route) => MaterialPageRoute(
                settings: route,
                maintainState: false,
                builder: (context) => AuctionScreen(),
              ),
            ),



          ],
        ),
        bottomNavigationBar: FABBottomAppBar(


          backgroundColor: kMainColor,
          centerItemText: getTranslated(context, 'add_post')!,

          color: Color(0xFFFFFFFF),
          selectedColor: Color(0xFFFFFFFF),
          notchedShape: CircularNotchedRectangle(),

          onTabSelected: (val) {

            return  _onTap(val, context);
          },
          items: [





            FABBottomAppBarItem(iconPath:'assets/images/img_home.png', text: getTranslated(context, 'home')!),
            FABBottomAppBarItem(iconPath:'assets/images/img_adoption.png', text: getTranslated(context, 'adaption')!),
            FABBottomAppBarItem(iconPath: 'assets/images/img_lost_animal.png', text: getTranslated(context, 'lost')!),
            FABBottomAppBarItem(iconPath:
            'assets/images/img_auction.png', text: getTranslated(context, 'auction')!),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _buildFab(
            context), // This trailing comma makes auto-formatting nicer for build methods.
    ),
      );
  }

  Drawer visitorDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        color: kMainColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 200.h,


              color: Color(0xFFFFFFFF),
              child:  Center(
                child: Container(
                  height: 80.h,
                    width: 80.h,
                    child: Image.asset('assets/images/img_language_logo.png')),
              )
                        ),
            ListTile(
              onTap: (){
                Navigator.pop(context);
                ShowLanguageDialog(context);
              },

              title: Text(getTranslated(context, 'select_language')!,
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: screenUtil.setSp(17),
                    fontWeight: FontWeight.normal
                ),),
            ),
            ListTile(
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, ContactUsScreen.id);

              },

              title: Text(getTranslated(context,'contact_us' )!,
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: screenUtil.setSp(17),
                    fontWeight: FontWeight.normal
                ),),
            ),
            ListTile(
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, TermsScreen.id);

              },

              title: Text(getTranslated(context, 'terms_conditions')!,
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: screenUtil.setSp(17),
                    fontWeight: FontWeight.normal
                ),),
            ),
            ListTile(
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, PrivacyScreen.id);

              },

              title: Text(getTranslated(context, 'privacy_policy')!,
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: screenUtil.setSp(17),
                    fontWeight: FontWeight.normal
                ),),
            ),
            ListTile(
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, LoginScreen.id);

              },

              title: Text(getTranslated(context, 'login')!,
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: screenUtil.setSp(17),
                    fontWeight: FontWeight.normal
                ),),
            ),
          ],
        ),

      ),

    );
  }
  Drawer loggedDrawer(BuildContext context,LoginModel loginModel) {
    return Drawer(
      child: Container(
        color: kMainColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
                height: 200.h,


                color: Color(0xFFFFFFFF),
                child:  Stack(
                  children: [
                    Positioned.directional(
                      textDirection:  Directionality.of(context),
                      top: 0,
                      end: 0,
                      start: 0,
                      bottom: 0,
                      child: Center(
                        child: Container(
                            height: 80.h,
                            width: 80.h,
                            child: Image.asset('assets/images/img_language_logo.png')),
                      ),
                    ),
                    // Positioned.directional(   textDirection:  Directionality.of(context),
                    //     bottom: 0,
                    //     start: 0,
                    //
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Padding(
                    //
                    //
                    //           padding: EdgeInsetsDirectional.only(start: 4.h),
                    //           child: Text('${getTranslated(context, 'current_credit')}${loginModel.data.availableCredit}',
                    //
                    //           style: TextStyle(
                    //             color: Color(0xFF000000),
                    //             fontSize: screenUtil.setSp(16),
                    //             fontWeight: FontWeight.bold
                    //           ),),
                    //         ),
                    //         Padding(
                    //           padding: EdgeInsetsDirectional.only(start: 4.h),
                    //           child: Text('${getTranslated(context, 'credit_expiry')}${loginModel.data.expiryDate}',
                    //
                    //             style: TextStyle(
                    //                 color: Color(0xFF000000),
                    //                 fontSize: screenUtil.setSp(16),
                    //                 fontWeight: FontWeight.bold
                    //             ),),
                    //         ),
                    //       ],
                    //     ))
                  ],
                )
            ),
            ListTile(
              onTap: (){
                Navigator.pop(context);
                Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
                  return new MyAccountScreen(isFromPayment: false,paymentId: "",);
                }));

              },

              title: Text(getTranslated(context, 'my_account')!,
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: screenUtil.setSp(17),
                    fontWeight: FontWeight.normal
                ),),
            ),
            ListTile(
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, MyPostScreen.id);
              },

              title: Text(getTranslated(context, 'my_post')!,
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: screenUtil.setSp(17),
                    fontWeight: FontWeight.normal
                ),),
            ),
            // ListTile(
            //   onTap: (){
            //     Navigator.pop(context);
            //     Navigator.pushNamed(context, MyAuctionScreen.id);
            //   },
            //
            //   title: Text(getTranslated(context, 'my_auction'),
            //     style: TextStyle(
            //         color: Color(0xFFFFFFFF),
            //         fontSize: screenUtil.setSp(17),
            //         fontWeight: FontWeight.normal
            //     ),),
            // ),
            // ListTile(
            //   onTap: (){
            //     Navigator.pop(context);
            //     Navigator.pushNamed(context, OrdersScreen.id);
            //   },
            //
            //   title: Text(getTranslated(context, 'order'),
            //     style: TextStyle(
            //         color: Color(0xFFFFFFFF),
            //         fontSize: screenUtil.setSp(17),
            //         fontWeight: FontWeight.normal
            //     ),),
            // ),
            ListTile(
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, PushNotificationScreen.id);
              },

              title: Text(getTranslated(context, 'push_notification')!,
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: screenUtil.setSp(17),
                    fontWeight: FontWeight.normal
                ),),
            ),
            ListTile(
              onTap: (){
                Navigator.pop(context);
                ShowLanguageDialog(context);
              },

              title: Text(getTranslated(context, 'select_language')!,
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: screenUtil.setSp(17),
                    fontWeight: FontWeight.normal
                ),),
            ),
            ListTile(
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, ChangePasswordScreen.id);

              },

              title: Text(getTranslated(context, 'change_password')!,
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: screenUtil.setSp(17),
                    fontWeight: FontWeight.normal
                ),),
            ),
            ListTile(
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, ContactUsScreen.id);

              },

              title: Text(getTranslated(context, 'contact_us')!,
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: screenUtil.setSp(17),
                    fontWeight: FontWeight.normal
                ),),
            ),
            ListTile(
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, TermsScreen.id);

              },

              title: Text(getTranslated(context, 'terms_conditions')!,
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: screenUtil.setSp(17),
                    fontWeight: FontWeight.normal
                ),),
            ),
            ListTile(
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, PrivacyScreen.id);

              },

              title: Text(getTranslated(context, 'privacy_policy')!,
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: screenUtil.setSp(17),
                    fontWeight: FontWeight.normal
                ),),
            ),
            ListTile(
              onTap: (){
                logout(context).then((value) {
                  setState(() {
                    isLogIn = value!;
                    Navigator.pushReplacementNamed(context, MainScreen.id);
                    print('log---> ${isLogIn}');
                  });
                });
                Navigator.pop(context);

                // Navigator.pushNamed(context, LoginScreen.id);

              },

              title: Text(getTranslated(context, 'log_out')!,
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: screenUtil.setSp(17),
                    fontWeight: FontWeight.normal
                ),),
            ),

          ],
        ),

      ),

    );
  }
  void deleteUser() async{

      final modelHud = Provider.of<ModelHud>(context,listen: false);
      modelHud.changeIsLoading(true);

      SharedPreferences _preferences = await SharedPreferences.getInstance();
      String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;

      PetMartService petMartService = PetMartService();
      String deviceType="";
      String? loginData = _preferences.getString(kUserModel);



      final body = json.decode(loginData!);
   LoginModel   loginModel = LoginModel.fromJson(body);
    String?  mUser = loginModel.data!.id;

      DeleteUserModel?  deleteUserModel = await petMartService.deleteUser(mUser!);


      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setBool(kIsLogin, false);
      sharedPreferences.remove(kUserModel);
      modelHud.changeIsLoading(false);
      Navigator.pushReplacementNamed(context, LoginScreen.id);


    }

  Widget _buildFab(BuildContext context) {
    final icons = [ Icons.sms, Icons.mail, Icons.phone ];
    return  FloatingActionButton(
        onPressed: () {
          createAdd(context);

          },
        tooltip: 'Increment',
        child: Image.asset('assets/images/img_add_post.png'),
        elevation: 2.0,
      );

  }
  void _onTap(int val, BuildContext context) {
    if (index == val) {
      switch (val) {
        case 0:
          print(val);
          _title=getTranslated(context, 'home')!;
          _homeScreen.currentState!.popUntil((route) => route.isFirst);

          setState(() {

          });

          break;
        case 1:
          print(val);
          _title=getTranslated(context, 'adaption')!;
          _competitionNewsScreen.currentState!.popUntil((route) => route.isFirst);

          WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {

          }));

          break;
        case 2:
          print(val);
          _title=getTranslated(context, 'lost')!;
          _amateursNews.currentState!.popUntil((route) => route.isFirst);

           setState(() {

          });
          break;
        case 3:
          print(val);
          _title=getTranslated(context, 'auction')!;
          setState(() {

          });
          _vediosScreen.currentState!.popUntil((route) => route.isFirst);


          break;

        default:
      }
    }
    else {
      index = val;
      if(index ==3){
        _title=getTranslated(context, 'auction')!;
        _vediosScreen.currentState!.pushReplacementNamed(AuctionScreen.id);
        setState(() {

        });

      }else if(index == 2){
        _title=getTranslated(context, 'lost')!;
        _amateursNews.currentState!.pushReplacementNamed(LostScreen.id);
         setState(() {

        });

      }else if(index == 1){
        _title=getTranslated(context, 'adaption')!;
        _competitionNewsScreen.currentState!.pushReplacementNamed(AdaptionScreen.id);
         setState(() {

        });

      }else if(index == 0){
        _title=getTranslated(context, 'home')!;
        _homeScreen.currentState!.pushReplacementNamed(HomeScreen.id);
         setState(() {

        });

      }
      index = val;
      print('index ${index}');
      print(_title);


    }
    Provider.of<TitleProvider>(context,listen: false).addCount(_title);
  }
  Future<void> ShowLanguageDialog(BuildContext context) async{
    var alert;
    var alertStyle = AlertStyle(

      animationType: AnimationType.fromBottom,
      isCloseButton: true,
      isOverlayTapDismiss: true,
      descStyle: TextStyle(fontWeight: FontWeight.normal,
          color: Color(0xFF0000000),
          fontSize: screenUtil.setSp(18)),
      descTextAlign: TextAlign.start,
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
          color: Color(0xFF000000),
          fontWeight: FontWeight.normal,
          fontSize: screenUtil.setSp(16)
      ),
      alertAlignment: AlignmentDirectional.center,
    );
    alert =   Alert(
      context: context,
      style: alertStyle,

      title: getTranslated(context, 'select_language'),


      buttons: [
        DialogButton(
          child: Text(
            getTranslated(context, 'english')!,
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: screenUtil.setSp(18)),
          ),
          onPressed: ()async{
            await alert.dismiss();
            _changeLanguage('en').then((value) {
              Navigator.of(context).pushReplacementNamed( MainScreen.id);
            });


          },
          color: Color(0xFFFFC300),
          radius: BorderRadius.circular(6.w),
        ),
        DialogButton(
          child: Text(
            getTranslated(context, 'arabic')!,
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: screenUtil.setSp(18)),
          ),
          onPressed: ()async {
            await alert.dismiss();
            _changeLanguage('ar').then((value) {
              Navigator.of(context).pushReplacementNamed( MainScreen.id);
            });
          },
          color: Color(0xFFFFC300),
          radius: BorderRadius.circular(6.w),
        )
      ],
    );
    alert.show();

  }
  Future<void> DeleteDialog(BuildContext context) async{
    var alert;
    var alertStyle = AlertStyle(

      animationType: AnimationType.fromBottom,
      isCloseButton: true,
      isOverlayTapDismiss: true,
      descStyle: TextStyle(fontWeight: FontWeight.normal,
          color: Color(0xFF0000000),
          fontSize: screenUtil.setSp(18)),
      descTextAlign: TextAlign.start,
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
          color: Color(0xFF000000),
          fontWeight: FontWeight.normal,
          fontSize: screenUtil.setSp(16)
      ),
      alertAlignment: AlignmentDirectional.center,
    );
    alert =   Alert(
      context: context,
      style: alertStyle,

      title: getTranslated(context, 'delete_account'),


      buttons: [
        DialogButton(
          child: Text(
            getTranslated(context, 'yes')!,
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: screenUtil.setSp(18)),
          ),
          onPressed: ()async{
            await alert.dismiss();
            deleteUser();



          },
          color: Color(0xFFFFC300),
          radius: BorderRadius.circular(6.w),
        ),
        DialogButton(
          child: Text(
            getTranslated(context, 'no')!,
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: screenUtil.setSp(18)),
          ),
          onPressed: ()async {
            await alert.dismiss();

          },
          color: Color(0xFFFFC300),
          radius: BorderRadius.circular(6.w),
        )
      ],
    );
    alert.show();

  }
  Future<void> _changeLanguage(String language) async {
    Locale _temp = await setLocale( language);
    MyApp.setLocale(context, _temp);



  }

  Future<bool?> logout(BuildContext context) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(kIsLogin, false);
    sharedPreferences.remove(kUserModel);

    
    return sharedPreferences.getBool(kIsLogin);

  }
  Future<CheckCreditModel?> checkCreditModel() async{



    Map map ;


    map = {"user_id":loginModel!.data!.id};





    PetMartService petMartService = PetMartService();
    CheckCreditModel? creditModel = await petMartService.checkCredit(map);
    return creditModel;
  }
  Future<void> ShowAlertDialog(BuildContext context ,String title) async{
    var alert;
    var alertStyle = AlertStyle(

      animationType: AnimationType.fromBottom,
      isCloseButton: true,
      isOverlayTapDismiss: true,
      descStyle: TextStyle(fontWeight: FontWeight.normal,
          color: Color(0xFF0000000),
          fontSize: screenUtil.setSp(18)),
      descTextAlign: TextAlign.start,
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
          color: Color(0xFF000000),
          fontWeight: FontWeight.normal,
          fontSize: screenUtil.setSp(16)
      ),
      alertAlignment: AlignmentDirectional.center,
    );
    alert =   Alert(
      context: context,
      style: alertStyle,

      title: title,


      buttons: [

        DialogButton(
          child: Text(
            getTranslated(context, 'ok')!,
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: screenUtil.setSp(18)),
          ),
          onPressed: ()async {
            await alert.dismiss();

          },
          color: Color(0xFFFFC300),
          radius: BorderRadius.circular(6.w),
        )
      ],
    );
    alert.show();

  }
  createAdd(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isLoggedIn = sharedPreferences.getBool(kIsLogin)??false;
    if(isLoggedIn){
      Navigator.of(context,rootNavigator: true).pushNamed(AddAdvertiseScreen.id);
    }else{
      ShowLoginAlertDialog(context,getTranslated(context, 'not_login')!);
    }

  }
  Future<void> ShowLoginAlertDialog(BuildContext context ,String title) async{
    var alert;
    var alertStyle = AlertStyle(

      animationType: AnimationType.fromBottom,
      isCloseButton: true,
      isOverlayTapDismiss: true,
      descStyle: TextStyle(fontWeight: FontWeight.normal,
          color: Color(0xFF0000000),
          fontSize: screenUtil.setSp(18)),
      descTextAlign: TextAlign.start,
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
          color: Color(0xFF000000),
          fontWeight: FontWeight.normal,
          fontSize: screenUtil.setSp(16)
      ),
      alertAlignment: AlignmentDirectional.center,
    );
    alert =   Alert(
      context: context,
      style: alertStyle,

      title: title,


      buttons: [

        DialogButton(
          child: Text(
            getTranslated(context, 'reg_now')!,
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: screenUtil.setSp(18)),
          ),
          onPressed: ()async {
            await alert.dismiss();
            Navigator.of(context,rootNavigator: true).pushReplacement(new MaterialPageRoute(builder: (BuildContext context){
              return new LoginScreen();
            }));
            // Navigator.pushReplacementNamed(context,LoginScreen.id);

          },
          color: Color(0xFFFFC300),
          radius: BorderRadius.circular(6.w),
        ),

      ],
    );
    alert.show();

  }

  myMessages(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isLoggedIn = sharedPreferences.getBool(kIsLogin)??false;
    if(isLoggedIn){
      Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
        return new MyMessagesScreen();
      }));

    }else{
      ShowLoginAlertDialog(context,getTranslated(context, 'not_login')!);
    }

  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
