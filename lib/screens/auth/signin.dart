import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../utils/colors.dart';
import '../../utils/global.dart';
import '../../utils/valid_forrm.dart';
import '../../widgets/button.dart';
import '../../widgets/navigation.dart';
import '../../widgets/progress_dialouge.dart';
import '../../widgets/ttf.dart';
import '../home_screen.dart';
import 'forget_password.dart';



class Login extends StatelessWidget {
   Login({
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPassword=false;

   signin(context)async{
     showDialog(
         context: context,
         barrierDismissible: false,
         builder: (BuildContext c)
         {
           return ProgressDialog(message: "Processing, Please wait...",);
         }
     );
     Navigator.pop(context);
     User? firebaseUser = (
         await fAuth.signInWithEmailAndPassword(
           email: emailController.text.trim(),
           password: passwordController.text.trim(),
         ).catchError((msg){
           print('................');
           print('Error: $msg');
           Fluttertoast.showToast(msg: "Error: $msg");

         })
     ).user;

         ()=>Navigator.pop(context);
     if(firebaseUser != null)
     {
           ()=>Future.delayed(const Duration(seconds: 1),
                 () => GoPage().navigateAndFinish(context,const HomeScreen()),);
     }
     else
     {
       Fluttertoast.showToast(msg: "Fail to signin....");
     }

   }
  @override
  Widget build(BuildContext context) {


        return Column(
          children: [
            buildTextFormField(
              controller: emailController,
               Type:  TextInputType.emailAddress ,
              labelTitle:'Email Address' ,
            prefix:Icons.email_outlined,
              validator:(val) => valid(val!, 5, 40,isEmail: true,contrller: emailController),
            ),
            StatefulBuilder(
                builder: (context, setState) => buildTextFormField(
                  controller:passwordController ,
                  Type:TextInputType.visiblePassword,
                  labelTitle:'Password',
                  prefix: Icons.lock_outline,
                  suffix: isPassword?
                  Icons.visibility_off:Icons.visibility_outlined,
                  isPassword: isPassword,
                  suffixPressed:() {
                    setState(() {
                      isPassword = !isPassword;
                    });
                  },
                  validator: (val) =>valid(val!, 5, 40),
                ), ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: () {
                 GoPage().pushNavigation(context, path: ForgetPasswordSC());
                }, child: const Text('Forget Your Password'))
              ],
            ),
            Button(
              color:buttonColor,
                padding: 2,
                text: 'login'.toUpperCase(),
              onPressed:() async{
                if (formKey.currentState!.validate()) {
                  await signin(context);
                  }
                }
            )
          ],
        );

  }
}
