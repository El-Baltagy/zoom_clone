import 'package:flutter/material.dart';
import 'package:zoom_clone/screens/auth/register.dart';
import 'package:zoom_clone/screens/auth/signin.dart';
import 'package:zoom_clone/utils/colors.dart';


bool isLogin=true;
class HomeAuthSc extends StatefulWidget {
  @override
  State<HomeAuthSc> createState() => _HomeAuthScState();
}

class _HomeAuthScState extends State<HomeAuthSc> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();



  void changeTab(value){
    if (value==0) {
      isLogin=true;
    } else{
      isLogin=false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

 return  Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                autovalidateMode:AutovalidateMode.onUserInteraction,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 180,
                    //image here
                                child: Image.asset('assets/images/184-1847604_zoom-zoom-call-hd-png-download-350x317.png'),
                              ),

                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Zoom',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: buttonColor
                                )
                              ),
                            ],
                          ),
                        ],
                      ),
                        const SizedBox(
                                height: 40,
                              ),

                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.8, // 80%
                        decoration: BoxDecoration(
                          color: Color(0xff2e386b),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DefaultTabController(
                          length: 2,
                          child: Container(
                            color: Colors.white,
                            child: TabBar(
                              indicatorColor: Colors.green,

                              indicator: BoxDecoration(
                                color: buttonColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              labelColor: Colors.white,
                              unselectedLabelColor:buttonColor,
                              onTap: (value){
                               changeTab(value);
                              },
                              tabs: [Tab(text: "Login"), Tab(text: "Register")],
                            ),
                          ),
                        ),
                      ),
                         const SizedBox(
                                height: 30,
                              ),

                      Text(
                        '${isLogin?'Login':'Register'} now to communicate with friends',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Color(0xff2e386b),
                        ),
                      ),
                         const SizedBox(
                                height: 20,
                              ),

                      isLogin? Login( formKey: formKey):
                      RegisterScreen(formKey: formKey)
                    ],
                  ),
                ),
              ),
            ),
          ),
        );


  }}

