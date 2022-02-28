import 'package:flutter/material.dart';

InputDecoration textfieldinputdecoration(String hinttext){
  return InputDecoration(

      hintText:hinttext,
      hintStyle: TextStyle(
        color: Colors.white54,
      ),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white)
      ),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white54)
      )

  ) ;
}

TextStyle inputfieldtext(){
  return TextStyle(
      color: Colors.white,
    fontSize: 16
  );
}