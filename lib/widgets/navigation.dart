import 'package:flutter/material.dart';

class GoPage {
  GoPage();

  void navDelete(
      context,
      widget,
      {bool Rt = false}
      ) =>
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ),
      );

  void navigateAndFinish(
      context,
      widget,
      {bool Rt = false}
      ) =>
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ), (route) =>Rt,
      );
  pushNavigation(context, {
    required Widget path,
    var curve = Curves.ease,
    double x=0.2,
    double y=0,
  }) {
    Navigator.of(context).
    push(_createRoute(Sc: path,curve:curve,X:x ,Y:y ));
  }
  void popNavigation(context, {
    required Widget path,
    var curve = Curves.ease,
    double x=0.0,
    double y=0.2,
  }) {
    Navigator.of(context).pop(_createRoute(Sc: path,curve:curve,X:x ,Y:y ));
  }
  _createRoute({
    required Widget Sc,
    required var curve,
    required double X,Y,
  }) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Sc,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(X,Y);
        const end = Offset.zero;

        var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

// void getNavigation({required Widget path, Transition transition=Transition.zoom,}){
//   Get.to((context)=>path,transition:transition,);
// }
}