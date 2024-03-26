import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyTextButton extends StatefulWidget{
  String text;
  String route="/";
  MyTextButton(this.route,this.text);

  @override
  State<StatefulWidget> createState() {
    return _MyTextButtonState(route, text);
  }

}

class _MyTextButtonState extends State<MyTextButton>{

  String text;
  String route;
  bool hover = true;

  _MyTextButtonState(this.route,this.text);

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: ()=>{context.go(route)},onHover: (b)=>{setState(() {
      hover=!b;
    })}, child: Container(decoration: hover?null:const BoxDecoration(border: Border(bottom: BorderSide(
      width: 0.5,//宽度
      color: Colors.red, //边框颜色
    ),)),child: Text(text)));
  }



}
