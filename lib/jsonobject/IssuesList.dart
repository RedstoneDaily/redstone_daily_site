// To parse this JSON data, do
//
//     final newsPaper = newsPaperFromJson(jsonString);

import 'dart:convert';
import 'package:intl/intl.dart';

IssuesList issuesListFromJson(String str) => IssuesList.fromJsonObject(json.decode(str));

// String issuesListToJson(IssuesList data) => json.encode(data.toJsonObject());

class IssuesList {
  /// Guaranteed to be sorted
  List<DateTime> daily;

  IssuesList({
    required this.daily,
  });

  factory IssuesList.fromJsonObject(List<String> jsonObject) => IssuesList(
      daily: jsonObject.map((e) => DateFormat("yyyy-MM-dd").parse(e)).toList()
          ..sort((a, b) => a.compareTo(b)),
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
