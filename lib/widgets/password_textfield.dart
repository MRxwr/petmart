


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/utilities/constants.dart';


class PasswordTextField extends StatelessWidget {
  final String hint;

  final Function onClick;
  final String mText;
  final BuildContext context;

  String? _errorMessage(String str){
    switch(str){
      case 'Full Name':

        return 'Full Name Is Empty!';

    }
  }

  PasswordTextField({Key? key, required this.hint,required this.onClick, required this.mText,required this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextEditingController myController = TextEditingController()..text = mText;

    return Container(




      child:

      Stack(


        children: [

          Container(

            child: TextFormField(
              initialValue: mText,


              textAlign: TextAlign.start,
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.text ,
              onSaved: (value){
                onClick(value);


              },
              textInputAction: TextInputAction.done,
              maxLines: 1,
              minLines: 1,
              obscureText: true,





              validator: validateName,
              cursorColor: Color(0xFF000000),

              decoration:
              InputDecoration(


                  contentPadding: EdgeInsets.all(14.w),
                  isDense: true,

                  hintText: hint,



                  labelStyle: TextStyle(color: kLightGrayColor),
                  filled: true,



                  fillColor: Color(0xFFFFFFFF),
                  enabledBorder:
                  OutlineInputBorder(

                      borderSide: BorderSide(
                          color: Color(0xFFdcdcdc)
                          ,width: 1.w
                      )
                  ),
                  focusedBorder:
                  OutlineInputBorder(


                      borderSide: BorderSide(
                          color: Color(0xFFdcdcdc)
                          ,width: 1.w
                      )
                  )
                  // OutlineInputBorder(
                  //     borderRadius: BorderRadius.circular(20),
                  //     borderSide: BorderSide(
                  //         color: Colors.white
                  //     )
                  // )
                  ,
                  border:
                  OutlineInputBorder(

                      borderSide: BorderSide(
                          color: Color(0xFFFF0000),
                          width: 1.w
                      )
                  )


                // OutlineInputBorder(
                //     borderRadius: BorderRadius.circular(20),
                //     borderSide: BorderSide(
                //         color: Colors.red
                //     )
              ),


            ),
          ),

        ],
      ),
    );

  }
  String? validateName(String? value) {

    if (value!.length == 0) {
      return getTranslated(context, 'password_error');
    }

    return null;
  }

}