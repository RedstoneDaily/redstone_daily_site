import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyNavButton extends StatefulWidget{
  String text;
  String route="/";
  MyNavButton(this.route,this.text);

  @override
  State<StatefulWidget> createState() {
    return _MyNavButtonState(route, text);
  }

}

class _MyNavButtonState extends State<MyNavButton>{

  String text;
  String route;
  bool hover = true;

  _MyNavButtonState(this.route,this.text);

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
