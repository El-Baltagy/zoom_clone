import 'dart:math';
import 'package:flutter/material.dart';
import 'package:zoom_clone/widgets/ttf.dart';
import '../../resources/jitsi_meet_method.dart';
import '../../utils/colors.dart';
import '../../widgets/button.dart';
import '../../widgets/home_meeting_button.dart';


class MeetAndChatScreen extends StatefulWidget {
  MeetAndChatScreen({super.key});

  @override
  State<MeetAndChatScreen> createState() => _MeetAndChatScreenState();
}

class _MeetAndChatScreenState extends State<MeetAndChatScreen> {
  bool isJoinMeeting = false;

  TextEditingController inputText = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var random = Random();


  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HomeMeetingButton(
                onPressed: () {
                  setState(() {
                    isJoinMeeting = false;
                  });
                  createOrjoinNewMeeting(
                      roomName: (random.nextInt(1000000) + 1000000).toString());
                },
                text: 'New Meeting',
                icon: Icons.videocam,
              ),
              HomeMeetingButton(
                onPressed: () {
                  setState(() {
                    isJoinMeeting = true;
                  });
                },
                text: 'Join Meeting',
                icon: Icons.add_box_rounded,
              )
            ],
          ),
          const SizedBox(
            height: 80,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isJoinMeeting ? 20 : 30),
            child: Column(
              children: [
                Text(
                  isJoinMeeting ?
                  "Please Add the Room Meeting ID" :
                  "Create/Join meetings with just one click!",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                if (isJoinMeeting)
                  ...[
                    buildTextFormField(
                      controller: inputText,
                      Type: TextInputType.text,
                      labelTitle: 'Room ID',
                      prefix: Icons.lock_outline,
                      isPassword: false,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Can't be Empty...!";
                        }
                      },
                    ),
                    Button(color: buttonColor,
                        text: 'Join Meeting',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            createOrjoinNewMeeting(roomName: inputText.text
                                .trim());
                          }
                        })
                  ]
              ],
            ),
          )
          ,
        ],
      ),
    );
  }

  createOrjoinNewMeeting({required String roomName}) async {
    final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();

    _jitsiMeetMethods.creatMeeting(
      roomName: roomName,
    );
  }

}

