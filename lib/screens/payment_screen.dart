import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:my_fatoorah/my_fatoorah.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/PostPaymentModel.dart';
import 'package:pet_mart/model/SuccessModel.dart';
import 'package:pet_mart/model/login_model.dart';
import 'package:pet_mart/model/package_model.dart'as Model;
import 'package:pet_mart/model/payment_model.dart';
import 'package:pet_mart/providers/model_hud.dart' as Hud;
import 'package:pet_mart/screens/my_account_screen.dart';
import 'package:pet_mart/screens/splash_screen.dart';


import 'package:pet_mart/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../providers/model_hud.dart';
import 'main_sceen.dart';
const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';


class PaymentScreen extends StatefulWidget {
  Model.Package  packageModel;
  String url ;
  String id;
  PaymentScreen({Key key,@required this.packageModel,this.url,this.id}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String mLanguage;
  ScreenUtil screenUtil = ScreenUtil();

  PostPaymentModel paymentModel;


  String mUrl ='';
  // Future<PaymentModel> payment()async {
  //   SharedPreferences _preferences = await SharedPreferences.getInstance();
  //   String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
  //   String loginData = _preferences.getString(kUserModel);
  //   final body = json.decode(loginData);
  //   LoginModel   loginModel = LoginModel.fromJson(body);
  //  Map map = {
  //     'package_id': widget.packageModel.id,
  //     'user_id': loginModel.data.id,
  //    'language':languageCode,
  //    'address':''
  //
  //   };
  //  print("pay map -->"+map.toString());
  //   PetMartService petMartService = PetMartService();
  //   PaymentModel paymentModel =await petMartService.payment(map);
  //   String url = paymentModel.paymentUrl;
  //   return paymentModel;
  // }





  @override
  void initState() {
    super.initState();
    print(widget.url);

    // payment().then((value) {
    //   setState(() {
    //     paymentModel = value;
    //   });
    // });
  }




  Future<void> showFailDialog() {
    SweetAlert.show(context,
        title: getTranslated(context, 'fail'),
        subtitle: getTranslated(context, 'payment_fail'),
        showCancelButton: false,
        confirmButtonColor: Color(0xFFFF0000),
        confirmButtonText: getTranslated(context, 'go_to_credit'),
        style: SweetAlertStyle.error,
        onPress: (bool isConfirm) {




         Navigator.pop(context);
          return true;
        });
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return ModalProgressHUD(
      inAsyncCall: Provider.of<ModelHud>(context).isLoading,
      child: Scaffold(
        backgroundColor: Color(0xFFFFFFFF),

        body: Container(
          child:    InAppWebView(

            initialUrlRequest:
            URLRequest(url: Uri.parse(widget.url)),


            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(


                preferredContentMode: UserPreferredContentMode.MOBILE,

              ),
            ),
            onWebViewCreated: (InAppWebViewController controller) {

            },


            onLoadStart: (InAppWebViewController controller, Uri url) {

            },
            onLoadStop: (InAppWebViewController controller, Uri url)  async{

              if(url.toString().toLowerCase().contains('https://createkwservers.com/petmart2/request/index.php?action=success')){

                Navigator.of(context,rootNavigator: true).pushReplacement(new MaterialPageRoute(builder: (BuildContext context){
                  return new MyAccountScreen(paymentId: widget.id,isFromPayment: true,);
                }));

              }else if(url.toString().toLowerCase().contains('https://createkwservers.com/petmart2/request/index.php?action=failure')){

                Navigator.pop(context,"true");

              }

            },
          ) ,
        ),


      ),
    );
  }
}
