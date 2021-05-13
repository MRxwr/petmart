import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_mart/utilities/constants.dart';
class MyAuctionScreen extends StatefulWidget {
  static String id = 'MyAuctionScreen';
  @override
  _MyAuctionScreenState createState() => _MyAuctionScreenState();
}

class _MyAuctionScreenState extends State<MyAuctionScreen> {
  ScreenUtil screenUtil = ScreenUtil();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(
        backgroundColor: kMainColor,
        title: Container(
          alignment: AlignmentDirectional.center,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10.h),
            child: Text(
              'My Auction',
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

        ],

      ),
      backgroundColor: Color(0xFFFFFFFF),
      body: Container(

      ),
    );
  }
}
