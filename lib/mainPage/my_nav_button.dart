import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../media_type.dart';

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
    var size = MediaQuery.of(context).size;
    double height1 = 174;
    var height2 = height1 *
        MediaType.large.width /
        MediaType.medium.width; // sbDart 这个地方不能const
    var height = switch (getMediaType(context)) {
      MediaType.small => size.width / MediaType.medium.width * height1,
      MediaType.medium => size.width / MediaType.medium.width * height1,
      MediaType.large => height2,
    };
    var redZhTextStyle1 = TextStyle(
      color: Colors.red,
      fontSize: 0.4 * height,
    );
    TextStyle style = new TextStyle(color: Colors.white,fontStyle: FontStyle.italic,fontSize: height*0.07);
    return TextButton(onPressed: ()=>{context.go(route)},onHover: (b)=>{setState(() {
      hover=!b;
    })}, child: Container(decoration: hover?null:const BoxDecoration(border: Border(bottom: BorderSide(
      width: 0.5,//宽度
      color: Colors.red, //边框颜色
    ),)),child: Text("    "+text+"    ",style: style,)));
  }



}
