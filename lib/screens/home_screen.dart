import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zoom_clone/screens/setting/setting.dart';
import '../utils/colors.dart';
import '../utils/global.dart';
import '../widgets/button.dart';
import 'history_meeting/history_meeting_screen.dart';
import 'meeting_sc/meeting_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;
  onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> pages = [
    MeetAndChatScreen(),
    const HistoryMeetingScreen(),
    SettingSc()

  ];
  Timer? timer;
  bool isEmailVerified=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentFirebaseUser = fAuth.currentUser;
    isEmailVerified=FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendEmailVerification();
    }
    timer=Timer.periodic(const Duration(seconds: 3),
            (_)=>checkEmailVerified());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return
     ! isEmailVerified? Scaffold(
      backgroundColor: buttonColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.white,
              child: Row(
                children: [SizedBox(
                  width: 20,
                ),

                  Text("your account hasn't been verified ....!",
                  style: TextStyle(
                    color: buttonColor
                  ),),
                  SizedBox(
                    width: 40,
                  ),
                  Button(
                      color:buttonColor,
                      text: 'Send'.toUpperCase(),
                      width: 60,
                      onPressed:() async{
                       await sendEmailVerification();
                      }
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ):
    Scaffold(
      appBar: AppBar(
        backgroundColor: buttonColor,
        elevation: 0,
        title: const Text('Meet & Chat'),
        centerTitle: true,
      ),
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: buttonColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        onTap: onPageChanged,
        currentIndex: _page,
        unselectedFontSize: 14,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.comment_bank,
            ),
            label: 'Meet & Char',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.lock_clock,
            ),
            label: 'History Meetings',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings_outlined,
            ),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
  sendEmailVerification()async{
    final user=fAuth.currentUser;
    await user!.sendEmailVerification();
    Fluttertoast.showToast(msg: "Verification has been sent...check your mail");
  }

  checkEmailVerified()async{
    await FirebaseAuth.instance.currentUser!.reload();

setState(() {
  isEmailVerified=FirebaseAuth.instance.currentUser!.emailVerified;
});

    if (isEmailVerified) {
      timer?.cancel();
    }
  }
}
