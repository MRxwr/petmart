import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/order_model.dart';
import 'package:pet_mart/utilities/constants.dart';
class OrderDetailsScreen extends StatefulWidget {
  Order_history orderModel;
  OrderDetailsScreen({Key? key,required this.orderModel}): super(key: key);

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {

  ScreenUtil screenUtil = ScreenUtil();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: kMainColor,
        title: Container(
          alignment: AlignmentDirectional.center,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10.h),
            child: Text(
            getTranslated(context, 'order_details')!,
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
      body: ListView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,


        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          Container(
              margin: EdgeInsets.all(10.h),
              height: 200.h,
              width: 200.h,
              child:
              Center(child: Image.asset('assets/images/img_language_logo.png',fit: BoxFit.fill,))),
          SizedBox(height: 20.h,),
          Row(

            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(getTranslated(context, 'purchase_date')!,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: screenUtil.setSp(16),
                          fontWeight: FontWeight.normal
                      )
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child:
                Container(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('${widget.orderModel.packagePurchaseDate}',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: screenUtil.setSp(16),
                          fontWeight: FontWeight.normal
                      )
                  ),
                ),
              ),
            ],
          ),
          Row(

            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(getTranslated(context, 'payment_method')!,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: screenUtil.setSp(16),
                          fontWeight: FontWeight.normal
                      )
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child:
                Container(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('${widget.orderModel.paymentType}',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: screenUtil.setSp(16),
                          fontWeight: FontWeight.normal
                      )
                  ),
                ),
              ),
            ],
          ),
          Row(

            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(getTranslated(context, 'payment_id')!,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: screenUtil.setSp(16),
                          fontWeight: FontWeight.normal
                      )
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child:
                Container(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('${widget.orderModel.paymentId}',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: screenUtil.setSp(16),
                          fontWeight: FontWeight.normal
                      )
                  ),
                ),
              ),
            ],
          ),
          Row(

            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(getTranslated(context, 'transaction_id')!,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: screenUtil.setSp(16),
                          fontWeight: FontWeight.normal
                      )
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child:
                Container(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('${widget.orderModel.packageTransactionId}',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: screenUtil.setSp(16),
                          fontWeight: FontWeight.normal
                      )
                  ),
                ),
              ),
            ],
          ),
          Row(

            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(getTranslated(context, 'payment_amount')!,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: screenUtil.setSp(16),
                          fontWeight: FontWeight.normal
                      )
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child:
                Container(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('${widget.orderModel.packagePrice}',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: screenUtil.setSp(16),
                          fontWeight: FontWeight.normal
                      )
                  ),
                ),
              ),
            ],
          ),
          Row(

            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(getTranslated(context, 'payment_status')!,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: screenUtil.setSp(16),
                          fontWeight: FontWeight.normal
                      )
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child:
                Container(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('${widget.orderModel.paymentStatus}',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: screenUtil.setSp(16),
                          fontWeight: FontWeight.normal
                      )
                  ),
                ),
              ),
            ],
          ),
        ],
      ) ,
    );
  }
}
