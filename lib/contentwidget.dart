import 'package:flutter/cupertino.dart';

class ContentWidget extends StatefulWidget{


  String title;
  String msg;
  int ranking = -1;

  ContentWidget(@required this.title,@required this.msg,this.ranking);

  @override
  State<StatefulWidget> createState() {

    return _ContentWidgetState(title,msg,ranking);
  }

}

class _ContentWidgetState extends State<ContentWidget>{
  String title;
  String msg;
  int ranking;
  _ContentWidgetState(this.title,this.msg,this.ranking);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: Stack(
            children: [
              Placeholder(),//这里再弄一个三角形
            ],
          ),
        ),
        SizedBox(
          width: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(this.title),
              Text(this.msg)
            ],
          ),
        )
      ],
    );
  }

}