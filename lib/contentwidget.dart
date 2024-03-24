import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_network/image_network.dart';
import 'package:redstone_daily_site/trapezoid_painter.dart';

class ContentWidget extends StatefulWidget {
  String title;
  String description;
  String imageUrl;
  int ranking = -1;

  ContentWidget(@required this.imageUrl, @required this.title,
      @required this.description);

  @override
  State<StatefulWidget> createState() {
    return _ContentWidgetState(imageUrl, title, description, ranking);
  }
}

class _ContentWidgetState extends State<ContentWidget> {
  final TextStyle titleStyle = const TextStyle(
    fontFamily: 'HuXiaoBo',
    fontSize: 12,
    color: Colors.white,
  );

  final TextStyle descriptionStyle = const TextStyle(
    fontFamily: 'HuXiaoBo',
    fontSize: 9,
    color: Colors.black,
  );

  String title;
  String msg;
  int ranking;
  String imageUrl;

  _ContentWidgetState(this.imageUrl, this.title, this.msg, this.ranking);

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
              ImageNetwork(
                image: imageUrl,
                width: 100,
                height: 100,
              ),
              CustomPaint(
                painter: TrapezoidPainter(
                  topEnd: 0.75,
                  topStart: 1,
                  bottomEnd: 1,
                  bottomStart: 1,
                ),
                size: Size(100, 20),
              )
              //这里再弄一个三角形
            ],
          ),
        ),
        SizedBox(
          width: 200,
          height: 99,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: 200,
                child: Container(
                    color: Colors.red,
                    child: Text(
                      this.title,
                      style: titleStyle,
                      overflow: TextOverflow.ellipsis,
                    )),
              ),
              Container(
                  child: Text(
                    this.msg,
                    style: descriptionStyle,
                    overflow: TextOverflow.ellipsis,
                  ))
            ],
          ),
        )
      ],
    );
  }
}
