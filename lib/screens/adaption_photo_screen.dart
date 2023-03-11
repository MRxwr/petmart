
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pinch_zoom_image_last/pinch_zoom_image_last.dart';
class ZoomClass extends StatefulWidget {
  String url;
   ZoomClass({Key?  key,required this.url}) : super(key: key);

  @override
  _ZoomClassState createState() => _ZoomClassState();
}

class _ZoomClassState extends State<ZoomClass> {
  ScreenUtil screenUtil = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
      return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton:  FloatingActionButton(
        onPressed: () {
          print("true");
          Navigator.pop(context);
        },
        tooltip: 'Increment',
        child:Container(
            alignment: AlignmentDirectional.center,
            width: 60.w, height: 60.w, child: Center(child: Icon(Icons.close,color: Color(0xFFFFFFFF),))),
        elevation: 2.0,
      ),
      body:
      Container(

        color: Color(0xFFFFFFFF),
        child: Stack(
          fit: StackFit.expand,

          children: [
            Container(
              height: height,
              width: width,
              color: Color(0xFFFFFFFF),

              child: Container(
                height: height,
                width: width,
                child: PinchZoomImage(
                  image: CachedNetworkImage(
                    imageUrl: widget.url,
                    height: height,
                    width: width,
                  ),
                  zoomedBackgroundColor: Color.fromRGBO(240, 240, 240, 1.0),
                  hideStatusBarWhileZooming: true,
                ),
              ),
            ),

          ],
        ),
      ) ,
    );;
  }
}
