import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zoom_clone/widgets/navigation.dart';

import '../../utils/colors.dart';
import '../../utils/global.dart';
import '../../utils/valid_forrm.dart';
import '../../widgets/button.dart';
import '../../widgets/ttf.dart';
import 'home_auth.dart';

class ForgetPasswordSC extends StatelessWidget {
   ForgetPasswordSC({super.key});
final emailController=TextEditingController();
   final  GlobalKey<FormState> formKey=GlobalKey<FormState>();



 Future<void> resetPassword()async{
     try{
       await fAuth.sendPasswordResetEmail(email: emailController.text.trim());
       Fluttertoast.showToast(msg: "Password reset Link has been sent to your mail");
     }on FirebaseException catch(e){
       print(e.toString());
     };
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(onPressed: (){
          GoPage().popNavigation(context, path: HomeAuthSc());
        }, icon: Icon(Icons.arrow_back,color: buttonColor,)),
      ),
      body:Form(
         key:formKey ,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(

            children: [
              const SizedBox(
                height: 60,
              ),
              const Text(
                  'Enter Your Email and we will send you a Password reset Link',
                // style: ,
              ),
              const SizedBox(
                height: 30,
              ),
              buildTextFormField(
                controller: emailController,
                Type:  TextInputType.emailAddress ,
                labelTitle:'Email Address' ,
                prefix:Icons.email_outlined,
                validator:(val) => valid(val!, 5, 40,isEmail: true,contrller: emailController),
              ),
              Button(
                  color:buttonColor,
                  text: 'reset password'.toUpperCase(),
                  onPressed:() async{
                    if (formKey.currentState!.validate()) {
                      await resetPassword();

                    }
                  }
              )
            ],
          ),
        ),
      ) ,
    );
  }
}
