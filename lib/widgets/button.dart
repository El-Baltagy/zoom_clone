import 'package:color_log/color_log.dart';
import 'package:flutter/material.dart';

Padding Button({
  required Color color,
  required String text,
  required Function() onPressed,
  bool isUpperCase = true,
  double radius = 10,
  double padding = 10,
  double width = double.infinity,
  double height = 42,
}) {
  return Padding(
    padding:  EdgeInsets.symmetric(vertical: padding),
    child: Material(
        elevation: 5,
        color:color ,
        borderRadius: BorderRadius.circular(radius),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth:width , height:height ,
          child:  Text(
            isUpperCase ? text.toUpperCase() : text,
            style: const TextStyle(
                color: Colors.white
            ),
          ),
        )
    ),
  );
}
ColorLog clog = ColorLog();