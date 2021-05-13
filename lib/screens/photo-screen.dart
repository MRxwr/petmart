import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
class PhotoScreen extends StatefulWidget {
  String imageUrl;
   PhotoScreen({
     this.imageProvider,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
  });

  final ImageProvider imageProvider;
  final BoxDecoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;


  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  ScreenUtil screenUtil = ScreenUtil();

  @override
  Widget build(BuildContext context) {
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
              color: Color(0xFFFFFFFF),
              constraints: BoxConstraints.expand(
                height: MediaQuery.of(context).size.height,
              ),
              child: PhotoView(
                imageProvider: widget.imageProvider,
                backgroundDecoration: widget.backgroundDecoration,
                minScale: widget.minScale,
                maxScale: widget.maxScale,
                heroAttributes: const PhotoViewHeroAttributes(tag: "someTag"),
              ),
            ),

          ],
        ),
      ) ,
    );
  }
}
