// To parse this JSON data, do
//
//     final newsPaper = newsPaperFromJson(jsonString);

import 'dart:collection';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:memoize/memoize.dart';

IssuesList issuesListFromJson(String str) => IssuesList.fromJsonObject(json.decode(str));

// String issuesListToJson(IssuesList data) => json.encode(data.toJsonObject());

class IssuesList {
  /// Guaranteed to be sorted, and not null
  final SplayTreeMap<int, SplayTreeMap<int, List<DateTime>>> daily;

  IssuesList({required this.daily});

  late final dailyLatest = memo0(() => daily.values.last.values.last.last);

  factory IssuesList.fromJsonObject(List<String> jsonObject) => IssuesList(
        daily: _classify(jsonObject.map((e) => DateFormat("yyyy-MM-dd").parse(e)).toList()..sort((a, b) => a.compareTo(b))),
      );

  static _classify(List<DateTime> list) {
    return list.fold<SplayTreeMap<int, SplayTreeMap<int, List<DateTime>>>>(
      SplayTreeMap(),
      (SplayTreeMap<int, SplayTreeMap<int, List<DateTime>>> map, DateTime date) {
        final year = date.year;
        final month = date.month;
        final day = date.day;
        map.putIfAbsent(year, () => SplayTreeMap());
        map[year]!.putIfAbsent(month, () => []);
        map[year]![month]!.add(date);
        return map;
      },
    );
  }

// Map<int, Map<int, List<String>>> toJsonObject() => daily.map<int, Map<int, List<String>>>(
//     (yearKey, year) => MapEntry(
//         yearKey,
//         year.map((monthKey, month) => MapEntry(
//             monthKey, month.map((day) => day.toString()).toList())
//         )
//     )
// );
}
