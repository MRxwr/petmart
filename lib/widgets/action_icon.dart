import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';




class NamedIcon extends StatelessWidget {



  final int notificationCount;


  const NamedIcon({
    Key key,




    this.notificationCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil screenUtil = ScreenUtil();
    return InkWell(

      child: Container(
width: 50.w,


        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.notifications_active,size: 30.w,color: Color(0xFFFFFFFF),)


              ],
            ),
            Positioned.directional(
              textDirection: Directionality.of(context),
              bottom: 0,
              end: 0,


              child: Opacity(
                opacity: (notificationCount >0) ? 1.0 : 0.0,
                child: Container(
                  height: 20.h,
                  width: 20.h,


                  decoration: BoxDecoration(shape: BoxShape.circle, color:Color(0xFFFF0000)),
                  alignment: Alignment.center,
                  child: Text('$notificationCount',style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: ScreenUtil().setSp(8)
                  ),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}