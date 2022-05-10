import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/shopdetails_model.dart';
import 'package:pet_mart/screens/pets_details_screen.dart';
import 'package:pet_mart/screens/shop_detail.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ShopProductsScreen extends StatefulWidget {
  String id;
  String name;
  ShopProductsScreen({Key key,@required this.id,@required this.name}): super(key: key);

  @override
  _ShopProductsScreenState createState() => _ShopProductsScreenState();
}

class _ShopProductsScreenState extends State<ShopProductsScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  // ScreenUtil screenUtil = ScreenUtil();
  // double itemWidth;
  // double itemHeight;
  // ShopdetailsModel shopdetailsModel;
  // String mLanguage="";
  // Future<ShopdetailsModel> getShopDetails()async{
  //   SharedPreferences _preferences = await SharedPreferences.getInstance();
  //   String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
  //   mLanguage = languageCode;
  //   PetMartService petMartService = PetMartService();
  //   print(widget.id);
  //   Map map = {
  //     "shop_id":widget.id
  //   };
  //   ShopdetailsModel shopdetailsModel =await petMartService.shopDetails(widget.id);
  //   return shopdetailsModel;
  // }
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getShopDetails().then((value) {
  //     setState(() {
  //       shopdetailsModel = value;
  //     });
  //   });
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   double width = MediaQuery.of(context).size.width;
  //   itemWidth = width / 2;
  //   itemHeight = 200.h;
  //   return Scaffold(
  //     appBar:
  //     AppBar(
  //       backgroundColor: kMainColor,
  //       title: Container(
  //         alignment: AlignmentDirectional.center,
  //         child: Padding(
  //           padding:  EdgeInsets.symmetric(horizontal: 10.h),
  //           child: Text(
  //            widget.name,
  //             style: TextStyle(
  //                 color: Color(0xFFFFFFFF),
  //                 fontSize: screenUtil.setSp(16),
  //                 fontWeight: FontWeight.bold
  //
  //             ),
  //
  //
  //           ),
  //         ),
  //       ),
  //       leading: GestureDetector(
  //         onTap: (){
  //           Navigator.pop(context);
  //
  //         },
  //         child: Icon(Icons.arrow_back_ios_outlined,color: Colors.white,size: 20.h,),
  //       ),
  //
  //       actions: [
  //         SizedBox(width: 30.h,)
  //
  //       ],
  //
  //     ),
  //     backgroundColor: Color(0xFFFFFFFF),
  //     body: Container(
  //       child:   shopdetailsModel == null?
  //       Container(
  //         child: CircularProgressIndicator(
  //
  //
  //         ),
  //         alignment: AlignmentDirectional.center,
  //       ):
  //       shopdetailsModel.data.isEmpty?
  //
  //       Container(
  //         child: Text(
  //           shopdetailsModel.message,
  //           style: TextStyle(
  //               color: Colors.black,
  //               fontSize: screenUtil.setSp(16),
  //               fontWeight: FontWeight.w600
  //           ),
  //         ),
  //         alignment: AlignmentDirectional.center,
  //       )
  //           :
  //     GridView.builder(scrollDirection: Axis.vertical,
  //
  //
  //         shrinkWrap: true,
  //         physics: const AlwaysScrollableScrollPhysics(),
  //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
  //             childAspectRatio:itemWidth/itemHeight),
  //         itemCount: shopdetailsModel.data[0].shopProducts.length,
  //
  //         itemBuilder: (context,index){
  //           return GestureDetector(
  //             onTap: (){
  //               Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
  //                 return new ShopDetail(postId:shopdetailsModel.data[0].shopProducts[index].postId,postName: shopdetailsModel.data[0].shopProducts[index].postName,);
  //               }));
  //             },
  //             child: Container(
  //                 margin: EdgeInsets.all(6.w),
  //
  //                 child:
  //                 Card(
  //                     clipBehavior: Clip.antiAliasWithSaveLayer,
  //                     elevation: 1.w,
  //                     shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(10.0.h),
  //                     ),
  //                     color: Color(0xFFFFFFFF),
  //                     child: buildItem(shopdetailsModel.data[0].shopProducts[index],context))),
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }
  // Widget buildItem(ShopProducts data, BuildContext context) {
  //   print('image --> ${data.postImage}');
  //   return Container(
  //     child: Column(
  //       children: [
  //         Expanded(
  //           flex: 3,
  //           child: Stack(
  //             children: [
  //               CachedNetworkImage(
  //                 width: itemWidth,
  //                 imageUrl:data.postImage,
  //                 imageBuilder: (context, imageProvider) => Stack(
  //                   children: [
  //                     ClipRRect(
  //
  //                       child: Container(
  //                           width: itemWidth,
  //
  //                           decoration: BoxDecoration(
  //
  //                             shape: BoxShape.rectangle,
  //
  //                             image: DecorationImage(
  //                                 fit: BoxFit.fill,
  //
  //                                 image: imageProvider),
  //                           )
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 placeholder: (context, url) =>
  //                     Center(
  //                       child: SizedBox(
  //                           height: 50.h,
  //                           width: 50.h,
  //                           child: new CircularProgressIndicator()),
  //                     ),
  //
  //
  //                 errorWidget: (context, url, error) => ClipRRect(
  //                     child: Image.asset('assets/images/placeholder_error.png',  fit: BoxFit.fill,color: Color(0x80757575).withOpacity(0.5),
  //                       colorBlendMode: BlendMode.difference,)),
  //
  //               ),
  //               Positioned.directional(
  //                 textDirection:  Directionality.of(context),
  //                 bottom: 2.h,
  //                 start: 4.w,
  //                 child:
  //                 Text(
  //                   data.postDate,
  //                   style: TextStyle(
  //                       color: Color(0xFFFFFFFF)
  //
  //                   ),
  //                 ),
  //               )
  //             ],
  //           ),
  //         ),
  //         Expanded(flex:1,child: Container(
  //           child: Column(
  //             children: [
  //               Expanded(flex:1,child:
  //               Container(
  //                 margin: EdgeInsets.symmetric(horizontal: 5.w),
  //                 alignment: AlignmentDirectional.centerStart,
  //                 child: Text(
  //                   data.postName,
  //                   style: TextStyle(
  //                       color: Color(0xFF000000),
  //                       fontWeight: FontWeight.normal,
  //                       fontSize: screenUtil.setSp(12)
  //                   ),
  //
  //                 ),
  //               )),
  //               Expanded(flex:1,child:
  //               Row(
  //                 children: [
  //
  //                   Container(
  //                     padding: EdgeInsets.symmetric(horizontal: 5.w),
  //                     child: Text(
  //                       '${data.postPrice}',
  //                       style: TextStyle(
  //                           color: kMainColor,
  //                           fontWeight: FontWeight.normal,
  //                           fontSize: screenUtil.setSp(14)
  //                       ),
  //
  //                     ),
  //                   ),
  //                 ],
  //               ))
  //             ],
  //           ),
  //         ))
  //
  //       ],
  //     ),
  //   );

  }

