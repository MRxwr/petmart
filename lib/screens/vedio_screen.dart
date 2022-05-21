import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

import '../utilities/constants.dart';


class VideoScreen extends StatefulWidget {
  String vedioUrl;
  String auctionName;

   VideoScreen({Key key,@required this.vedioUrl,@required this.auctionName}) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;
  double _aspectRatio = 3/2;
  Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    super.initState();
    print(widget.vedioUrl);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    AutoOrientation.landscapeAutoMode();
    initialize().then((value) {
      setState(() {

      });


    });




  }
  Future<void> initialize() async{
    _videoPlayerController = VideoPlayerController.network(
        widget.vedioUrl
    );

    await _videoPlayerController.initialize();
    _chewieController = ChewieController(
      allowedScreenSleep: false,
      showOptions: false,
      allowFullScreen: true,
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],

      videoPlayerController: _videoPlayerController,
      aspectRatio: _aspectRatio,
      autoInitialize: true,
      autoPlay: true,
      showControls: true,
      fullScreenByDefault: true
    );
    _chewieController.addListener(() {
      if (_chewieController.isFullScreen) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
        ]);

      } else {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);

      }
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    AutoOrientation.portraitAutoMode();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil screenUtil = ScreenUtil();
    return Scaffold(
      backgroundColor:      Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: kMainColor,
        title: Container(
          alignment: AlignmentDirectional.center,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10.h),
            child: Text(
              widget.auctionName,
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
          color: Color(0xFFFFFFFF),
          child: _chewieController != null&&
              _chewieController.videoPlayerController.value.isInitialized
              ?
          Chewie(
            controller: _chewieController,
          )
              : Container(
            child: CircularProgressIndicator(


            ),
            alignment: AlignmentDirectional.center,
          )

      ),
    );
  }

}
