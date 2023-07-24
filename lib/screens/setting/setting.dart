import 'package:flutter/material.dart';

import '../../resources/auth_methods.dart';
import '../../resources/cash_helper.dart';
import '../../utils/colors.dart';
import '../../widgets/button.dart';
import '../../widgets/setting_item.dart';

class SettingSc extends StatefulWidget {
  const SettingSc({super.key});

  @override
  State<SettingSc> createState() => _SettingScState();
}

class _SettingScState extends State<SettingSc> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       const SizedBox(
          height: 50,
        ),
        StatefulBuilder(
            builder:(context, setState) => SettingItem(
              title:'AudioOnly',
              leadingIcon:Icons.audiotrack,
              suffix: Switch(
                value:CashHelper.getBoolean(key: 'isAudioOnly')??true ,
                activeColor:switchActiveColor ,
                inactiveTrackColor: switchInActiveColor,
                onChanged: (newValue) {
                  setState(() {
                    CashHelper.saveData(key: 'isAudioOnly', value: newValue);
                  },);

                },
              ),
            ), ),
        StatefulBuilder(
          builder: (context, setState) =>SettingItem(
            title:'AudioMuted',
            leadingIcon:Icons.audiotrack,
            suffix: Switch(
              value: CashHelper.getBoolean(key: 'isAudioMuted')??true,
              activeColor: switchActiveColor,
              inactiveTrackColor: switchInActiveColor,
              onChanged: (newValue) {
                setState(() {
                  CashHelper.saveData(key: 'isAudioMuted', value: newValue);
                },);
              },
            ),
          ) ),

        StatefulBuilder(
            builder: (context, setState) =>SettingItem(
              title:'VideoMuted',
              leadingIcon:Icons.audiotrack,
              suffix: Switch(
                value: CashHelper.getBoolean(key: 'isVideoMuted')??true,
                activeColor: switchActiveColor,
                inactiveTrackColor: switchInActiveColor,
                onChanged: (newValue) {
                  setState(() {
                    CashHelper.saveData(key: 'isVideoMuted', value: newValue);
                  },);

                },
              ),
            ) ),
        Button(
            text: 'Log Out',
            onPressed:() => AuthMethods().signOut(),
            color: buttonColor
        ),
      ],
    );
  }
}
