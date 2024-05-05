import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:redstone_daily_site/selector_dialog.dart';
import 'package:redstone_daily_site/color_schemes.dart';

// TODO: 或许此处应当显示最新一期日报的日期，而非当天（比如在当日早8之前新一期日报还没出来）那就需要将刊期列表的获取和状态存储给提升至整个主页页面了 =又需要一次小重构
class DateTextWidget extends StatelessWidget {
  final TextStyle textStyle;

  const DateTextWidget(this.textStyle, {super.key});

  @override
  Widget build(BuildContext context) {
// 获取当前日期
    DateTime now = DateTime.now();
// 格式化日期为 "yyyy-mm-dd" 形式
    String formattedDate = DateFormat('y.M.d').format(now);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        // onTap: () => showDialog(context: context, builder: chooserDialogBuilderBuilder(RDColors.glass)),
        onTap: () => showSelectorDialog(context: context, colors: RDColors.glass),
        child: Text(
          "[$formattedDate]",
          style: textStyle,
        ),
      ),
    );
  }

}