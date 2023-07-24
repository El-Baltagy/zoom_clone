import 'package:flutter/material.dart';
import 'package:zoom_clone/utils/colors.dart';

 buildTextFormField({
  required String labelTitle,
   Function(String)? onChange,
  String? Function(String?)? validator,
   TextEditingController? controller,
  FocusNode? focusNode,
  bool isPassword=false,
   IconData? suffix,
   IconData? prefix,
   VoidCallback? OnTap,
   Function(PointerDownEvent)? OnTapOutside,
   Function(String)? onSubmit,
   Function()? suffixPressed,
TextInputType Type=TextInputType.emailAddress,
  EdgeInsetsGeometry? padding=const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
  InputBorder? border= const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10))
  )
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: TextFormField(
      // textAlign: TextAlign.center,
      onFieldSubmitted: onSubmit,
      validator: validator ,
      obscureText: isPassword,
      keyboardType:Type,
      controller:controller ,
      focusNode: focusNode,
      onChanged: onChange,
      onTap: OnTap,
      onTapOutside: OnTapOutside,
      decoration: InputDecoration(
        suffixIcon: IconButton(onPressed: suffixPressed, icon: Icon(suffix,color: buttonColor)),
        prefixIcon: Icon(prefix,color: buttonColor,) ,
          labelText: labelTitle,labelStyle: TextStyle(
        color: Color(0xff2e386b)
      ),
          contentPadding:  padding,
          border: border,
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color(0xff2e386b),width: 1
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color:  buttonColor,width: 2
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))
          )
      ),
    ),
  );
}
