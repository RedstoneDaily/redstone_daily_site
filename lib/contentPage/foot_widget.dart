import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redstone_daily_site/color_schemes.dart';

import '../media_type.dart';

class FootWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    var scaling = min(1.0, size.width / MediaType.medium.width);

    var footerTextStyle = TextStyle(
        color: Theme.of(context).colorScheme.onSecondary,
        fontSize: 20 * scaling,
        letterSpacing: 3 * scaling
    );

    // 底部
    return Container(
      height: 100 * scaling, // 设置容器的高度
      width: size.width,
      color: RDColors.scarlet.surface,
      padding: EdgeInsets.all(4.0 * scaling),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            '这里的第一行是各种声明,比如:本报所有内容均由用户生成,本报只做收集与整理,所有内容均与本报无关,就像这样,位占位占位占位占位占',
            style: footerTextStyle,
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
          Text(
            '下面一行可以放一些鸣谢声明,像:本报版面由creepebucket设计,占位占位占位占位位占位占位占位占位占位占位占位占位占位',
            style: footerTextStyle,
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
          Text(
            '在这里放一些东西,就像: 备案号:X公网安备XXX 支持我们:www.afdian.net/XXX 开源链接:github.com/XXX',
            style: footerTextStyle,
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
        ],
      ),
    );
  }

}