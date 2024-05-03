import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:redstone_daily_site/color_schemes.dart';
import 'package:redstone_daily_site/jsonobject/IssuesList.dart';
import 'package:redstone_daily_site/underlined_text.dart';

// onTap: () => showDialog(context: context, builder: chooserDialogBuilderBuilder(RDColors.glass)),
Future showChooserDialog({required BuildContext context, required ColorScheme colors}) {
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
                child: SizedBox(
                  width: 700,
                  height: 550,
                  child:
                      // ChooserDialogContent(
                      //   colors: colors,
                      // ),
                      MyFuckingBrilliantIssuePicker(
                    issuesList: IssuesList.fromJsonObject([
                      "2024-04-01",
                      "2024-04-04",
                      "2024-04-23",
                      "2024-04-18",
                      "2024-04-08",
                      "2024-04-03",
                      "2024-04-14",
                      "2024-04-15",
                    ]),
                  ),
                ),
              )),
        );
      });
}

class ChooserDialogContent extends StatelessWidget {
  ChooserDialogContent({super.key, required this.colors});

  final ColorScheme colors;
  final Future<IssuesList> future = Future.value(IssuesList.fromJsonObject([
    "2024-04-01",
    "2024-04-04",
    "2024-04-23",
    "2024-04-18",
    "2024-04-08",
    "2024-04-03",
    "2024-04-14",
    "2024-04-15",
  ]));

  @override
  Widget build(BuildContext context) {
    builder(BuildContext context, AsyncSnapshot<IssuesList> snapshot) {
      IssuesList issuesList = snapshot.data!;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
              flex: 1,
              child: Center(
                child: Text("选择往期日报",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colors.onSurface,
                      fontSize: 20,
                    )),
              )),
          Flexible(
            flex: 4,
            child: CalendarDatePicker(
              initialDate: issuesList.daily.last,
              firstDate: DateTime(2024, 1, 1),
              lastDate: DateTime.now(),
              onDateChanged: (DateTime date) {},
              initialCalendarMode: DatePickerMode.day,
              selectableDayPredicate: (DateTime date) => issuesList.daily.contains(date),
            ),
          )
        ],
      );
    }

    return FutureBuilder(future: future, builder: builder);
  }
}

class MyFuckingBrilliantIssuePicker extends StatefulWidget {
  const MyFuckingBrilliantIssuePicker({super.key, required this.issuesList});

  final IssuesList issuesList;

  @override
  State<MyFuckingBrilliantIssuePicker> createState() => _MyFuckingBrilliantIssuePickerState();
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

  YearMonth operator +(YearMonth other) => YearMonth.fromData(data + other.data);

  YearMonth operator -(YearMonth other) => YearMonth.fromData(data - other.data);

  @override
  String toString() => "$year-$month";
}

class _MyFuckingBrilliantIssuePickerState extends State<MyFuckingBrilliantIssuePicker> {
  IssueTypes issueTypes = IssueTypes.daily;
  late YearMonth yearMonth = YearMonth.fromDateTime(widget.issuesList.daily.last);

  int get pageCount => switch (issueTypes) {
        IssueTypes.daily => 3,
        IssueTypes.weekly => 2,
        IssueTypes.monthly => 2,
        IssueTypes.annual => 1,
      };

  late int page = pageCount - 1;

  var typeSelectorTextStyle = TextStyle(fontSize: 20, color: RDColors.glass.onSurface);
  var navigatorTextStyle = TextStyle(fontSize: 16, color: RDColors.glass.onSurface);

  Widget typeSelector() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("选择往期: ", style: typeSelectorTextStyle),
          UnderlinedText(
            onTap: () => setState(() => issueTypes = IssueTypes.daily),
            text: "日报",
            isUnderlined: issueTypes == IssueTypes.daily,
            style: typeSelectorTextStyle,
          ),
          Text(" / ", style: typeSelectorTextStyle),
          UnderlinedText(
            onTap: () => setState(() => issueTypes = IssueTypes.weekly),
            text: "周报",
            isUnderlined: issueTypes == IssueTypes.weekly,
            style: typeSelectorTextStyle,
          ),
          Text(" / ", style: typeSelectorTextStyle),
          UnderlinedText(
            onTap: () => setState(() => issueTypes = IssueTypes.monthly),
            text: "月报",
            isUnderlined: issueTypes == IssueTypes.monthly,
            style: typeSelectorTextStyle,
          ),
          Text(" / ", style: typeSelectorTextStyle),
          UnderlinedText(
            onTap: () => setState(() => issueTypes = IssueTypes.annual),
            text: "年报",
            isUnderlined: issueTypes == IssueTypes.annual,
            style: typeSelectorTextStyle,
          ),
        ],
      );

  Widget navigator() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              // sb怎么维护个size还搞这么多连环要求
              visible: page > 0,
              child: IconButton(
                onPressed: () => setState(() => switch (page) {
                      1 => yearMonth = yearMonth - YearMonth(year: 1, month: 0),
                      2 => yearMonth = yearMonth - YearMonth(year: 0, month: 1),
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
                  onTap: () => setState(() => page = 0),
                ),
                Visibility(visible: issueTypes == IssueTypes.daily, child: Text(" / ", style: navigatorTextStyle)),
                Visibility(
                  visible: issueTypes == IssueTypes.daily,
                  child: UnderlinedText(
                    text: yearMonth.monthStr,
                    style: navigatorTextStyle,
                    isUnderlined: page == 1,
                    onTap: () => setState(() => page = 1),
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
              visible: page > 0,
              child: IconButton(
                onPressed: () => setState(() => switch (page) {
                      1 => yearMonth = yearMonth + YearMonth(year: 1, month: 0),
                      2 => yearMonth = yearMonth + YearMonth(year: 0, month: 1),
                      _ => {},
                    }),
                icon: const Icon(Icons.arrow_forward),
                color: RDColors.glass.onSurface,
              )),
        ],
      );

  late PageController pageController = PageController(initialPage: page);

  Widget yearSelectPage() => GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisExtent: 100),
        children: widget.issuesList.dailyAvailableYears.map((year) => Center(child: Text("$year"))).toList(),
      );

  Widget monthSelectPage(int year) => GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisExtent: 100),
        children: widget.issuesList.dailyAvailableMonths(year).map((month) => Center(child: Text("$month"))).toList(),
      );

  Widget dailySelectPage(int year, int month) => GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 30),
        children: widget.issuesList
            .dailyAvailableDays(year, month)
            .map((day) => Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')} abflbasbfklasbkfjldbsjafklbasjfklbasdjfklbdsjkablfslj",
                      maxLines: 1,
                    ),
                  ),
                ))
            .toList(),
      );

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
          visible: issueTypes != IssueTypes.annual,
          child: Flexible(flex: 1, fit: FlexFit.tight, child: navigator()),
        ),

        Flexible(
          flex: 7 + (issueTypes == IssueTypes.annual ? 1 : 0),
          fit: FlexFit.tight,
          child: PageView.builder(
            controller: pageController,
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
          ),
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
