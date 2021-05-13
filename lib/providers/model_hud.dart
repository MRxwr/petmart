import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModelHud extends ChangeNotifier{
  bool isLoading = false;
  changeIsLoading(bool value){
    isLoading = value;
    notifyListeners();
  }

}