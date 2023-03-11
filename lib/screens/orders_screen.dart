import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/login_model.dart';
import 'package:pet_mart/model/order_model.dart';
import 'package:pet_mart/screens/order_details_screen.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
class OrdersScreen extends StatefulWidget {
  static String id = 'OrdersScreen';
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  OrderModel? orderModel;

  ScreenUtil screenUtil = ScreenUtil();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orders().then((value) {
      setState(() {
        orderModel = value;
      });

    });
  }
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
              getTranslated(context, 'order')!,
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
        child: orderModel==null?
        Container(
          child: CircularProgressIndicator(


          ),
          alignment: AlignmentDirectional.center,
        ): orderModel!.status == 'fail'?
        Container(
          child: Text(
            orderModel!.message,
            style: TextStyle(
                color: Colors.black,
                fontSize: screenUtil.setSp(16),
                fontWeight: FontWeight.w600
            ),
          ),
          alignment: AlignmentDirectional.center,
        ):
        orderModel!.data.orderHistory.isEmpty?

        Container(
          child: Text(
            orderModel!.message,
            style: TextStyle(
                color: Colors.black,
                fontSize: screenUtil.setSp(16),
                fontWeight: FontWeight.w600
            ),
          ),
          alignment: AlignmentDirectional.center,
        )
            :
        ListView(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,


          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            Container(
              margin: EdgeInsets.all(10.h),
            height: 120.h,
            width: 120.h,
            child:
            Center(child: Image.asset('assets/images/img_language_logo.png',fit: BoxFit.fill,))),
      Container(
        margin: EdgeInsets.all(5.h),
        child: Text('${getTranslated(context, 'currently_u_have')} ${orderModel!.data.credit} ${getTranslated(context, 'credits')}',
          style: TextStyle(
              color: Color(0xFF000000),
              fontSize: screenUtil.setSp(13),
              fontWeight: FontWeight.normal
          )
        )),
            Container(
                margin: EdgeInsets.all(5.h),
                child:
                Text('${getTranslated(context, 'expire')} ${orderModel!.data.expiryDate} ',
                    style: TextStyle(
                        color: Color(0xFF000000),
                        fontSize: screenUtil.setSp(13),
                        fontWeight: FontWeight.normal
                    )
                )),
            SizedBox(height: 1,
            width: screenUtil.screenWidth,
            child: Container(
              color: Color(0xFF000000),
            ),),
            Container(
              margin: EdgeInsets.all(10.w),
              child: ListView.separated(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,


                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),


                  itemBuilder: (context,index){
                    return
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
                            return new OrderDetailsScreen(orderModel: orderModel!.data.orderHistory[index],);
                          }));
                        },
                        child: Container(
                          height: 120.h,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2.h,
                              color: kMainColor,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10.h)),


                          ),
                        child: Stack(
                          children: [
                            Container(
                              child: Row(
                                children: [
                                 Expanded(flex:1,child: Column(
                                   children: [
                                     Expanded(
                                         flex:3,child: Center(
                                       child:
                                       Container(
                                           width: 70.w,
                                           height: 70.h,
                                         alignment: AlignmentDirectional.center,
                                           decoration: BoxDecoration(
                                             shape: BoxShape.circle,
                                               border: Border.all(
                                                 width: 2.h,
                                                 color: kMainColor,
                                               ),

                                           ),
                                         child:
                                         Text('${orderModel!.data.orderHistory[index].packageCredit} ',
                                             textAlign: TextAlign.center,
                                             style: TextStyle(
                                                 color: kMainColor,
                                                 fontSize: screenUtil.setSp(20),
                                                 fontWeight: FontWeight.normal
                                             )
                                         ),
                                       )

                                     )),
                                     Expanded(flex:1,child: Container(
                                       alignment: AlignmentDirectional.center,
                                       child:  Text(getTranslated(context, 'credits')!,
                                           textAlign: TextAlign.center,
                                           style: TextStyle(
                                               color: Color(0xFF000000),
                                               fontSize: screenUtil.setSp(17),
                                               fontWeight: FontWeight.normal
                                           )
                                       ),
                                     ))

                                   ],
                                 )),
                                  SizedBox(width: 10.w,),
                                  Expanded(flex:3,child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [
                                      Expanded(
                                        flex:1,
                                        child: Container(
                                          alignment: AlignmentDirectional.centerStart,
                                          child: Text('${orderModel!.data.orderHistory[index].packageName}',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: Color(0xFF000000),
                                                  fontSize: screenUtil.setSp(14),
                                                  fontWeight: FontWeight.normal
                                              )
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex:1,
                                        child: Container(
                                          alignment: AlignmentDirectional.centerStart,
                                          child: Text('${getTranslated(context, 'expiry_date')} ${orderModel!.data.orderHistory[index].packageExpiryDate}',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: Color(0xFF000000),
                                                  fontSize: screenUtil.setSp(14),
                                                  fontWeight: FontWeight.normal
                                              )
                                          ),
                                        ),
                                      ),
                                    ],

                                  ))
                                ],
                              )

                            ),
                            Positioned.directional(textDirection:  Directionality.of(context),
                              end: 5.h,
                              top: 5.h,
                              child:  Text('${orderModel!.data.orderHistory[index].packagePurchaseDate} ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color(0xFF000000),
                                      fontSize: screenUtil.setSp(14),
                                      fontWeight: FontWeight.normal
                                  )
                              ),
                            )
                          ],
                        ),
                    ),
                      );
              }, separatorBuilder: (context,index){
                return Container(height: 10.h,
                  color: Color(0xFFFFFFFF),);}
                  , itemCount: orderModel!.data.orderHistory.length),
            )

          ],
        ),

      ),
    );
  }
  Future<OrderModel?> orders() async{

    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
    String? loginData = _preferences.getString(kUserModel);
    Map map;

      final body = json.decode(loginData!);
      LoginModel   loginModel = LoginModel.fromJson(body);
      map = {

        'user_id': loginModel.data!.id,

        'language': languageCode
      };

    print('map --> ${map}');

    PetMartService petMartService = PetMartService();
    OrderModel? orderModel = await petMartService.orders(map);

    return orderModel;
  }
}
