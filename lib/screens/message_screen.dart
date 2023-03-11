import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/message_model.dart';
import 'package:pet_mart/providers/model_hud.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MessageScreen extends StatefulWidget {
  final String  contactName;
  final String contactImage;
  final String contactId;
  final String postId;
  final String userId;
   MessageModel? messageModel;




  MessageScreen({Key? key,required this.contactName,required this.contactImage,required this.contactId,required this.userId,required this.postId,  this.messageModel}) : super(key: key);


  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<Element> elements = [];
  final TextEditingController _commentController = new TextEditingController();

  Future<MessageModel?> messages() async{

    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;

    Map map;

      map = {
        'receiver_id': widget.contactId,
        'user_id': widget.userId,
        'message': '',
        'post_id':widget.postId,
        'language': languageCode
      };


    print('map --> ${map}');

    PetMartService petMartService = PetMartService();
    MessageModel? messageModel = await petMartService.getMessages(map);

    return messageModel;
  }
  ScreenUtil screenUtil = ScreenUtil();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    messages().then((value) {
      for(int i =0;i<value!.data.length;i++){
        String date = value.data[i].createdAt;
        String message = value.data[i].message;
        String sender = value.data[i].sender;
        bool  isSender = false;
        if(sender == 'right'){
          isSender = true;

        }else{
          isSender = false;
        }
        DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
          DateTime dateTime = dateFormat.parse(date);

        Element element = Element(
            DateTime(dateTime.year,dateTime.month,dateTime.day,
        dateTime.hour,dateTime.minute,dateTime.second),message,isSender);
        elements.add(element);

      }
      setState(() {

      });
      

    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return
      ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Scaffold(
          resizeToAvoidBottomInset:true,
        key: _scaffoldKey,
        appBar:    AppBar(
          backgroundColor: kMainColor,
          title: Container(
            alignment: AlignmentDirectional.center,
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    width: 40.w,
                    height: 40.h,
                    imageUrl:'${widget.contactImage}',
                    imageBuilder: (context, imageProvider) =>
                        Container(
                            width: 40.w,
                            height: 40.h,

                            decoration: BoxDecoration(
                              shape: BoxShape.circle,

                              image: DecorationImage(
                                  fit: BoxFit.fill,

                                  image: imageProvider),
                            )
                        ),
                    placeholder: (context, url) =>
                        Center(
                          child: SizedBox(
                              height: 20.h,
                              width: 20.h,
                              child: new CircularProgressIndicator()),
                        ),


                    errorWidget: (context, url, error) =>  Container(
                        width: 50.w,
                        height: 50.h,

                        decoration: BoxDecoration(
                          shape: BoxShape.circle,

                          image: DecorationImage(
                              image: AssetImage('assets/images/icon.png')),
                        )
                    ),

                  ),
                  SizedBox(width: 4.w,),
                  Text(
                    '${widget.contactName}',
                    style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: screenUtil.setSp(16),
                        fontWeight: FontWeight.bold

                    ),


                  ),
                ],
              ),
            ),
          ),
          leading:  GestureDetector(
            onTap: (){
              Navigator.pop(context);

            },
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.h),
              child: Center(
                  child: Icon(Icons.arrow_back_ios,color: Colors.white,size: 20,)
              ),
            ),
          ),

          actions: [
            SizedBox(width: 30.h,)

          ],

        ),
        body:


        Stack(
          children: [
            Container(

              child:
        ListView(
          physics: AlwaysScrollableScrollPhysics(),

          children: [
            Container(

              child: GroupedListView<Element, DateTime>(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                elements: elements,
                order: GroupedListOrder.DESC,
                reverse: true,
                floatingHeader: true,
                useStickyGroupSeparators: true,
                groupBy: (Element element) => DateTime(
                    element.date.year, element.date.month, element.date.day),
                groupHeaderBuilder: (Element element) => Container(
                  height: 40.h,
                  child: Align(
                    child: Container(
                      width: 120.w,
                      decoration: BoxDecoration(
                        color: kMainColor,
                        borderRadius:
                        BorderRadius.all(Radius.circular(10.0.w)),
                      ),
                      child: Padding(
                        padding:  EdgeInsets.all(8.0.w),
                        child: Text(
                          '${DateFormat.yMMMd().format(element.date)}',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                itemBuilder: (_, Element element) {
                  return Align(
                    alignment: element.sender
                        ? AlignmentDirectional.centerEnd
                        : AlignmentDirectional.centerStart,
                    child: Container(

                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0.w),
                        ),
                        elevation: 8.0,
                        margin:  EdgeInsets.symmetric(
                            horizontal: 10.0.w, vertical: 6.0.h),
                        child: ListTile(
                          contentPadding:  EdgeInsets.symmetric(
                              horizontal: 20.0.w, vertical: 10.0.h),
                          leading: element.sender
                              ? Text(DateFormat.Hm().format(element.date))
                              : const Icon(Icons.person),
                          title: Container(alignment: element.sender?AlignmentDirectional.centerEnd:AlignmentDirectional.centerStart
                              ,
                              child: Text(element.name)),
                          trailing: element.sender
                              ? const Icon(Icons.person_outline)
                              : Text(DateFormat.Hm().format(element.date)),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 70.h,)
          ],
        ),
            ),
            Positioned.directional(textDirection: Directionality.of(context)
              , child:

              _bulidMessageComposer(),
              bottom: 0,
              start: 0,
              end: 0,
            )
          ],
        ),

    ),
      );
  }

  _bulidMessageComposer(){
       return
      Column(

        children: [

          Container(
            child:
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              height: 60.0,

              decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFAAAAAA),
                  ),
                  borderRadius: BorderRadius.circular(60.0),
                  color: Color(0xFFFFFFFF)
              ),
              child: Row(
                children: <Widget>[

                  Expanded(
                    child: TextField(

                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 50,
                      enableInteractiveSelection: true,
                      controller: _commentController,

                      textInputAction: TextInputAction.newline,
                      textAlign: TextAlign.right,
                      textAlignVertical: TextAlignVertical.center,


                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration.collapsed(hintText: getTranslated(context, 'write_message'),
                      ),
                    ),
                  ),


                  Container(

                    padding: EdgeInsets.all(8.0),
                    height: 60.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60.0),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: IconButton(
                      icon:  Icon(Icons.send),
                      iconSize: 25.0,
                      color: Colors.white,
                      onPressed: () {
                        String comment  = _commentController.text;
                        print(comment);
                        if(comment.trim().isNotEmpty){
                          FocusScope.of(context).requestFocus(FocusNode());
                          postComment(comment);

                        }else{

                          Fluttertoast.showToast(
                              msg: getTranslated(context, 'message_error')!,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: screenUtil.setSp(16)
                          );


                        }




                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10.h,)
        ],
      );
  }

  Future<void> postComment(String comment) async{

    final modelHud = Provider.of<ModelHud>(context,listen: false);
    modelHud.changeIsLoading(true);
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;

    Map map;

    map = {
      'receiver_id': widget.contactId,
      'user_id': widget.userId,
      'message': comment,
      'post_id':widget.postId,
      'language': languageCode
    };


    print('map --> ${map}');

    PetMartService petMartService = PetMartService();
    MessageModel? messageModel = await petMartService.postMessages(map);
    elements.clear();
    for(int i =0;i<messageModel!.data.length;i++){
      String date = messageModel.data[i].createdAt;
      String message = messageModel.data[i].message;
      String sender = messageModel.data[i].sender;
      bool  isSender = false;
      if(sender == 'right'){
        isSender = true;

      }else{
        isSender = false;
      }
      DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
      DateTime dateTime = dateFormat.parse(date);

      Element element = Element(
          DateTime(dateTime.year,dateTime.month,dateTime.day,
              dateTime.hour,dateTime.minute,dateTime.second),message,isSender);
      elements.add(element);

    }
    modelHud.changeIsLoading(false);
    _commentController.text = '';
    setState(() {

    });

  }
}
class Element implements Comparable {
  DateTime date;
  String name;
  bool sender = false;

  Element(this.date, this.name, [this.sender = false]);

  @override
  int compareTo(other) {
    return date.compareTo(other.date);
  }
}
