import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/home_model.dart'as Home;
import 'package:pet_mart/screens/photo-screen.dart';
import 'package:pet_mart/screens/web_screen.dart';
import 'package:pet_mart/utilities/constants.dart';
class AdvertiseScreen extends StatefulWidget {
  Home.HomeModel homeModel;
  String langCode ;
  AdvertiseScreen({Key? key,required this.homeModel, required this.langCode}): super(key: key);

  @override
  _AdvertiseScreenState createState() => _AdvertiseScreenState();
}

class _AdvertiseScreenState extends State<AdvertiseScreen> {
  ScreenUtil screenUtil = ScreenUtil();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("widget.homeModel.data.banners --->${widget.homeModel.data!.banners!.length}");
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
        title: Container(
          alignment: AlignmentDirectional.center,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10.h),
            child: Text(
              getTranslated(context, 'advertisement_string')!,
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: screenUtil.setSp(16),
                  fontWeight: FontWeight.bold

              ),


            ),
          ),
        ),
        leading:
        GestureDetector(
          onTap: (){
            Navigator.pop(context);

          },
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10.h),
            child: Center(
                child: Icon(Icons.arrow_back_ios_new,color: Colors.white,size: 20,)
            ),
          ),
        ),

        actions: [
          Container(

            width: 30.w,
            height: 60.h,
          ),
        ],

      ),
      body: Container(
        margin: EdgeInsets.all(10.w),
        child: ListView.separated(itemBuilder: (context,index){
          return Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 1.w,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0.h),
              ),
              color: Color(0xFFFFFFFF),
              child: GestureDetector(
                  onTap: (){
                    Home.Banners item = widget.homeModel.data!.banners![index];
                    String url = item.image!.trim();
                    print('url ----> ${url}');
                    String link = item.url!;
                    String title = widget.langCode == "en"? item.enTitle!:item.arTitle!;
                    if(link != null || link.trim() !=""){
                      if(link.trim() == "#"){
                        Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
                          return new PhotoScreen(imageProvider: NetworkImage(
                            KImageUrl+url,
                          ),);
                        }));
                      }else {
                        Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    WebScreen(url: link, name: title)));
                      }
                    }else{
                      if(url.isNotEmpty) {
                        Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
                          return new PhotoScreen(imageProvider: NetworkImage(
                            KImageUrl+url,
                          ),);
                        }));

                      }

                    }},
                  child: buildItem(widget.homeModel.data!.banners![index],context))
          );
        },
            separatorBuilder: (context,index){
          return Container(height: 10.h,
            color: Color(0xFFefeef3),);
        }, itemCount: widget.homeModel.data!.banners!.length),
      ),
    );
  }
  Widget buildItem(Home.Banners data, BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                width:width ,
                height: 120.h,
                imageUrl:KImageUrl+data.image!,
                imageBuilder: (context, imageProvider) => Stack(
                  children: [
                    ClipRRect(

                      child: Container(
                          width: width,

                          decoration: BoxDecoration(

                            shape: BoxShape.rectangle,

                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: imageProvider),
                          )
                      ),
                    ),
                  ],
                ),
                placeholder: (context, url) =>
                    Center(
                      child: SizedBox(
                          height: 50.h,
                          width: 50.h,
                          child: new CircularProgressIndicator()),
                    ),


                errorWidget: (context, url, error) => ClipRRect(
                    child: Image.asset('assets/images/placeholder_error.png',  color: Color(0x80757575).withOpacity(0.5),
                      colorBlendMode: BlendMode.difference,)),

              ),

            ],
          ),


        ],
      ),
    );

  }
}
