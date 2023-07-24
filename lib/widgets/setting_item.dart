import 'package:flutter/material.dart';
import 'package:zoom_clone/utils/colors.dart';

class SettingItem extends StatelessWidget {
  final IconData? leadingIcon;
  final Color? leadingIconColor;
  final String title;
  final Widget suffix;
  final GestureTapCallback? onTap;
  const SettingItem(
      {Key? key,
        required this.title,
        required this.suffix,
        this.onTap,
        this.leadingIcon,
        this.leadingIconColor })
      : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.only(left: 15, right: 15),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
              color: buttonColor,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset:  Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:
                  [
                    Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).shadowColor.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset:  Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Icon(
                        leadingIcon,
                        size: 24,
                        color: buttonColor,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text(
                        title,
                        style:  TextStyle(fontSize: 16,
                            color:Theme.of(context).scaffoldBackgroundColor ),
                      ),
                    ), suffix
                  ]
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}