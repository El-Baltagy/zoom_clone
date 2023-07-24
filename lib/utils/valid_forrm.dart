import 'package:flutter/material.dart';

valid(String val,int min,int max,{ bool isEmail=false,TextEditingController? contrller})
{

  if (val.isEmpty) {
    return 'can\'t be Empty';
  } if (val.length<min) {
    return 'can\'t be less than $min';
  }   if(val.length>max){
    return 'can\'t be greater than $max';
  } if (isEmail) {
    return !contrller!.text.contains ("@")? "E-mail Adress is no't valid" :null;
  }
}