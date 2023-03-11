import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
class PhotoScreen extends StatefulWidget {

   PhotoScreen({
    required this.imageProvider,

  });

  final ImageProvider imageProvider;



  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  ScreenUtil screenUtil = ScreenUtil();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

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
              width: 200,
              color: Color(0xFFFFFFFF),

              child: Container(
                height: height,
                width: 200,
                child: PhotoView(

                  imageProvider: widget.imageProvider,
                  backgroundDecoration: BoxDecoration(
                    color: Colors.white
                  ),


                  minScale: 0.3,


                  maxScale:2.0,
                  heroAttributes: const PhotoViewHeroAttributes(tag: "someTag"),
                ),
              ),
            ),

          ],
        ),
      ) ,
    );
  }
}
