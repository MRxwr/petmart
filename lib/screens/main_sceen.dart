

import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/check_credit_model.dart';
import 'package:pet_mart/model/login_model.dart';
import 'package:pet_mart/providers/model_hud.dart';
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
import 'package:pet_mart/widgets/fab_bottom_app_bar.dart';
import 'package:pet_mart/widgets/fab_with_icons.dart';
import 'package:pet_mart/widgets/layout.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'auction_screen.dart';
class MainScreen extends StatefulWidget {
  static String id = 'MainScreen';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String _lastSelected = 'TAB: 0';
  final _homeScreen = GlobalKey<NavigatorState>();
  final _competitionNewsScreen = GlobalKey<NavigatorState>();
  final _amateursNews = GlobalKey<NavigatorState>();
  final _vediosScreen = GlobalKey<NavigatorState>();
  final _salesScreen = GlobalKey<NavigatorState>();

  ScreenUtil screenUtil = ScreenUtil();
  bool isLogIn = false;
  LoginModel loginModel;
  int index =3;
  final navigatorKey = GlobalKey<NavigatorState>();

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoggedIn().then((value){
      isLogIn = value;
    }).whenComplete(() {
      getLoginModel().then((value){
        setState(() {
          loginModel = value;
        });

      });
    });
  }
  Future<bool> isLoggedIn() async{
    SharedPreferences sharedPref =await SharedPreferences.getInstance();
    bool isLoggedIn =  sharedPref.getBool(kIsLogin)??false;
    print('isLogIn ${isLoggedIn}');
    return isLoggedIn;
  }
  Future<LoginModel> getLoginModel() async{

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String loginData = sharedPreferences.getString(kUserModel);

    final body = json.decode(loginData);
    LoginModel   loginModel = LoginModel.fromJson(body);
    return loginModel;
  }
  String title = 'Home';

  @override
  Widget build(BuildContext context) {
    return
      ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            title,
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: screenUtil.setSp(16),
              fontWeight: FontWeight.bold
            ),
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
            GestureDetector(
              onTap: (){
                myMessages(context);
              },
              child: Padding(
                padding: EdgeInsets.all(4.h),
                child: ImageIcon(
                  AssetImage('assets/images/img_msg.png'
                  ),size: 20.h,
                  color: Colors.white,
                ),
              ),
            )


          ],

        ),
        drawer: isLogIn?
        loggedDrawer(context,loginModel):visitorDrawer(context),

        body:
        IndexedStack(
          index: index,
          children: [
            Navigator(
              key: _vediosScreen,
              onGenerateRoute: (route) => MaterialPageRoute(
                settings: route,
                builder: (context) => AuctionScreen(),
              ),
            ),
            Navigator(
              key: _amateursNews,
              onGenerateRoute: (route) => MaterialPageRoute(
                settings: route,
                builder: (context) => LostScreen(),
              ),
            ),
            Navigator(
              key: _competitionNewsScreen,
              onGenerateRoute: (route) => MaterialPageRoute(
                settings: route,
                builder: (context) => AdaptionScreen(),
              ),
            ),
            Navigator(
              key: _homeScreen,
              onGenerateRoute: (route) => MaterialPageRoute(
                settings: route,
                builder: (context) => HomeScreen(),
              ),
            ),





          ],
        ),
        bottomNavigationBar: FABBottomAppBar(


          backgroundColor: kMainColor,
          centerItemText: 'Add Post',

          color: Color(0xFFFFFFFF),
          selectedColor: Color(0xFFFFFFFF),
          notchedShape: CircularNotchedRectangle(),

          onTabSelected: (val) {
            return  _onTap(val, context);
          },
          items: [

            FABBottomAppBarItem(iconPath:
            'assets/images/img_auction.png', text: 'Auction'),
            FABBottomAppBarItem(iconPath: 'assets/images/img_lost_animal.png', text: 'Lost'),

            FABBottomAppBarItem(iconPath:'assets/images/img_adoption.png', text: 'Adaption'),
            FABBottomAppBarItem(iconPath:'assets/images/img_home.png', text: 'Home'),

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

              title: Text('Select Language',
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

              title: Text('Contact Us',
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

              title: Text('Terms and Conditions',
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

              title: Text('Privacy Policy',
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

              title: Text('Login',
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
                    Positioned.directional(   textDirection:  Directionality.of(context),
                        bottom: 0,
                        start: 0,

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(

                              
                              padding: EdgeInsetsDirectional.only(start: 4.h),
                              child: Text('Current credit : ${loginModel.data.availableCredit}',

                              style: TextStyle(
                                color: Color(0xFF000000),
                                fontSize: screenUtil.setSp(16),
                                fontWeight: FontWeight.bold
                              ),),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.only(start: 4.h),
                              child: Text('Credit expiry : ${loginModel.data.lastLogin}',

                                style: TextStyle(
                                    color: Color(0xFF000000),
                                    fontSize: screenUtil.setSp(16),
                                    fontWeight: FontWeight.bold
                                ),),
                            ),
                          ],
                        ))
                  ],
                )
            ),
            ListTile(
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, MyAccountScreen.id);

              },

              title: Text('My Account',
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

              title: Text('My Post',
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: screenUtil.setSp(17),
                    fontWeight: FontWeight.normal
                ),),
            ),
            ListTile(
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, MyAuctionScreen.id);
              },

              title: Text('My Auction',
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: screenUtil.setSp(17),
                    fontWeight: FontWeight.normal
                ),),
            ),
            ListTile(
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, OrdersScreen.id);
              },

              title: Text('Order',
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: screenUtil.setSp(17),
                    fontWeight: FontWeight.normal
                ),),
            ),
            ListTile(
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, PushNotificationScreen.id);
              },

              title: Text('Push Notification',
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

              title: Text('Select Language',
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

              title: Text('Change Password',
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

              title: Text('Contact Us',
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

              title: Text('Terms and Conditions',
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

              title: Text('Privacy Policy',
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
                    isLogIn = value;
                    print('log---> ${isLogIn}');
                  });
                });
                Navigator.pop(context);

                // Navigator.pushNamed(context, LoginScreen.id);

              },

              title: Text('Logout',
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
        case 3:
          print(val);

          _homeScreen.currentState.popUntil((route) => route.isFirst);
          setState(() {

          });

          break;
        case 2:
          print(val);
          _competitionNewsScreen.currentState.popUntil((route) => route.isFirst);
          setState(() {

          });

          break;
        case 1:
          print(val);
          _amateursNews.currentState.popUntil((route) => route.isFirst);
          setState(() {

          });
          break;
        case 0:
          print(val);
          _vediosScreen.currentState.popUntil((route) => route.isFirst);
          setState(() {

          });
          break;

        default:
      }
    } else {
      if (mounted) {
        setState(() {
          index = val;
          if(index ==0){
            title='AUCTION';
          }else if(index == 1){
            title='LOST';
          }else if(index == 2){
            title='ADAPTION';
          }else if(index == 3){
            title='HOME';
          }
          print('index ${index}');
        });
      }
    }
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

      title: "Select Language",


      buttons: [
        DialogButton(
          child: Text(
            "English",
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
            "Arabic",
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
  Future<void> _changeLanguage(String language) async {
    Locale _temp = await setLocale( language);
    MyApp.setLocale(context, _temp);



  }

  Future<bool> logout(BuildContext context) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(kIsLogin, false);
    
    return sharedPreferences.getBool(kIsLogin);

  }
  Future<CheckCreditModel> checkCreditModel() async{



    Map map ;


    map = {"user_id":loginModel.data.customerId};





    PetMartService petMartService = PetMartService();
    CheckCreditModel creditModel = await petMartService.checkCredit(map);
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
            "Ok",
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
      final modelHud = Provider.of<ModelHud>(context,listen: false);
      modelHud.changeIsLoading(true);
      checkCreditModel().then((value){
        modelHud.changeIsLoading(false);
        int credit = int.parse(value.data.credit);
        print('credit --->${credit}');

        if(credit>0){
          Navigator.of(context,rootNavigator: true).pushNamed(AddAdvertiseScreen.id);

        }else{
          ShowAlertDialog(context, value.message);
        }
      });
      print("true");
    }else{
      ShowLoginAlertDialog(context,"You're Not Logged In, Logged In First");
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
            "Ok",
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
        DialogButton(
          child: Text(
            "No",
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: screenUtil.setSp(18)),
          ),
          onPressed: ()async {
            await alert.dismiss();

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
      ShowLoginAlertDialog(context,"You're Not Logged In, Logged In First");
    }

  }
}
