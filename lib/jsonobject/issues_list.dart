// To parse this JSON data, do
//
//     final newsPaper = newsPaperFromJson(jsonString);

import 'dart:collection';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:memoize/memoize.dart';

IssuesList parseIssuesList(String str) => IssuesList.fromJson((jsonDecode(str) as List).cast<Map<String, dynamic>>());

// String issuesListToJson(IssuesList data) => json.encode(data.toJsonObject());

class IssuesList {
  /// Guaranteed to be sorted, and not null
  final SplayTreeMap<int, SplayTreeMap<int, SplayTreeMap<DateTime, String>>> daily;

  IssuesList({required this.daily});

  late final dailyLatest = memo0(() => daily.values.last.values.last.entries.last);

  factory IssuesList.fromJson(List<Map<String, dynamic>> jsonObject) => IssuesList(
        daily: (jsonObject.map((e) => MapEntry(DateFormat("yyyy-MM-dd").parse(e["date"]!), e["title"]! as String)).toList()
              ..sort((a, b) => a.key.compareTo(b.key)))
            .fold<SplayTreeMap<int, SplayTreeMap<int, SplayTreeMap<DateTime, String>>>>(
          SplayTreeMap(),
          (SplayTreeMap<int, SplayTreeMap<int, SplayTreeMap<DateTime, String>>> map, MapEntry<DateTime, String> item) {
            final year = item.key.year;
            final month = item.key.month;
            map.putIfAbsent(year, () => SplayTreeMap());
            map[year]!.putIfAbsent(month, () => SplayTreeMap());
            map[year]![month]!.putIfAbsent(item.key, () => item.value);
            return map;
          },
        ),
      );

// Map<int, Map<int, List<String>>> toJsonObject() => daily.map<int, Map<int, List<String>>>(
//     (yearKey, year) => MapEntry(
//         yearKey,
//         year.map((monthKey, month) => MapEntry(
//             monthKey, month.map((day) => day.toString()).toList())
//         )
//     )
// );
}
