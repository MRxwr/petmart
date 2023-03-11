import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
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

import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../providers/model_hud.dart';
import 'main_sceen.dart';
const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';


class PaymentScreen extends StatefulWidget {
  Model.Package  packageModel;
  String url ;
  String id;
  PaymentScreen({Key? key,required this.packageModel,required this.url,required this.id}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? mLanguage;
  ScreenUtil screenUtil = ScreenUtil();

  PostPaymentModel? paymentModel;


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




  Future<void> showFailDialog() async {
    ArtDialogResponse response =  ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.danger,
          title: getTranslated(context, 'fail'),
          text: getTranslated(context, 'payment_fail'),
          confirmButtonText: getTranslated(context, 'ok')!,
          confirmButtonColor: Color(0xFFFF0000),
          showCancelBtn: false,


        )
    );
    if(response.isTapConfirmButton) {
      Navigator.pop(context,true);
    }

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
        appBar:  AppBar(
          backgroundColor: kMainColor,
          title: Container(
            alignment: AlignmentDirectional.center,
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.h),
              child: Text(
                getTranslated(context, 'payment')!,
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: screenUtil.setSp(16),
                    fontWeight: FontWeight.bold

                ),


              ),
            ),
          ),
          leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);

            },
            child: Icon(Icons.arrow_back_ios_outlined,color: Colors.white,size: 20.h,),
          ),

          actions: [
            SizedBox(width: 30.h,)

          ],

        ),
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


            onLoadStart: (InAppWebViewController? controller, Uri? url) {

            },
            onLoadStop: (InAppWebViewController? controller, Uri? url)  async{
              print(url);

              if(url.toString().toLowerCase().contains('https://createkwservers.com/petmart2/request/index.php?action=success')){

                // Navigator.of(context,rootNavigator: true).pushReplacement(new MaterialPageRoute(builder: (BuildContext context){
                //   return new MyAccountScreen(paymentId: widget.id,isFromPayment: true,);
                // }));

                Navigator.pop(context,widget.id);
              }else if(url.toString().toLowerCase().contains('https://createkwservers.com/petmart2/request/index.php?action=failure')){
               Navigator.pop(context,"fail");


              }

            },
          ) ,
        ),


      ),
    );
  }
}
