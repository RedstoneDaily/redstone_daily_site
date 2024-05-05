import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:redstone_daily_site/color_schemes.dart';
import 'package:redstone_daily_site/hover_clickable_container.dart';
import 'package:redstone_daily_site/jsonobject/issues_list.dart';
import 'package:redstone_daily_site/underlined_text.dart';

// onTap: () => showDialog(context: context, builder: chooserDialogBuilderBuilder(RDColors.glass)),
Future showSelectorDialog({required BuildContext context, required ColorScheme colors}) {
  return showDialog(
      context: context,
      barrierColor: const Color(0x45000000),
      builder: (BuildContext context) {
        return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Dialog(
              shape: const RoundedRectangleBorder(), // actually not rounded at all
              // shadowColor: const Color(0x22FFFFFF),
              backgroundColor: colors.surface,
              surfaceTintColor: const Color(0x00000000), // sb
              child: Theme(
                  data: ThemeData(
                    colorScheme: colors,
                  ),
                  child: const SizedBox(
                    width: 700,
                    height: 550,
                    child: SelectorDialogContent(),
                  )),
            ));
      });
}

class SelectorDialogContent extends StatefulWidget {
  const SelectorDialogContent({super.key});

  @override
  State<StatefulWidget> createState() => _SelectorDialogContentState();
}

class _SelectorDialogContentState extends State<SelectorDialogContent> {
  late final Future<IssuesList> _fetchListFuture;

  Future<String> fetchData(BuildContext context) async {
    const String apiHost = String.fromEnvironment('API_HOST', defaultValue: 'localhost');
    Uri uri = Uri.http(apiHost, '/api/list');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to load the newspaper content. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error occurred: $error');
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState();
    // final Future<IssuesList> future = Future.value(IssuesList.fromJsonObject([
    //   {"date": "2024-04-04", "title": "你的钢门比较松弛"},
    //   {"date": "2024-04-05", "title": "但是你的痔疮呢又弥补了这一部分"},
    //   {"date": "2024-04-06", "title": "如果做痔疮手术"},
    //   {"date": "2024-04-07", "title": "把痔疮切除的话"},
    //   {"date": "2024-04-08", "title": "可能就会显得你的钢门就比较大"},
    //   {"date": "2024-04-09", "title": "可能会有一些漏液漏气的情况"},
    //   {"date": "2024-04-10", "title": "现在最好的办法就是"},
    //   {"date": "2024-04-11", "title": "在做痔疮的同时"},
    //   {"date": "2024-04-12", "title": "给你做一个钢门紧缩术"}
    // ]));
    _fetchListFuture = fetchData(context).then((data) => compute(parseIssuesList, data));
  }

  @override
  Widget build(BuildContext context) {
    builder(BuildContext context, AsyncSnapshot<IssuesList> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // 当Future还未完成时，显示加载中的UI
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        // 当Future发生错误时，显示错误提示的UI
        return Center(child: Text('获取数据失败，请重试', style: TextStyle(fontSize: 16, color: RDColors.glass.onSurface)));
      } else {
        // 当Future成功完成时，显示数据
        return IssueSelector(issuesList: snapshot.data!);
      }
    }

    return FutureBuilder(future: _fetchListFuture, builder: builder);
  }
}

class IssueSelector extends StatefulWidget {
  const IssueSelector({super.key, required this.issuesList});

  final IssuesList issuesList;

  @override
  State<IssueSelector> createState() => _IssueSelectorState();
}

class YearMonth {
  final int data; // = year + month * 12
  YearMonth({required year, required month}) : data = year * 12 + month;

  YearMonth.fromData(this.data);

  YearMonth.fromDateTime(DateTime date) : data = date.year * 12 + date.month;

  int get year => data ~/ 12;

  int get month => data % 12;

  String get yearStr => "$year";

  String get monthStr => month < 10 ? "0$month" : "$month";

  @override
  String toString() => "$year-$month";
}

class _IssueSelectorState extends State<IssueSelector> with SingleTickerProviderStateMixin {
  IssueTypes issueType = IssueTypes.daily;
  late YearMonth yearMonth = YearMonth.fromDateTime(widget.issuesList.dailyLatest().key);

  int get pageCount => switch (issueType) {
        IssueTypes.daily => 3,
        IssueTypes.weekly => 2,
        IssueTypes.monthly => 2,
        IssueTypes.annual => 1,
      };

  late int page = pageCount - 1;

  var typeSelectorTextStyle = TextStyle(fontSize: 21, color: RDColors.glass.onSurface);
  var navigatorTextStyle = TextStyle(fontSize: 16, color: RDColors.glass.onSurface);
  var yearMonthTextStyle = TextStyle(fontSize: 18, color: RDColors.glass.onSurface);
  var issueTextStyle = TextStyle(fontSize: 16, color: RDColors.glass.onSurface);

  Widget typeSelector() => Container(
      color: const Color(0x80740000),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("选择往期: ", style: typeSelectorTextStyle),
          UnderlinedText(
            onTap: () => setState(() {
              issueType = IssueTypes.daily;
              yearMonth = YearMonth.fromDateTime(widget.issuesList.dailyLatest().key);
            }),
            text: "日报",
            isUnderlined: issueType == IssueTypes.daily,
            style: typeSelectorTextStyle,
          ),
          // Text(" / ", style: typeSelectorTextStyle),
          // UnderlinedText(
          //   onTap: () => setState(() => issueTypes = IssueTypes.weekly),
          //   text: "周报",
          //   isUnderlined: issueTypes == IssueTypes.weekly,
          //   style: typeSelectorTextStyle,
          // ),
          // Text(" / ", style: typeSelectorTextStyle),
          // UnderlinedText(
          //   onTap: () => setState(() => issueTypes = IssueTypes.monthly),
          //   text: "月报",
          //   isUnderlined: issueTypes == IssueTypes.monthly,
          //   style: typeSelectorTextStyle,
          // ),
          // Text(" / ", style: typeSelectorTextStyle),
          // UnderlinedText(
          //   onTap: () => setState(() => issueTypes = IssueTypes.annual),
          //   text: "年报",
          //   isUnderlined: issueTypes == IssueTypes.annual,
          //   style: typeSelectorTextStyle,
          // ),
        ],
      ));

  Widget navigator() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              // sb怎么维护个size还搞这么多连环要求
              visible: switch (page) {
                1 => yearMonth.year > widget.issuesList.daily.keys.first,
                2 => yearMonth.month > widget.issuesList.daily[yearMonth.year]!.keys.first || yearMonth.year > widget.issuesList.daily.keys.first,
                _ => false,
              },
              child: IconButton(
                onPressed: () => setState(() => switch (page) {
                      1 => yearMonth = prevYear(yearMonth, widget.issuesList, issueType),
                      2 => yearMonth = prevYearMonth(yearMonth, widget.issuesList, issueType),
                      _ => {},
                    }),
                icon: const Icon(Icons.arrow_back),
                color: RDColors.glass.onSurface,
              )),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UnderlinedText(
                  text: yearMonth.yearStr,
                  style: navigatorTextStyle,
                  isUnderlined: page == 0,
                  onTap: () => gotoPage(0),
                ),
                Visibility(visible: issueType == IssueTypes.daily, child: Text(" / ", style: navigatorTextStyle)),
                Visibility(
                  visible: issueType == IssueTypes.daily,
                  child: UnderlinedText(
                    text: yearMonth.monthStr,
                    style: navigatorTextStyle,
                    isUnderlined: page == 1,
                    onTap: () => gotoPage(1),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              // sb怎么维护个size还搞这么多连环要求*2
              visible: switch (page) {
                1 => yearMonth.year < widget.issuesList.daily.keys.last,
                2 => yearMonth.month < widget.issuesList.daily[yearMonth.year]!.keys.last || yearMonth.year < widget.issuesList.daily.keys.last,
                _ => false,
              },
              child: IconButton(
                onPressed: () => setState(() => switch (page) {
                      1 => yearMonth = nextYear(yearMonth, widget.issuesList, issueType),
                      2 => yearMonth = nextYearMonth(yearMonth, widget.issuesList, issueType),
                      _ => {},
                    }),
                icon: const Icon(Icons.arrow_forward),
                color: RDColors.glass.onSurface,
              )),
        ],
      );

  Widget item({required void Function() onTap, required Widget child}) =>
      HoverClickableContainer(onTap: onTap, highlightColor: const Color(0x22FFFFFF), child: child);

  Widget yearSelectPage() => GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisExtent: 100),
        children: widget.issuesList.daily.keys
            .map((year) => item(
                onTap: () {
                  setState(() => yearMonth = YearMonth(year: year, month: widget.issuesList.daily[year]!.keys.first));
                  gotoPage(page + 1);
                },
                child: Center(child: Text("$year", style: yearMonthTextStyle))))
            .toList(),
      );

  Widget monthSelectPage(int year) => widget.issuesList.daily[year] != null
      ? GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisExtent: 100),
          children: widget.issuesList.daily[year]!.keys
              .map((month) => item(
                  onTap: () {
                    setState(() => yearMonth = YearMonth(year: year, month: month));
                    gotoPage(page + 1);
                  },
                  child: Center(child: Text("$month月", style: yearMonthTextStyle))))
              .toList(),
        )
      : Container();

  Widget dailySelectPage(int year, int month) => widget.issuesList.daily[year]?[month] != null
      ? GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 30),
          children: widget.issuesList.daily[year]![month]!
              .map((date, title) => MapEntry(
                  date,
                  item(
                      onTap: () => context.go("/daily/${date.year}/${date.month}/${date.day}"),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(children: [
                                SizedBox(width: 60, child: Text(DateFormat("MM.dd").format(date), maxLines: 1, style: issueTextStyle)),
                                Expanded(child: Text(title, maxLines: 1, style: issueTextStyle)),
                              ]))))))
              .values
              .toList(),
        )
      : Container();

  late final PageController _pageController = PageController(initialPage: page);

  late AnimationController _fadeController;

  bool _isFadeIn = true;

  int _targetPageIndex = 0;

  // Function to trigger the fade-in/fade-out animation to a specific page
  void gotoPage(int targetIndex) {
    _targetPageIndex = targetIndex;
    _fadeController.forward();
  }

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(vsync: this, duration: const Duration(milliseconds: 50));
    _fadeController.addListener(() {
      if (_fadeController.isCompleted) {
        if (_isFadeIn) {
          setState(() {
            page = _targetPageIndex;
            _isFadeIn = !_isFadeIn;
          });
          _pageController.jumpToPage(_targetPageIndex);
          _fadeController.reset();
          _fadeController.forward();
        } else {
          setState(() => _isFadeIn = !_isFadeIn);
          _fadeController.reset();
        }
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: [
        // First, a selector for types: daily, weekly, monthly, annual
        Flexible(flex: 1, fit: FlexFit.tight, child: typeSelector()),

        // Second, a navigation bar
        // daily: "yyyy / MM" with nav arrows
        // weekly: "yyyy" with nav arrows
        // monthly: "yyyy" with nav arrows
        // annual: no navigation bar
        Visibility(
          visible: issueType != IssueTypes.annual,
          child: Flexible(flex: 1, fit: FlexFit.tight, child: navigator()),
        ),

        // Third, page view
        Flexible(
          flex: 7 + (issueType == IssueTypes.annual ? 1 : 0),
          fit: FlexFit.tight,
          child: AnimatedBuilder(
              animation: _fadeController,
              builder: (context, child) => Opacity(
                  opacity: _isFadeIn ? 1 - _fadeController.value : _fadeController.value,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: pageCount,
                    itemBuilder: (BuildContext context, int index) {
                      switch (index) {
                        case 0:
                          return yearSelectPage();
                        case 1:
                          return monthSelectPage(yearMonth.year);
                        case 2:
                          return dailySelectPage(yearMonth.year, yearMonth.month);
                        default:
                          return Container();
                      }
                    },
                  ))),
        ),
      ],
    );
  }
}

enum IssueTypes {
  daily,
  weekly,
  monthly,
  annual,
}

// 以下内容......有一种打Rr的美（
YearMonth nextYearMonth(YearMonth yearMonth, IssuesList issuesList, IssueTypes issueTypes) {
  switch (issueTypes) {
    case IssueTypes.daily:
      YearMonth defaultYearMonth = YearMonth.fromDateTime(issuesList.dailyLatest().key);
      int yearIndex = issuesList.daily.keys.toList().indexOf(yearMonth.year);
      if (yearIndex == -1) return defaultYearMonth;
      int monthIndex = issuesList.daily[yearMonth.year]!.keys.toList().indexOf(yearMonth.month);
      if (monthIndex == -1) return defaultYearMonth;
      if (monthIndex < issuesList.daily[yearMonth.year]!.keys.length - 1) {
        return YearMonth(year: yearMonth.year, month: issuesList.daily[yearMonth.year]!.keys.elementAt(monthIndex + 1));
      }
      if (yearIndex < issuesList.daily.keys.length - 1) {
        int nextYear = issuesList.daily.keys.elementAt(yearIndex + 1);
        return YearMonth(year: nextYear, month: issuesList.daily[nextYear]!.keys.first);
      }
      return yearMonth;
    default:
      return yearMonth;
  }
}

YearMonth prevYearMonth(YearMonth yearMonth, IssuesList issuesList, IssueTypes issueTypes) {
  switch (issueTypes) {
    case IssueTypes.daily:
      YearMonth defaultYearMonth = YearMonth.fromDateTime(issuesList.dailyLatest().key);
      int yearIndex = issuesList.daily.keys.toList().indexOf(yearMonth.year);
      if (yearIndex == -1) return defaultYearMonth;
      int monthIndex = issuesList.daily[yearMonth.year]!.keys.toList().indexOf(yearMonth.month);
      if (monthIndex == -1) return defaultYearMonth;
      if (monthIndex > 0) {
        return YearMonth(year: yearMonth.year, month: issuesList.daily[yearMonth.year]!.keys.elementAt(monthIndex - 1));
      }
      if (yearIndex > 0) {
        int prevYear = issuesList.daily.keys.elementAt(yearIndex - 1);
        return YearMonth(year: prevYear, month: issuesList.daily[prevYear]!.keys.last);
      }
      return yearMonth;
    default:
      return yearMonth;
  }
}

YearMonth nextYear(YearMonth yearMonth, IssuesList issuesList, IssueTypes issueTypes) {
  switch (issueTypes) {
    case IssueTypes.daily:
      YearMonth defaultYearMonth = YearMonth.fromDateTime(issuesList.dailyLatest().key);
      int yearIndex = issuesList.daily.keys.toList().indexOf(yearMonth.year);
      if (yearIndex == -1) return defaultYearMonth;
      if (yearIndex < issuesList.daily.keys.length - 1) {
        int nextYear = issuesList.daily.keys.elementAt(yearIndex + 1);
        return YearMonth(year: nextYear, month: issuesList.daily[nextYear]!.keys.first);
      }
      int monthIndex = issuesList.daily[yearMonth.year]!.keys.toList().indexOf(yearMonth.month);
      if (monthIndex == -1) return defaultYearMonth;
      return yearMonth;
    default:
      return yearMonth;
  }
}

YearMonth prevYear(YearMonth yearMonth, IssuesList issuesList, IssueTypes issueTypes) {
  switch (issueTypes) {
    case IssueTypes.daily:
      YearMonth defaultYearMonth = YearMonth.fromDateTime(issuesList.dailyLatest().key);
      int yearIndex = issuesList.daily.keys.toList().indexOf(yearMonth.year);
      if (yearIndex == -1) return defaultYearMonth;
      if (yearIndex > 0) {
        int prevYear = issuesList.daily.keys.elementAt(yearIndex - 1);
        return YearMonth(year: prevYear, month: issuesList.daily[prevYear]!.keys.first);
      }
      int monthIndex = issuesList.daily[yearMonth.year]!.keys.toList().indexOf(yearMonth.month);
      if (monthIndex == -1) return defaultYearMonth;
      return yearMonth;
    default:
      return yearMonth;
  }
}
