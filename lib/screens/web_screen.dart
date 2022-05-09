import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:provider/provider.dart';

import '../providers/model_hud.dart';
import '../utilities/constants.dart';



class WebScreen extends StatefulWidget {
  String url;
  String name;
  WebScreen({Key key,@required this.url,@required this.name,}) : super(key: key);

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  ScreenUtil screenUtil = ScreenUtil();
  bool isLoading=true;
  final _key = UniqueKey();
  InAppWebViewController webView;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.url);
  }
  @override
  Widget build(BuildContext context) {
    final modelHud = Provider.of<ModelHud>(context,listen: false);
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar:  AppBar(
        backgroundColor: kMainColor,
        title: Container(
          alignment: AlignmentDirectional.center,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10.h),
            child: Text(
             widget.name,
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
          onLoadStop: (InAppWebViewController controller, Uri url)  {



          },
        ) ,
      ),


    );
  }
}