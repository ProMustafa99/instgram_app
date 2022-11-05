import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:instgram/cah_helper/cach_helper.dart';


void navigateto_and_push(context, Widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => Widget,
    ), (Route<dynamic> route) {
  return false;
});

void Tosta_mes({required String mess, Color? color}) => Fluttertoast.showToast(
    msg: mess,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 20,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 16.0);

void navigateto_page(context, Widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Widget,
    ));


Widget Divider_line() {

  return Container(
    height: 2,
    color: Colors.grey,

  );
}

var Data = Cash_Data();
