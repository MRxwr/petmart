import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class TitleProvider  extends ChangeNotifier{
  String title ="";

  addCount(String titleText){
    title = titleText;

    notifyListeners();
  }


}