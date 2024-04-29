import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class DateTextWidget extends StatelessWidget {
  final TextStyle textStyle;

  const DateTextWidget(this.textStyle, {super.key});

  @override
  Widget build(BuildContext context) {
// 获取当前日期
    DateTime now = DateTime.now();
// 格式化日期为 "yyyy-mm-dd" 形式
    String formattedDate = DateFormat('y.M.d').format(now);

    return Text(
      "[$formattedDate]",
      style: textStyle,
    );
  }

}