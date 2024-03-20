import 'package:flutter/cupertino.dart';
import 'package:redstone_daily_site/tiptest.dart';

class HeadWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _HeadState();
  }

}

class _HeadState extends State<HeadWidget>{
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: 150,
      width: size.width,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.loose,
              alignment: AlignmentDirectional.topStart,
              children: [
                Stack(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            SizedBox(width: size.width*0.4,),
                            Image.asset(
                              'assets/images/header-background.png',
                              fit: BoxFit.fill,
                              width: size.width*0.6,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        child: Text("Daily"),
                        right: 200,
                      ),
                      Positioned(
                        child: Text("日报"),
                        top: 50,
                        right: 200,
                      ),
                    ]
                ),
                Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: [
                    CustomPaint(
                      painter: TrianglePainter(),
                      size: Size(size.width*0.7, 300),
                    ),
                    Positioned(
                      child: Text("红石"),
                      right: 200,
                    ),
                    Positioned(
                      child: Text("Redstone"),
                      right: 200,
                      top: 50,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

}