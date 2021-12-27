import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class NotificationNotifier  extends ChangeNotifier{
 int notifcationCount =0;

  addCount(int notificationCount){
    notifcationCount = notificationCount;

    notifyListeners();
  }


}