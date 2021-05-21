import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:my_fatoorah/my_fatoorah.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/login_model.dart';
import 'package:pet_mart/model/package_model.dart'as Model;
import 'package:pet_mart/model/payment_model.dart';
import 'package:pet_mart/providers/model_hud.dart' as Hud;


import 'package:pet_mart/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'main_sceen.dart';
const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';


class PaymentScreen extends StatefulWidget {
  Model.Data  packageModel;
  PaymentScreen({Key key,@required this.packageModel}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String mLanguage;
  ScreenUtil screenUtil = ScreenUtil();
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  PaymentModel paymentModel;


  String mUrl ='';
  Future<PaymentModel> payment()async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
    String loginData = _preferences.getString(kUserModel);
    final body = json.decode(loginData);
    LoginModel   loginModel = LoginModel.fromJson(body);
   Map map = {
      'package_id': widget.packageModel.packageId,
      'user_id': loginModel.data.customerId,
     'language':languageCode,
     'address':''

    };
    PetMartService petMartService = PetMartService();
    PaymentModel paymentModel =await petMartService.payment(map);
    String url = paymentModel.paymentUrl;
    return paymentModel;
  }
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  final payPalLoginUrl = 'https://portal.myfatoorah.com/KWT/ie/0508417992821313968';



  @override
  void initState() {
    super.initState();
    flutterWebViewPlugin.onUrlChanged.listen((String url) {
      print('url ---> ${url}');
      if (url.contains('fail')) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Payment Fail")));

        flutterWebViewPlugin.close();
        Navigator.pop(context);
      }else if (url.contains('success')) {
        flutterWebViewPlugin.close();
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Payment Success")));

        Navigator.pushReplacementNamed(context,MainScreen.id);
      }
    });
    payment().then((value) {
      setState(() {
        paymentModel = value;
      });
    });
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void dispose() {
    flutterWebViewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return

      Scaffold(
        key: _scaffoldKey,

        body: Container(

        child:paymentModel== null?
        Container(

          color: Color(0xFFFFFFFF),
          child: CircularProgressIndicator(


          ),
          alignment: AlignmentDirectional.center,
        ):
        Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: 8.0),
          child: WebviewScaffold(
            url: paymentModel.paymentUrl,
            withZoom: true,
            withLocalStorage: true,
            hidden: true,
          ),
        ),
    ),
      );
  }
}
