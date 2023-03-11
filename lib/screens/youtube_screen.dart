
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class YouTubeScreen extends StatefulWidget {
  static String id = 'YouTubeScreen';
   String youtubeId;
   String auctionName;
  YouTubeScreen({Key? key,required this.youtubeId,required this.auctionName}): super(key: key);
  @override
  _YouTubeScreenState createState() => _YouTubeScreenState();
}

class _YouTubeScreenState extends State<YouTubeScreen> {

  YoutubePlayerController? _controller;



  @override
  Widget build(BuildContext context) {
    ScreenUtil screenUtil = ScreenUtil();
    String? videoId;
    videoId = YoutubePlayer.convertUrlToId(widget.youtubeId);
     _controller = YoutubePlayerController(
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,


      ),
      initialVideoId: videoId!,

    );
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
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
          SizedBox(width: 30.w,)
        ],

      ),

      body:
      Column(
        children: [

          Expanded(
            flex: 9,
            child:
            Container(
              child: Center(
                child:
                YoutubePlayer(controller: _controller!,
                showVideoProgressIndicator: true,


   ),
              ),
            ),
          ),
        ],
      ),
    );

  }
  @override
  void dispose() {
    _controller!.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

}
