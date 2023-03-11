import 'dart:async';
import 'dart:convert';


import 'package:crypto/crypto.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherHelper{
static final PusherHelper _instance = PusherHelper._();

PusherHelper._();
final _apiKey = "e941dcfcec6d29b36b7b";
final _cluster = "us2";
String _channelName = "";
static PusherHelper get instance => _instance;
PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
StreamController _controller = StreamController.broadcast();
Stream get stream => _controller.stream;
void disconnect() async{
  await pusher.disconnect();
}
void onConnectPressed(String mChannelName) async {

  // Remove keyboard

  try {

    await pusher.init(
        apiKey: _apiKey,
        cluster: _cluster,
        onConnectionStateChange: onConnectionStateChange,
        onError: onError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent:onEvent ,

        onSubscriptionError: onSubscriptionError,
        onDecryptionFailure: onDecryptionFailure,
        onMemberAdded: onMemberAdded,
        onMemberRemoved: onMemberRemoved,
        // authEndpoint: "<Your Authendpoint Url>",
        onAuthorizer: onAuthorizer
    );
    await pusher.subscribe(channelName: mChannelName);



    await pusher.connect();
  } catch (e) {
    print("ERROR: $e");
  }
}
void onEvent(PusherEvent event) {
  print("onEvent: ${event.data}");
  _controller.sink.add(event.data);


  // if(!isNullEmptyOrFalse(event.data)){
  //   if(event.data == 'diviend'){
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) =>  DividendsScreen( startGameModel: widget.startGameModel,type: 'guest', )));
  //   }else if(event.data ==  'play'){
  //     startGame('https://www.yeaclova.com/project/pull-bear/API/en/game/data?game_id=${widget.startGameModel.data!.id}');
  //   }
  //
  //
  //
  //
  //
  // }





}
void onConnectionStateChange(dynamic currentState, dynamic previousState) {
  print("Connection: $currentState");
}
void onError(String message, int? code, dynamic e) {
  print("onError: $message code: $code exception: $e");
}
getSignature(String value) {
  var key = utf8.encode('718fae4058bb21cc69a2');
  var bytes = utf8.encode(value);

  var hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
  var digest = hmacSha256.convert(bytes);
  print("HMAC signature in string is: $digest");
  return digest;
}

dynamic onAuthorizer(String channelName, String socketId, dynamic options) {

  return {
    "auth": "e941dcfcec6d29b36b7b:${getSignature("$socketId:$channelName")}",
  };
}
void onSubscriptionSucceeded(String channelName, dynamic data) {
  print("onSubscriptionSucceeded: $channelName data: $data");
  final me = pusher.getChannel(channelName)?.me;
  print("Me: $me");
}
void onSubscriptionError(String message, dynamic e) {
  print("onSubscriptionError: $message Exception: $e");
}
void onDecryptionFailure(String event, String reason) {
  print("onDecryptionFailure: $event reason: $reason");
}
void onMemberAdded(String channelName, PusherMember member) {
  print("onMemberAdded: $channelName user: $member");
}
void onMemberRemoved(String channelName, PusherMember member) {
  print("onMemberRemoved: $channelName user: $member");
}


}