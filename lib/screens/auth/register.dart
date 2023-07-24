import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zoom_clone/screens/auth/signin.dart';
import '../../utils/colors.dart';
import '../../utils/global.dart';
import '../../utils/valid_forrm.dart';
import '../../widgets/button.dart';
import '../../widgets/navigation.dart';
import '../../widgets/progress_dialouge.dart';

import '../../widgets/ttf.dart';
import '../home_screen.dart';
import 'home_auth.dart';



class RegisterScreen extends StatefulWidget {
  RegisterScreen({
    required this.formKey
});
  final GlobalKey<FormState> formKey;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

   final nameController = TextEditingController();
   final emailController = TextEditingController();
   final passwordController = TextEditingController();


   final rePasswordController = TextEditingController();

   String passwordConfirmed='';
  bool isInside=false;
 bool passwordStrong=false;
bool isPassword1=true;
bool isPassword2=true;
IconData suffix = Icons.visibility_outlined;
bool isPassword = true;


  register() async
  {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c)
        {
          return ProgressDialog(message: "Processing, Please wait...",);
        }
    );


     User? firebaseUser = (
      await fAuth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      ).catchError((msg){
        Navigator.pop(context);
        print('................');
        print('Error: $msg');
        Fluttertoast.showToast(msg: "Error: $msg");

      })
    ).user;
        ()=>Navigator.pop(context);
    if(firebaseUser != null)
    {
      Map<String,dynamic> user =
      {
        "id": firebaseUser.uid,
        "name": nameController.text.trim(),
        "email": emailController.text.trim(),

      };
      firestore.collection('users')
          .doc(firebaseUser.uid).set(user);
      // DatabaseReference userRef = fDB.ref().child("users");
      // userRef.child(firebaseUser.uid).set(user);

      currentFirebaseUser=firebaseUser;
         Fluttertoast.showToast(msg: "Account has been Created.");
          ()=>isLogin=true;
          // () => GoPage().navDelete(context, HomeAuthSc()),);
    }
    else
    {
      Fluttertoast.showToast(msg: "Account has not been Created.");
    }
  }


  @override
  Widget build(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

       // name
        buildTextFormField(
          controller: nameController,Type:TextInputType.name ,
          labelTitle:'User Name' ,
          prefix:Icons.person,

          validator:(val) => valid(val!, 5, 40),
        ),
        const SizedBox(
          height: 15.0,
        ),
        //email
        buildTextFormField(
            controller: emailController,Type:TextInputType.emailAddress ,
            labelTitle:'Email Address' ,prefix:Icons.email_outlined,
            OnTap:(){
              setState(() {
                isInside=false;
              });
            },

          validator:(val) => valid(val!, 5, 40,isEmail: true,contrller: emailController),
        ),
        const SizedBox(
          height: 15.0,
        ),
        //password
        buildTextFormField(
            controller: passwordController,
            Type:TextInputType.visiblePassword ,
            labelTitle:'Password' ,prefix:Icons.lock_outline,
            isPassword: isPassword1,
            suffix: isPassword1?
            Icons.visibility_off:Icons.visibility_outlined,
            suffixPressed: (){
              setState(() {
                  isPassword1=!isPassword1;
              });
            },
            OnTap:(){
              setState(() {
                isInside=true;
              });
            },
          onChange: (p0) {
            setState(() {
               passwordConfirmed=p0;
            });
          },

          validator:(val) => valid(val!, 5, 40),
        ),
        isInside?Column(
          children: [
            //password validator
            SizedBox(
              height: 205,
              child: FlutterPwValidator(
                  controller: passwordController,
                  minLength: 6,
                  uppercaseCharCount: 1,
                  numericCharCount: 3,
                  specialCharCount: 1,
                  width: 400,
                  height: 150,
                  onSuccess: (){
                    setState(() {
                      passwordStrong=true;
                    });

                  },
                onFail: (){
                   setState(() {
                      passwordStrong=false;
                    });

                },
              ),
            ),
          ],
        ): Container(),

        const SizedBox(
          height: 15.0,
        ),
        //confirm password
        buildTextFormField(
            controller: rePasswordController,
            Type:TextInputType.visiblePassword ,
            labelTitle:'Confirm Password' ,prefix:Icons.lock_outline,
            isPassword: isPassword2,
            suffix: isPassword2?
            Icons.visibility_off:Icons.visibility_outlined,
            suffixPressed: (){
              setState(() {isPassword2=!isPassword2;});
            },
            OnTap:(){
              setState(() {
                isInside=false;
              });
            },

           validator:(val) {
              if (val!=passwordConfirmed) {
                return 'Non Identical Password..';
              }

           },
        ),
        const SizedBox(
          height: 40.0,
        ),
      // action
      Button(
        color:buttonColor,text: 'register'.toUpperCase(),radius: 10,
        onPressed:() async{
          if (widget.formKey.currentState!.validate()) {
            if (passwordStrong) {
              await register();
            } else{
              Fluttertoast.showToast(msg: "Password Weak");
            }

          }
        },
      )

    ],
  );  }
}
